From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 14 Oct 2015 16:13:47 -0500
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <561EC58B.9080408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 06:20 AM, Suzuki K. Poulose wrote:

> + * Checks if the selected granule size is supported by the CPU.
> + * If it doesn't park the CPU

The problem is when you park the boot CPU.

I think for EFI there is a slightly better error mechanism. This tweak 
will print an error and return to the EFI boot manager rather than 
hanging the machine without any notification. Now it prints:

EFI stub: Booting Linux Kernel...
EFI stub: ERROR: 16K granule not supported by this machine
EFI stub: ERROR: Failed to relocate kernel
FS4:\>


Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
  arch/arm64/kernel/efi-stub.c | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
index 816120e..90fb868 100644
--- a/arch/arm64/kernel/efi-stub.c
+++ b/arch/arm64/kernel/efi-stub.c
@@ -25,6 +25,20 @@ efi_status_t __init 
handle_kernel_image(efi_system_table_t *sys_table_arg,
         unsigned long kernel_size, kernel_memsize = 0;
         unsigned long nr_pages;
         void *old_image_addr = (void *)*image_addr;
+       u32 aa64mmfr0_el1;
+
+#ifdef CONFIG_ARM64_16K_PAGES
+       /*
+        * check to see if this kernel image is
+        * compatible with the current system
+        */
+       asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));
+       aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN16_SHIFT;
+       if ((aa64mmfr0_el1 & ID_AA64MMFR0_TGRAN4_ON) == 0) {
+               pr_efi_err(sys_table_arg, "16K granule not supported by 
this machine\n");
+               return EFI_UNSUPPORTED;
+       }
+#endif

         /* Relocate the image, if required. */
         kernel_size = _edata - _text;
-- 
2.4.3
