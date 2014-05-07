From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 7 May 2014 11:45:21 +0100
Subject: [Xen-devel] [PATCH] Xen: hibernation is x86-only at the moment
In-Reply-To: <536905B5.6040900@citrix.com>
References: <5165529.jneGVBC5b5@wuerfel> <5360C1A7.8060401@citrix.com>
 <alpine.DEB.2.02.1405061402520.14596@kaball.uk.xensource.com>
 <536905B5.6040900@citrix.com>
Message-ID: <alpine.DEB.2.02.1405071133240.14596@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 May 2014, David Vrabel wrote:
> On 06/05/14 14:35, Stefano Stabellini wrote:
> > On Wed, 30 Apr 2014, David Vrabel wrote:
> >> On 29/04/14 21:00, Arnd Bergmann wrote:
> >>> In commit 603fb42a66499ab "ARM: 8011/1: ARM hibernation / suspend-to-disk",
> >>> currently in linux-next, the ARM architecture gains support for
> >>> hibernation (suspend-to-disk). Xen supports this in principle, but only
> >>> has an architecture specific hypercall defined on x86, which leads
> >>> to a build error when both hibernation and Xen support are enabled:
> >>>
> >>> drivers/xen/manage.c:105:2: error: implicit declaration of function 'HYPERVISOR_suspend' [-Werror=implicit-function-declaration]
> >>>   si->cancelled = HYPERVISOR_suspend(si->arg);
> >>>
> >>> It is probably a good idea to define this hypercall on ARM as well
> >>> and provide an implementation in the host, but until that is done,
> >>> this patch helps disable the broken code in the Xen guest by making
> >>> it depend on CONFIG_X86.
> > 
> > Thanks Arnd.
> > 
> > 
> >> Since this isn't a regression in 3.15-rcX can you provide the
> >> appropriate hypercall on ARM.  This does not require that there is an
> >> implementation on Xen.
> >>
> >> When the Xen implementation exists it will be easier to use if the
> >> support already exists in Linux.
> > 
> > 
> > The sched_on hypercall is already implemented on ARM.
> > However SCHEDOP_shutdown, defined as it is now, is unusable on ARM:
> > 
> > /*
> >  * Halt execution of this domain (all VCPUs) and notify the system controller.
> >  * @arg == pointer to sched_shutdown_t structure.
> >  *
> >  * If the sched_shutdown_t reason is SHUTDOWN_suspend then this
> >  * hypercall takes an additional extra argument which should be the
> >  * MFN of the guest's start_info_t.
> >  *
> >  * In addition, which reason is SHUTDOWN_suspend this hypercall
> >  * returns 1 if suspend was cancelled or the domain was merely
> >  * checkpointed, and 0 if it is resuming in a new domain.
> >  */
> > #define SCHEDOP_shutdown    2
> > 
> > 
> > We don't have a start_info, and even if we had, we wouldn't know the
> > MFN.
> > I think we should make it available on ARM only if we change the
> > interface making the third argument x86 only.  Of course that would
> > impact the linux side implementation too.
> 
> We do not want a different number of arguments to this hypercall.  Just
> pass 0 for the MFN.  This hypercall docs should be updated to say this.
> 
> This doesn't seem any different to x86 HVM where the start_info_mfn
> parameter is also not relevant.
> 
> 	if (xen_hvm_domain()) {
> 		si.arg = 0UL;
> 		si.pre = NULL;
> 		si.post = &xen_hvm_post_suspend;
> 	} else {
> 		si.arg = virt_to_mfn(xen_start_info);
> 		si.pre = &xen_pre_suspend;
> 		si.post = &xen_post_suspend;
> 	}
> 
> Changing this to be !xen_pv_domain() would then do the right thing for arm.

xen_hvm_domain returns true on arm so that's not needed.
Unfortunately the patch turns out a bit ugly because of the way
hypercalls are implemented in assembly on arm and arm64.
Also I needed to provide quite a few empty stubs for other xen arch
specific functions.




diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 7704e28..6d6ddc5 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -34,6 +34,7 @@
 #define _ASM_ARM_XEN_HYPERCALL_H
 
 #include <xen/interface/xen.h>
+#include <xen/interface/sched.h>
 
 long privcmd_call(unsigned call, unsigned long a1,
 		unsigned long a2, unsigned long a3,
@@ -48,6 +49,16 @@ int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
 int HYPERVISOR_tmem_op(void *arg);
+int HYPERVISOR_sched_op_shutdown(int cmd, void *arg, unsigned long unused);
+
+static inline int
+HYPERVISOR_suspend(unsigned long start_info_mfn)
+{
+	struct sched_shutdown r = { .reason = SHUTDOWN_suspend };
+
+	/* start_info_mfn is unused on ARM, pass 0 instead */
+	return HYPERVISOR_sched_op_shutdown(SCHEDOP_shutdown, &r, 0);
+}
 
 static inline void
 MULTI_update_va_mapping(struct multicall_entry *mcl, unsigned long va,
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index b96723e..6d88c18 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -339,6 +339,17 @@ static int __init xen_pm_init(void)
 }
 late_initcall(xen_pm_init);
 
+
+/* empty stubs */
+void xen_arch_pre_suspend(void) { }
+void xen_arch_post_suspend(int suspend_cancelled) { }
+void xen_arch_hvm_post_suspend(int suspend_cancelled) { }
+void xen_mm_pin_all(void) { }
+void xen_mm_unpin_all(void) { }
+void xen_timer_resume(void) { }
+void xen_arch_resume(void) { }
+
+
 /* In the hypervisor.S file. */
 EXPORT_SYMBOL_GPL(HYPERVISOR_event_channel_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_grant_table_op);
@@ -351,3 +362,4 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
 EXPORT_SYMBOL_GPL(privcmd_call);
+EXPORT_SYMBOL_GPL(HYPERVISOR_sched_op_shutdown);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index d1cf7b7..7da8837 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -102,3 +102,9 @@ ENTRY(privcmd_call)
 	ldm sp!, {r4}
 	mov pc, lr
 ENDPROC(privcmd_call);
+
+ENTRY(HYPERVISOR_sched_op_shutdown)
+	mov r12, #__HYPERVISOR_sched_op
+	__HVC(XEN_IMM)
+	mov pc, lr
+ENDPROC(HYPERVISOR_sched_op_shutdown)
