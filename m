From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 12:25:33 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <20151015104515.GE8825@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <561EC58B.9080408@arm.com> <20151015104515.GE8825@leverpostej>
Message-ID: <20151015112532.GA16125@e106634-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 11:45:15AM +0100, Mark Rutland wrote:
> On Wed, Oct 14, 2015 at 04:13:47PM -0500, Jeremy Linton wrote:
> > On 10/14/2015 06:20 AM, Suzuki K. Poulose wrote:
> > 
> > >+ * Checks if the selected granule size is supported by the CPU.
> > >+ * If it doesn't park the CPU
> > 
> > The problem is when you park the boot CPU.
> > 
> > I think for EFI there is a slightly better error mechanism. This
> > tweak will print an error and return to the EFI boot manager rather
> > than hanging the machine without any notification. Now it prints:
> > 
> > EFI stub: Booting Linux Kernel...
> > EFI stub: ERROR: 16K granule not supported by this machine
> > EFI stub: ERROR: Failed to relocate kernel
> > FS4:\>
> 
> Neat. We should definitely have checks like this in the stub.
> 
> However, we still need checks in head.S, given !EFI systems, SMP, and
> kexec, so this is a complementary mechanism.

Indeed. I meant to add the above check. The updated patch looks like :

----8>----

Author: Suzuki K. Poulose <suzuki.poulose@arm.com>
Date:   Wed Oct 14 11:25:16 2015 +0100

    arm64: Check for selected granule support
    
    Ensure that the selected page size is supported by the CPU(s). If it isn't
    park the CPU. A check is added to the EFI stub to detect if the boot CPU
    supports the page size, failing which, we fail the boot gracefully, with
    an error message.
    
    Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
    [ Added a check to EFI stub ]
    Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index a7f3d4b..72d814c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -44,6 +44,26 @@
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
+
+#define ID_AA64MMFR0_TGRAN4_SHIFT	28
+#define ID_AA64MMFR0_TGRAN64_SHIFT	24
+#define ID_AA64MMFR0_TGRAN16_SHIFT	20
+
+#define ID_AA64MMFR0_TGRAN4_NI		0xf
+#define ID_AA64MMFR0_TGRAN4_ON		0x0
+#define ID_AA64MMFR0_TGRAN64_NI		0xf
+#define ID_AA64MMFR0_TGRAN64_ON		0x0
+#define ID_AA64MMFR0_TGRAN16_NI		0x0
+#define ID_AA64MMFR0_TGRAN16_ON		0x1
+
+#if defined(CONFIG_ARM64_4K_PAGES)
+#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN4_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN4_ON
+#else
+#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN64_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN64_ON
+#endif
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120e..77d7de1 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -11,8 +11,15 @@
  */
 #include <linux/efi.h>
 #include <asm/efi.h>
+#include <asm/sysreg.h>
 #include <asm/sections.h>
 
+#if defined(CONFIG_ARM64_4K_PAGES)
+#define PAGE_SIZE_STR	"4K"
+#elif defined(CONFIG_ARM64_64K_PAGES)
+#define PAGE_SIZE_STR	"64K"
+#endif
+
 efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 					unsigned long *image_addr,
 					unsigned long *image_size,
@@ -25,6 +32,17 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
 	unsigned long kernel_size, kernel_memsize = 0;
 	unsigned long nr_pages;
 	void *old_image_addr = (void *)*image_addr;
+	u64 aa64mmfr0_el1;
+
+	/*
+	 * Check to see if the CPU supports the requested pagesize
+	 */
+	asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));
+	aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN_SHIFT;
+	if ((aa64mmfr0_el1 & 0xf) != ID_AA64MMFR0_TGRAN_SUPPORTED) {
+		pr_efi_err(sys_table_arg, PAGE_SIZE_STR" granule not supported by the CPU\n");
+		return EFI_UNSUPPORTED;
+	}
 
 	/* Relocate the image, if required. */
 	kernel_size = _edata - _text;
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7ace955..514c1cc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -31,10 +31,11 @@
 #include <asm/cputype.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
-#include <asm/thread_info.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/sysreg.h>
+#include <asm/thread_info.h>
 #include <asm/virt.h>
 
 #define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)
@@ -613,10 +614,17 @@ ENDPROC(__secondary_switched)
  *  x0  = SCTLR_EL1 value for turning on the MMU.
  *  x27 = *virtual* address to jump to upon completion
  *
- * other registers depend on the function called upon completion
+ * Other registers depend on the function called upon completion.
+ *
+ * Checks if the selected granule size is supported by the CPU.
+ * If it isn't, park the CPU
  */
 	.section	".idmap.text", "ax"
 __enable_mmu:
+	mrs	x1, ID_AA64MMFR0_EL1
+	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
+	b.ne	__no_granule_support
 	ldr	x5, =vectors
 	msr	vbar_el1, x5
 	msr	ttbr0_el1, x25			// load TTBR0
@@ -634,3 +642,8 @@ __enable_mmu:
 	isb
 	br	x27
 ENDPROC(__enable_mmu)
+
+__no_granule_support:
+	wfe
+	b __no_granule_support
+ENDPROC(__no_granule_support)

----8<----
> 
> Thanks,
> Mark.
> 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/kernel/efi-stub.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> > index 816120e..90fb868 100644
> > --- a/arch/arm64/kernel/efi-stub.c
> > +++ b/arch/arm64/kernel/efi-stub.c
> > @@ -25,6 +25,20 @@ efi_status_t __init
> > handle_kernel_image(efi_system_table_t *sys_table_arg,
> >         unsigned long kernel_size, kernel_memsize = 0;
> >         unsigned long nr_pages;
> >         void *old_image_addr = (void *)*image_addr;
> > +       u32 aa64mmfr0_el1;
> > +
> > +#ifdef CONFIG_ARM64_16K_PAGES
> > +       /*
> > +        * check to see if this kernel image is
> > +        * compatible with the current system
> > +        */
> > +       asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));
> > +       aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN16_SHIFT;
> > +       if ((aa64mmfr0_el1 & ID_AA64MMFR0_TGRAN4_ON) == 0) {
> > +               pr_efi_err(sys_table_arg, "16K granule not supported
> > by this machine\n");
> > +               return EFI_UNSUPPORTED;
> > +       }
> > +#endif
> > 
> >         /* Relocate the image, if required. */
> >         kernel_size = _edata - _text;
> > -- 
> > 2.4.3
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
