From: bhe@redhat.com (Baoquan He)
Date: Tue, 27 Nov 2018 14:48:16 +0800
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
In-Reply-To: <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
 <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
Message-ID: <20181127064816.GE1824@MiWiFi-R3L-srv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 at 01:01am, Bhupesh Sharma wrote:
> > But it's not live debugging feature of makedumpfile. Makedumpfile can't be
> > used to live debug. The feature is called '--mem-usage' in makedumpfile,
> > in fact it's used to estimate how big the vmcore could be so that customer
> > can deply an appropriate size of storage space to store it. Because both
> > kcore and vmcore are all elf files which the 1st kernel's memory is
> > mapped to, even though they are different, kcore is dynamically changing.
> > This is more likely a precision in order of of magnitude. This is a feature
> > required by redhat customer.
> 
> Indeed this is a live debugging feature - see we are running this in
> the primary kernel
> context, not in kdump context. We are trying to debug a kernel we are
> presently running (in this case determining the page mapping)
> hence the term live debugging.

Thanks for redefining '--mem-usage' of makedumpfile as a live debugging
feature. I am the author of this feature, I don't know it has this
awesome attribute. Can you post patch to refresh it's doc or man page
about this live debugging thing? I think it's important, I am
astonished. I noticed Boris said you are adding this to support live
debug, just not sure if he is misled by you, or he also think this
vmcore size estimating feature of makedumpfile is live debugging
feature. 

> 
> Also, this feature is not limited to redhat - we are talking in
> upstream makedumpfile context here - it is used by other projects as
> well which can have even a simple busybox rootfs configuration (e.g.
> qemu).

Yes, it's not limited to redhat, I am just saying its origin.

> 
> > I thought you are talking about using DaveA's crash utility to live
> > debug the running kernel, like we usually do with gdb.
> >
> >         gdb vmlinux /proc/kcore
> >
> > Yes, this gdb live debugging is broken because of KASLR. We have bug about
> > this, while it has not been fixed. Using Crash utility to replace gdb is
> > one way if Crash code is adjusted.

......

> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > index 4c8acdfdc5a7..6161d77c5bfb 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> > >       VMCOREINFO_SYMBOL(init_top_pgt);
> > >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> > >                       pgtable_l5_enabled());
> > > +#ifdef CONFIG_RANDOMIZE_BASE
> >
> > Finally, embracing it into CONFIG_RANDOMIZE_BASE ifdefery seems not
> > right. The latest kernel is using page_offset_base to do the dynamic
> > memory layout between level4 and level5 changing. This may not work in
> > 5-level system with CONFIG_RANDOMIZE_BASE=n.
> 
> I think you missed the v2 change log and the build-bot error on v1
> (see here: <https://patchwork.kernel.org/patch/10657933/#22291691>).
> With .config files which have CONFIG_RANDOMIZE_BASE=n, we get the
> following compilation error
> without the #ifdef jugglery:

Which line of your v2 change log did I miss?

Ask again, what if I set
CONFIG_DYNAMIC_MEMORY_LAYOUT=y && CONFIG_RANDOMIZE_MEMORY=n
in a kernel with LEVEL5 enabled to make kernel be able to switch
into l4 and l5 dynamically?

Is there anything wrong if I add it like this:

#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
	VMCOREINFO_SYMBOL(node_data);
#endif

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
EXPORT_SYMBOL(page_offset_base);
...
#endif

config DYNAMIC_MEMORY_LAYOUT
        bool
        ---help---
          This option makes base addresses of vmalloc and vmemmap as well as
          __PAGE_OFFSET movable during boot.

config RANDOMIZE_MEMORY
        bool "Randomize the kernel memory sections"
        depends on X86_64
        depends on RANDOMIZE_BASE
        select DYNAMIC_MEMORY_LAYOUT
        default RANDOMIZE_BASE
        ---help---
           Randomizes the base virtual address of kernel memory sections
           (physical memory mapping, vmalloc & vmemmap). This security feature
           makes exploits relying on predictable memory locations less reliable.

           The order of allocations remains unchanged. Entropy is generated in
           the same way as RANDOMIZE_BASE. Current implementation in the optimal
           configuration have in average 30,000 different possible virtual
           addresses for each memory section.

           If unsure, say Y.

> 
>  arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
>  arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
> `page_offset_base'
>  arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
> `page_offset_base'
> 
> Anyways, with Kazu's and Boris's comments on the v2, I understand that
> adding 'page_offset_base' variable to vmcoreinfo is useful for x86
> kernel.

Please notice that the makedumpfile '--mem-usage' bug has been fixed by
below commit. Adding 'page_offset_base' into vmcoreinfo is 50:50 to
me. Adding it to vmcoreinfo to expose, or deducing it from kcore/vmcore
program segment, both is fine to me since both has pro and con. Adding
it you have to give a good log, based on good understanding, but
not those confusing self invented term and the useless test results,
and wrong code.

commit 1ea989bf6a93db377689c16b61e9c2c6a9bafa17 (HEAD -> devel, origin/devel)
Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Date:   Wed Nov 21 13:57:31 2018 -0500

    [PATCH] x86_64: fix failure of getting kcore vmcoreinfo on kernel 4.19

> I will now work on the v3 to take into account review comments and
> also work with Lianbo to get the same added to the overall vmcoreinfo
> documentation he is preparing for x86.

So please do not post new version directly without replying to confirm if
we have agreement on concerns, then saying that is requested by me or
other people.

Thanks
Baoquan
