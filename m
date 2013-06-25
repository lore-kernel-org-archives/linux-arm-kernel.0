From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Jun 2013 22:24:48 +0200
Subject: [PATCH v2 2/5] ARM: be strict about FP exceptions in kernel mode
In-Reply-To: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1372191891-24574-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support code in vfp_support_entry does not care whether the
exception that caused it to be invoked occurred in kernel mode or
in user mode. However, neither condition that could trigger this
exception (lazy restore and VFP bounce to support code) is
currently allowable in kernel mode.

In the former case, we can just handle it as an undefined instruction.
In the latter case, we should flag it as a bug, as it implies that
the FP unit has been enabled and an attempt has been made to
execute FP instructions that are dependent on the support code, and
this is not supported in kernel mode.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/vfp/vfphw.S     |  5 +++++
 arch/arm/vfp/vfpmodule.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 8d10dc8..3e5d311 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -78,6 +78,11 @@
 ENTRY(vfp_support_entry)
 	DBGSTR3	"instr %08x pc %08x state %p", r0, r2, r10
 
+	ldr	r3, [sp, #S_PSR]	@ Neither lazy restore nor FP exceptions
+	and	r3, r3, #MODE_MASK	@ are supported in kernel mode
+	teq	r3, #USR_MODE
+	bne	vfp_kmode_exception	@ Returns through lr
+
 	VFPFMRX	r1, FPEXC		@ Is the VFP enabled?
 	DBGSTR1	"fpexc %08x", r1
 	tst	r1, #FPEXC_EN
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 791993a..fd1466c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -26,6 +26,7 @@
 #include <asm/system_info.h>
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
+#include <asm/bug.h>
 
 #include "vfpinstr.h"
 #include "vfp.h"
@@ -648,6 +649,16 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 	return NOTIFY_OK;
 }
 
+void vfp_kmode_exception(void)
+{
+	/*
+	 * Taking an FP exception in kernel mode is always a bug, because
+	 * none of the FP instructions currently supported in kernel mode
+	 * (i.e., NEON) should ever be bounced back to the support code.
+	 */
+	BUG_ON(fmrx(FPEXC) & FPEXC_EN);
+}
+
 /*
  * VFP support code initialisation.
  */
-- 
1.8.1.2
