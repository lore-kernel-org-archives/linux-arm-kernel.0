From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:08 +0800
Subject: [PATCH 4/7] ARM: tegra: add LP1 support code for Tegra124
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP1 suspend procedure is the same with Tegra30 and Tegra114. Just
need to update the difference of the register address, then we can
continue to share the code.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/iomap.h         |  3 +++
 arch/arm/mach-tegra/sleep-tegra30.S | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
index cbee57f..26b1c2a 100644
--- a/arch/arm/mach-tegra/iomap.h
+++ b/arch/arm/mach-tegra/iomap.h
@@ -105,6 +105,9 @@
 #define TEGRA_EMC1_BASE			0x7001A800
 #define TEGRA_EMC1_SIZE			SZ_2K
 
+#define TEGRA124_EMC_BASE		0x7001B000
+#define TEGRA124_EMC_SIZE		SZ_2K
+
 #define TEGRA_CSITE_BASE		0x70040000
 #define TEGRA_CSITE_SIZE		SZ_256K
 
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index c6fc15c..e65a831 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -408,8 +408,12 @@ _pll_m_c_x_done:
 	cmp	r10, #TEGRA30
 	movweq	r0, #:lower16:TEGRA_EMC_BASE	@ r0 reserved for emc base
 	movteq	r0, #:upper16:TEGRA_EMC_BASE
-	movwne	r0, #:lower16:TEGRA_EMC0_BASE
-	movtne	r0, #:upper16:TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA114
+	movweq	r0, #:lower16:TEGRA_EMC0_BASE
+	movteq	r0, #:upper16:TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA124
+	movweq	r0, #:lower16:TEGRA124_EMC_BASE
+	movteq	r0, #:upper16:TEGRA124_EMC_BASE
 
 exit_self_refresh:
 	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
@@ -554,15 +558,25 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
 
+tegra124_sdram_pad_address:
+	.word	TEGRA124_EMC_BASE + EMC_CFG				@0x0
+	.word	TEGRA124_EMC_BASE + EMC_ZCAL_INTERVAL			@0x4
+	.word	TEGRA124_EMC_BASE + EMC_AUTO_CAL_INTERVAL		@0x8
+	.word	TEGRA124_EMC_BASE + EMC_XM2VTTGENPADCTRL		@0xc
+	.word	TEGRA124_EMC_BASE + EMC_XM2VTTGENPADCTRL2		@0x10
+	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
+	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+
 tegra30_sdram_pad_size:
 	.word	tegra114_sdram_pad_address - tegra30_sdram_pad_address
 
 tegra114_sdram_pad_size:
-	.word	tegra30_sdram_pad_size - tegra114_sdram_pad_address
+	.word	tegra124_sdram_pad_address - tegra114_sdram_pad_address
 
 	.type	tegra30_sdram_pad_save, %object
 tegra30_sdram_pad_save:
-	.rept (tegra30_sdram_pad_size - tegra114_sdram_pad_address) / 4
+	.rept (tegra124_sdram_pad_address - tegra114_sdram_pad_address) / 4
 	.long	0
 	.endr
 
@@ -698,8 +712,13 @@ tegra30_sdram_self_refresh:
 	cmp	r10, #TEGRA30
 	adreq	r2, tegra30_sdram_pad_address
 	ldreq	r3, tegra30_sdram_pad_size
-	adrne	r2, tegra114_sdram_pad_address
-	ldrne	r3, tegra114_sdram_pad_size
+	cmp	r10, #TEGRA114
+	adreq	r2, tegra114_sdram_pad_address
+	ldreq	r3, tegra114_sdram_pad_size
+	cmp	r10, #TEGRA124
+	adreq	r2, tegra124_sdram_pad_address
+	ldreq	r3, tegra30_sdram_pad_size
+
 	mov	r9, #0
 
 padsave:
@@ -717,7 +736,10 @@ padsave_done:
 
 	cmp	r10, #TEGRA30
 	ldreq	r0, =TEGRA_EMC_BASE	@ r0 reserved for emc base addr
-	ldrne	r0, =TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA114
+	ldreq	r0, =TEGRA_EMC0_BASE
+	cmp	r10, #TEGRA124
+	ldreq	r0, =TEGRA124_EMC_BASE
 
 enter_self_refresh:
 	cmp	r10, #TEGRA30
-- 
1.8.4
