From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 16:10:09 +0800
Subject: [RESEND PATCH] ARM: errata: Workaround for Cortex-A12 erratum 818325
In-Reply-To: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446538209-13490-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Tao <huangtao@rock-chips.com>

On Cortex-A12 (r0p0..r0p1-00lac0-rc11), when a CPU executes a sequence of
two conditional store instructions with opposite condition code and
updating the same register, the system might enter a deadlock if the
second conditional instruction is an UNPREDICTABLE STR or STM
instruction. This workaround setting bit[12] of the Feature Register
prevents the erratum. This bit disables an optimisation applied to a
sequence of 2 instructions that use opposing condition codes.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 arch/arm/Kconfig      | 13 +++++++++++++
 arch/arm/mm/proc-v7.S | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 639411f..554b57a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1263,6 +1263,19 @@ config ARM_ERRATA_773022
 	  loop buffer may deliver incorrect instructions. This
 	  workaround disables the loop buffer to avoid the erratum.
 
+config ARM_ERRATA_818325
+	bool "ARM errata: Execution of an UNPREDICTABLE STR or STM instruction might deadlock"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 818325 Cortex-A12
+	  (r0p0..r0p1-00lac0-rc11) erratum. When a CPU executes a sequence of
+	  two conditional store instructions with opposite condition code and
+	  updating the same register, the system might enter a deadlock if the
+	  second conditional instruction is an UNPREDICTABLE STR or STM
+	  instruction. This workaround setting bit[12] of the Feature Register
+	  prevents the erratum. This bit disables an optimisation applied to a
+	  sequence of 2 instructions that use opposing condition codes.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index de2b246..2b338ec 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -439,6 +439,18 @@ __v7_setup_cont:
 	teq	r0, r10
 	beq	__ca9_errata
 
+	/* Cortex-A12 Errata */
+	ldr	r10, =0x00000c0d		@ Cortex-A12 primary part number
+	teq	r0, r10
+	bne	5f
+#ifdef CONFIG_ARM_ERRATA_818325
+	teq	r6, #0x00			@ present in r0p0
+	teqne	r6, #0x01			@ present in r0p1-00lac0-rc11
+	mrceq	p15, 0, r10, c15, c0, 1		@ read diagnostic register
+	orreq	r10, r10, #1 << 12		@ set bit #12
+	mcreq	p15, 0, r10, c15, c0, 1		@ write diagnostic register
+	isb
+#endif
 	/* Cortex-A15 Errata */
 	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
 	teq	r0, r10
-- 
1.9.1
