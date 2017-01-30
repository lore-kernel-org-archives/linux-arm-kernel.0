From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 30 Jan 2017 17:27:51 +0900
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170127171513.GA3119@fireball>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
 <5888E262.4050208@arm.com> <20170126112811.GG23406@linaro.org>
 <588B2CC4.70904@arm.com> <20170127171513.GA3119@fireball>
Message-ID: <20170130082749.GH23406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Sat, Jan 28, 2017 at 02:15:16AM +0900, AKASHI Takahiro wrote:
> James,
> 
> On Fri, Jan 27, 2017 at 11:19:32AM +0000, James Morse wrote:
> > Hi Akashi,
> > 
> > On 26/01/17 11:28, AKASHI Takahiro wrote:
> > > On Wed, Jan 25, 2017 at 05:37:38PM +0000, James Morse wrote:
> > >> On 24/01/17 08:49, AKASHI Takahiro wrote:
> > >>> To protect the memory reserved for crash dump kernel once after loaded,
> > >>> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> > >>> permissions of the corresponding kernel mappings.
> > >>>
> > >>> We also have to
> > >>> - put the region in an isolated mapping, and
> > >>> - move copying kexec's control_code_page to machine_kexec_prepare()
> > >>> so that the region will be completely read-only after loading.
> > >>
> > >>
> > >>> Note that the region must reside in linear mapping and have corresponding
> > >>> page structures in order to be potentially freed by shrinking it through
> > >>> /sys/kernel/kexec_crash_size.
> > >>
> > >> Nasty! Presumably you have to build the crash region out of individual page
> > >> mappings,
> > > 
> > > This might be an alternative, but
> > > 
> > >> so that they can be returned to the slab-allocator one page at a time,
> > >> and still be able to set/clear the valid bits on the remaining chunk.
> > >> (I don't see how that happens in this patch)
> > > 
> > > As far as shrinking feature is concerned, I believe, crash_shrink_memory(),
> > > which eventually calls free_reserved_page(), will take care of all the things
> > > to do. I can see increased number of "MemFree" in /proc/meminfo.
> > 
> > Except for arch specific stuff like reformatting the page tables. Maybe I've
> > overlooked the way out this. What happens with this scenario:
> > 
> > We boot with crashkernel=1G on the commandline.
> > Memblock_reserve allocates a naturally aligned 1GB block of memory for the crash
> > region.
> > Your code in __map_memblock() calls __create_pgd_mapping() ->
> > alloc_init_pud() which decides use_1G_block() looks like a good idea.
> > 
> > Some time later, the user decides to free half of this region,
> > free_reserved_page() does its thing and half of those struct page's now belong
> > to the memory allocator.
> > 
> > Now we load a kdump kernel, which causes arch_kexec_protect_crashkres() to be
> > called for the 512MB region that was left.
> > 
> > create_mapping_late() needs to split the 1GB mapping it originally made into a
> > smaller table, with the first half using PAGE_KERNEL_INVALID, and the second
> > half using PAGE_KERNEL. It can't do break-before-make because these pages may be
> > in-use by another CPU because we gave them back to the memory allocator. (in the
> > worst-possible world, that second half contains our stack!)
> 
> Yeah, this is a horrible case.
> Now I understand why we should stick with page_mapping_only option.
> 
> > 
> > Making this behave more like debug_pagealloc where the region is only built of
> > page-size mappings should avoid this. The smallest change to what you have is to
> > always pass page_mappings_only for the kdump region.
> > 
> > Ideally we just disable this resize feature for ARM64 and support it with some
> > later kernel version, but I can't see a way of doing this without adding Kconfig
> > symbols to other architectures.
> > 
> > 
> > > (Please note that the region is memblock_reserve()'d at boot time.)
> > 
> > And free_reserved_page() does nothing to update memblock, so
> > memblock_is_reserved() says these pages are reserved, but in reality they
> > are in use by the memory allocator. This doesn't feel right.
> 
> Just FYI, no other architectures take care of this issue.
> 
> (and I don't know whether the memblock is reserved or not may have
> any impact after booting.)
> 
> > (Fortunately we can override crash_free_reserved_phys_range() so this can
> >  probably be fixed)
> > 
> > >> This secretly-unmapped is the sort of thing that breaks hibernate, it blindly
> > >> assumes pfn_valid() means it can access the page if it wants to. Setting
> > >> PG_Reserved is a quick way to trick it out of doing this, but that would leave
> > >> the crash kernel region un-initialised after resume, while kexec_crash_image
> > >> still has a value.
> > > 
> > > Ouch, I didn't notice this issue.
> > > 
> > >> I think the best fix for this is to forbid hibernate if kexec_crash_loaded()
> > >> arguing these are mutually-exclusive features, and the protect crash-dump
> > >> feature exists to prevent things like hibernate corrupting the crash region.
> > > 
> > > This restriction is really painful.
> > > Is there any hibernation hook that will be invoked before suspending and
> > > after resuming? If so, arch_kexec_unprotect_crashkres()/protect_crashkres()
> > > will be able to be called.
> > 
> > Those calls could go in swsusp_arch_suspend() in /arch/arm64/kernel/hibernate.c,
> 
> I will give it a try next week.

I took the following test scenario:
 - load the crash dump kernel
 - echo shutdown > /sys/power/disk
 - echo disk > /sys/power/state
 - power off and on the board
 - reboot with resume=...
 - after hibernate done, echo c > /proc/sysrq-trigger
 - after reboot, check /proc/vmcore

and everything looks to work fine.

If you think I'd better try more test cases, please let me know.

Thanks,
-Takahiro AKASHI
===8<===
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index fe301cbcb442..111a849333ee 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -16,6 +16,7 @@
  */
 #define pr_fmt(x) "hibernate: " x
 #include <linux/cpu.h>
+#include <linux/kexec.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/pm.h>
@@ -289,6 +290,12 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region mapped */
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+#endif
+
 		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
@@ -300,6 +307,12 @@ int swsusp_arch_suspend(void)
 		if (el2_reset_needed())
 			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 
+#ifdef CONFIG_KEXEC_CORE
+		/* make the crash dump kernel region unmapped */
+		if (kexec_crash_image)
+			arch_kexec_protect_crashkres();
+#endif
+
 		/*
 		 * Tell the hibernation core that we've just restored
 		 * the memory
