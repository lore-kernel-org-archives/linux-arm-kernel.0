From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:38 +0000
Subject: [RFC PATCH v2 08/41] arm64/sve: Low-level save/restore code
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-9-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds low-level save/restore for the Scalable Vector
Extension.

This is helper code only, and is not used for anything yet.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig                    |  12 +++
 arch/arm64/include/asm/fpsimd.h       |   3 +
 arch/arm64/include/asm/fpsimdmacros.h | 145 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry-fpsimd.S      |  17 ++++
 4 files changed, 177 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cf82776..289dcb9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -932,6 +932,18 @@ config ARM64_UAO
 
 endmenu
 
+config ARM64_SVE
+	bool "ARM Scalable Vector Extension support"
+	default y
+	depends on !KERNEL_MODE_NEON	# until it works with SVE
+	help
+	  The Scalable Vector Extension (SVE) is an extension to the AArch64
+	  execution state which complements and extends the SIMD functionality
+	  of the base architecture to support much larger vectors and to enable
+	  additional vectorisation opportunities.
+
+	  To enable use of this extension on CPUs that implement it, say Y.
+
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50f559f..92f45ee 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -81,6 +81,9 @@ extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
 				      u32 num_regs);
 extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
 
+extern void sve_save_state(void *state, u32 *pfpsr);
+extern void sve_load_state(void const *state, u32 const *pfpsr);
+
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index a2daf12..e2bb032 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -131,3 +131,148 @@
 	ldp	q0, q1, [\state, #-16 * 0 - 16]
 0:
 .endm
+
+.macro _check_reg nr
+	.if (\nr) < 0 || (\nr) > 31
+		.error "Bad register number \nr."
+	.endif
+.endm
+
+.macro _check_zreg znr
+	.if (\znr) < 0 || (\znr) > 31
+		.error "Bad Scalable Vector Extension vector register number \znr."
+	.endif
+.endm
+
+.macro _check_preg pnr
+	.if (\pnr) < 0 || (\pnr) > 15
+		.error "Bad Scalable Vector Extension predicate register number \pnr."
+	.endif
+.endm
+
+.macro _check_num n, min, max
+	.if (\n) < (\min) || (\n) > (\max)
+		.error "Number \n out of range [\min,\max]"
+	.endif
+.endm
+
+.macro _zstrv znt, nspb, ioff=0
+	_check_zreg \znt
+	_check_reg \nspb
+	_check_num (\ioff), -0x100, 0xff
+	.inst	0xe5804000			\
+		| (\znt)			\
+		| ((\nspb) << 5)		\
+		| (((\ioff) & 7) << 10)		\
+		| (((\ioff) & 0x1f8) << 13)
+.endm
+
+.macro _zldrv znt, nspb, ioff=0
+	_check_zreg \znt
+	_check_reg \nspb
+	_check_num (\ioff), -0x100, 0xff
+	.inst	0x85804000			\
+		| (\znt)			\
+		| ((\nspb) << 5)		\
+		| (((\ioff) & 7) << 10)		\
+		| (((\ioff) & 0x1f8) << 13)
+.endm
+
+.macro _zstrp pnt, nspb, ioff=0
+	_check_preg \pnt
+	_check_reg \nspb
+	_check_num (\ioff), -0x100, 0xff
+	.inst	0xe5800000			\
+		| (\pnt)			\
+		| ((\nspb) << 5)		\
+		| (((\ioff) & 7) << 10)		\
+		| (((\ioff) & 0x1f8) << 13)
+.endm
+
+.macro _zldrp pnt, nspb, ioff=0
+	_check_preg \pnt
+	_check_reg \nspb
+	_check_num (\ioff), -0x100, 0xff
+	.inst	0x85800000			\
+		| (\pnt)			\
+		| ((\nspb) << 5)		\
+		| (((\ioff) & 7) << 10)		\
+		| (((\ioff) & 0x1f8) << 13)
+.endm
+
+.macro _zrdvl nspd, is1
+	_check_reg \nspd
+	_check_num (\is1), -0x20, 0x1f
+	.inst	0x04bf5000			\
+		| (\nspd)			\
+		| (((\is1) & 0x3f) << 5)
+.endm
+
+.macro _zrdffr pnd
+	_check_preg \pnd
+	.inst	0x2519f000			\
+		| (\pnd)
+.endm
+
+.macro _zwrffr pnd
+	_check_preg \pnd
+	.inst	0x25289000			\
+		| ((\pnd) << 5)
+.endm
+
+.macro for from, to, insn
+	.if (\from) >= (\to)
+		\insn	(\from)
+		.exitm
+	.endif
+
+	for \from, ((\from) + (\to)) / 2, \insn
+	for ((\from) + (\to)) / 2 + 1, \to, \insn
+.endm
+
+.macro sve_save nb, xpfpsr, ntmp
+	.macro savez n
+		_zstrv	\n, \nb, (\n) - 34
+	.endm
+
+	.macro savep n
+		_zstrp	\n, \nb, (\n) - 16
+	.endm
+
+	for	0, 31, savez
+	for	0, 15, savep
+	_zrdffr	0
+	_zstrp	0, \nb
+	_zldrp	0, \nb, -16
+
+	mrs	x\ntmp, fpsr
+	str	w\ntmp, [\xpfpsr]
+	mrs	x\ntmp, fpcr
+	str	w\ntmp, [\xpfpsr, #4]
+
+	.purgem savez
+	.purgem savep
+.endm
+
+.macro sve_load nb, xpfpsr, ntmp
+	.macro loadz n
+		_zldrv	\n, \nb, (\n) - 34
+	.endm
+
+	.macro loadp n
+		_zldrp	\n, \nb, (\n) - 16
+	.endm
+
+	for	0, 31, loadz
+	_zldrp	0, \nb
+	_zwrffr	0
+	for	0, 15, loadp
+
+	ldr	w\ntmp, [\xpfpsr]
+	msr	fpsr, x\ntmp
+	ldr	w\ntmp, [\xpfpsr, #4]
+	msr	fpcr, x\ntmp
+
+	.purgem loadz
+	.purgem loadp
+.endm
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index c44a82f..5dcec55 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -65,3 +65,20 @@ ENTRY(fpsimd_load_partial_state)
 ENDPROC(fpsimd_load_partial_state)
 
 #endif
+
+#ifdef CONFIG_ARM64_SVE
+ENTRY(sve_save_state)
+	sve_save 0, x1, 2
+	ret
+ENDPROC(sve_save_state)
+
+ENTRY(sve_load_state)
+	sve_load 0, x1, 2
+	ret
+ENDPROC(sve_load_state)
+
+ENTRY(sve_get_vl)
+	_zrdvl	0, 1
+	ret
+ENDPROC(sve_get_vl)
+#endif /* CONFIG_ARM64_SVE */
-- 
2.1.4
