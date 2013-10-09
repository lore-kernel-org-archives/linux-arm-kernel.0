From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed,  9 Oct 2013 23:57:03 +0300
Subject: [RFC PATCH] ARM: kexec: Assemble relocate code in ARM mode
Message-ID: <1381352223-17721-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Thumb2 kernel (CONFIG_THUMB2_KERNEL) kexec's relocate code is assembled
in Thumb2 mode, but cpu_v7_reset() jumps to this code in ARM state,
because its address is page aligned and has 0 in LSB.

Assemble this code in ARM mode to fix the issue.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
Based on v3.12-rc4

Cc: Dave Martin <dave.martin@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linaro-kernel at lists.linaro.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/relocate_kernel.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index d0cdedf..a3af323 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -5,6 +5,7 @@
 #include <asm/kexec.h>
 
 	.globl relocate_new_kernel
+	.arm
 relocate_new_kernel:
 
 	ldr	r0,kexec_indirection_page
-- 
1.7.9.5
