From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 12 Jan 2017 13:21:44 +0900
Subject: [PATCH v29 4/9] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20170111105405.GF12388@arm.com>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-3-takahiro.akashi@linaro.org>
 <20170110113248.GC21598@arm.com>
 <20170111063626.GE20972@linaro.org>
 <20170111105405.GF12388@arm.com>
Message-ID: <20170112042143.GF20972@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 10:54:05AM +0000, Will Deacon wrote:
> On Wed, Jan 11, 2017 at 03:36:28PM +0900, AKASHI Takahiro wrote:
> > On Tue, Jan 10, 2017 at 11:32:48AM +0000, Will Deacon wrote:
> > > On Wed, Dec 28, 2016 at 01:36:01PM +0900, AKASHI Takahiro wrote:
> > > > @@ -22,6 +25,7 @@
> > > >  extern const unsigned char arm64_relocate_new_kernel[];
> > > >  extern const unsigned long arm64_relocate_new_kernel_size;
> > > >  
> > > > +static bool in_crash_kexec;
> > > 
> > > Do you actually need this bool? Why not call kexec_crash_loaded() instead?
> > 
> > The two have different meanings:
> > "in_crash_kexec" indicates that kdump is taking place, while
> > kexec_crash_loaded() tells us only whether crash dump kernel has been
> > loaded or not.
> > 
> > It is crucial to distinguish them especially for machine_kexec()
> > which can be called on normal kexec even if kdump has been set up.
> 
> Ah, I see. So how about just doing:
> 
>   if (kimage == kexec_crash_image)
> 
> in machine_kexec?

Yeah, it should work.
Do you want to merge the following hunk,
or expect that I will re-send the whole patch series
(with other changes if any)?

-Takahiro AkASHI

> Will
===8<==
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 994fe0bc5cc0..c0fc3d458195 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -26,7 +26,6 @@
 extern const unsigned char arm64_relocate_new_kernel[];
 extern const unsigned long arm64_relocate_new_kernel_size;
 
-static bool in_crash_kexec;
 static unsigned long kimage_start;
 
 /**
@@ -154,7 +153,7 @@ void machine_kexec(struct kimage *kimage)
 	 * New cpus may have become stuck_in_kernel after we loaded the image.
 	 */
 	BUG_ON((cpus_are_stuck_in_kernel() || (num_online_cpus() > 1)) &&
-			!WARN_ON(in_crash_kexec));
+			!WARN_ON(kimage == kexec_crash_image));
 
 	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
 	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
@@ -206,8 +205,8 @@ void machine_kexec(struct kimage *kimage)
 	 * relocation is complete.
 	 */
 
-	cpu_soft_restart(!in_crash_kexec, reboot_code_buffer_phys, kimage->head,
-		kimage_start, 0);
+	cpu_soft_restart(kimage != kexec_crash_image,
+		reboot_code_buffer_phys, kimage->head, kimage_start, 0);
 
 	BUG(); /* Should never get here. */
 }
@@ -250,8 +249,6 @@ void machine_crash_shutdown(struct pt_regs *regs)
 {
 	local_irq_disable();
 
-	in_crash_kexec = true;
-
 	/* shutdown non-crashing cpus */
 	smp_send_crash_stop();
 
