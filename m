From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  8 Jul 2013 23:11:58 +0100
Subject: [PATCH v3 2/5] ARM: be strict about FP exceptions in kernel mode
In-Reply-To: <1373321521-15485-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1373321521-15485-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1373321521-15485-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The support code in vfp_support_entry does not care whether the
exception that caused it to be invoked occurred in kernel mode or
in user mode. However, neither condition that could trigger this
exception (lazy restore and VFP bounce to support code) is
currently allowable in kernel mode.

In either case, print a message describing the condition before
letting the undefined instruction handler run its course and trigger
an oops.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/vfp/vfphw.S     |  5 +++++
 arch/arm/vfp/vfpmodule.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 791993a..7620831 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -648,6 +648,26 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 	return NOTIFY_OK;
 }
 
+void vfp_kmode_exception(void)
+{
+	/*
+	 * If we reach this point, a floating point exception has been raised
+	 * while running in kernel mode. If the NEON/VFP unit was enabled at the
+	 * time, it means a VFP instruction has been issued that requires
+	 * software assistance to complete, something which is not currently
+	 * supported in kernel mode.
+	 * If the NEON/VFP unit was disabled, and the location pointed to below
+	 * is properly preceded by a call to kernel_neon_begin(), something has
+	 * caused the task to be scheduled out and back in again. In this case,
+	 * rebuilding and running with CONFIG_DEBUG_ATOMIC_SLEEP enabled should
+	 * be helpful in localizing the problem.
+	 */
+	if (fmrx(FPEXC) & FPEXC_EN)
+		pr_crit("BUG: unsupported FP instruction in kernel mode\n");
+	else
+		pr_crit("BUG: FP instruction issued in kernel mode with FP unit disabled\n");
+}
+
 /*
  * VFP support code initialisation.
  */
-- 
1.8.1.2
