From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Jan 2018 10:31:31 +0000
Subject: [PATCH 4/4] efi/arm64: unmap the kernel while executing UEFI services
In-Reply-To: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
Message-ID: <20180125103131.19168-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all UEFI runtime service wrappers ensure that byref
arguments are moved into the UEFI marshalling buffer (which
is not part of the kernel mapping), we can proceed and unmap
the kernel while UEFI runtime service calls are in progress.

This is done by setting the EPD1 bit and flushing the TLB of
the local CPU. This makes it independent of KPTI or whether
non-global mappings are being used.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 09e77e5edd94..70af90ef914c 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -9,6 +9,24 @@
 #include <linux/linkage.h>
 #include <asm/efi.h>
 
+	.macro	sepd1, reg
+	mrs	\reg, tcr_el1			// read Translation Control Reg
+	orr	\reg, \reg, #1 << 23		// set EPD1 bit
+	msr	tcr_el1, \reg			// write back TCR
+	isb
+	tlbi	vmalle1
+	dsb	nsh
+	.endm
+
+	.macro	cepd1, reg
+	mrs	\reg, tcr_el1			// read Translation Control Reg
+	bic	\reg, \reg, #1 << 23		// clear EPD1 bit
+	msr	tcr_el1, \reg			// write back TCR
+	isb
+	tlbi	vmalle1
+	dsb	nsh
+	.endm
+
 	.section	".rodata", "a"
 	.align		PAGE_SHIFT
 ENTRY(__efi_rt_asm_wrapper)
@@ -27,6 +45,7 @@ ENTRY(__efi_rt_asm_wrapper)
 	adr	x1, __efi_rt_vectors
 	msr	vbar_el1, x1
 	isb
+	sepd1	x1
 
 	/*
 	 * We are lucky enough that no EFI runtime services take more than
@@ -46,6 +65,7 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldr	x1, 2f
 	msr	vbar_el1, x1
 	isb
+	cepd1	x1
 
 	ldp	x1, x2, [sp, #16]
 	cmp	x2, x18
@@ -63,6 +83,7 @@ ENDPROC(__efi_rt_asm_wrapper)
 	.align	7
 .Lv\@ :	stp	x29, x30, [sp, #-16]!		// preserve x29 and x30
 	mrs	x29, elr_el1			// preserve ELR
+	cepd1	x30
 	adr	x30, .Lret			// take return address
 	msr	elr_el1, x30			// set ELR to return address
 	ldr	x30, 2b				// take address of 'vectors'
@@ -76,6 +97,7 @@ ENDPROC(__efi_rt_asm_wrapper)
 	adr	x30, __efi_rt_vectors
 	msr	vbar_el1, x30
 	isb
+	sepd1	x30
 	ldp	x29, x30, [sp], #16
 	eret
 
-- 
2.11.0
