From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 20 Jul 2017 09:10:28 +0100
Subject: [PATCH 2/2] ARM: kexec: fix failure to boot crash kernel
Message-ID: <E1dY6XU-0003wa-Tl@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kexec was converted to DTB, the dtb address was passed between
machine_kexec_prepare() and machine_kexec() using a static variable.
This is bad news if you load a crash kernel followed by a normal
kernel or vice versa - the last loaded kernel overwrites the dtb
address.

This can result in kexec failures, as (eg) we try to boot the crash
kernel with the last loaded dtb.

Avoid this by defining a kimage architecture structure, and store
the address of to be passed in r2 to the new there, which will
either be the ATAGs or the dtb blob.

Reported-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/kexec.h    |  5 +++++
 arch/arm/kernel/machine_kexec.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index 1869af6bac5c..25021b798a1e 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -19,6 +19,11 @@
 
 #ifndef __ASSEMBLY__
 
+#define ARCH_HAS_KIMAGE_ARCH
+struct kimage_arch {
+	u32 kernel_r2;
+};
+
 /**
  * crash_setup_regs() - save registers for the panic kernel
  * @newregs: registers are saved here
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 15495887ca14..fe1419eeb932 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -30,7 +30,6 @@ extern unsigned long kexec_boot_atags;
 
 static atomic_t waiting_for_crash_ipi;
 
-static unsigned long dt_mem;
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -42,6 +41,9 @@ int machine_kexec_prepare(struct kimage *image)
 	__be32 header;
 	int i, err;
 
+	image->arch.kernel_r2 = image->start - KEXEC_ARM_ZIMAGE_OFFSET
+				     + KEXEC_ARM_ATAGS_OFFSET;
+
 	/*
 	 * Validate that if the current HW supports SMP, then the SW supports
 	 * and implements CPU hotplug for the current HW. If not, we won't be
@@ -66,8 +68,8 @@ int machine_kexec_prepare(struct kimage *image)
 		if (err)
 			return err;
 
-		if (be32_to_cpu(header) == OF_DT_HEADER)
-			dt_mem = current_segment->mem;
+		if (header == cpu_to_be32(OF_DT_HEADER))
+			image->arch.kernel_r2 = current_segment->mem;
 	}
 	return 0;
 }
@@ -165,8 +167,7 @@ void machine_kexec(struct kimage *image)
 	kexec_start_address = image->start;
 	kexec_indirection_page = page_list;
 	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = dt_mem ?: image->start - KEXEC_ARM_ZIMAGE_OFFSET
-				     + KEXEC_ARM_ATAGS_OFFSET;
+	kexec_boot_atags = image->arch.kernel_r2;
 
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
-- 
2.7.4
