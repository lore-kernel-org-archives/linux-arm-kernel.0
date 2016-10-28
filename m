From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Oct 2016 18:27:15 +0100
Subject: [PATCH v4 7/8] arm64: xen: Enable user access before a privcmd hvc
 call
In-Reply-To: <1477675636-3957-1-git-send-email-catalin.marinas@arm.com>
References: <1477675636-3957-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1477675636-3957-8-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Privcmd calls are issued by the userspace. The kernel needs to enable
access to TTBR0_EL1 as the hypervisor would issue stage 1 translations
to user memory via AT instructions. Since AT instructions are not
affected by the PAN bit (ARMv8.1), we only need the explicit
uaccess_enable/disable if the TTBR0 PAN option is enabled.

Reviewed-by: Julien Grall <julien.grall@arm.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/xen/hypercall.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 329c8027b0a9..b41aff25426d 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -49,6 +49,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/uaccess.h>
 #include <xen/interface/xen.h>
 
 
@@ -91,6 +92,20 @@ ENTRY(privcmd_call)
 	mov x2, x3
 	mov x3, x4
 	mov x4, x5
+	/*
+	 * Privcmd calls are issued by the userspace. The kernel needs to
+	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
+	 * translations to user memory via AT instructions. Since AT
+	 * instructions are not affected by the PAN bit (ARMv8.1), we only
+	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
+	 * is enabled (it implies that hardware UAO and PAN disabled).
+	 */
+	uaccess_ttbr0_enable x6, x7
 	hvc XEN_IMM
+
+	/*
+	 * Disable userspace access from kernel once the hyp call completed.
+	 */
+	uaccess_ttbr0_disable x6
 	ret
 ENDPROC(privcmd_call);
