From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:58:37 +0800
Subject: [PATCH V2 2/4] ARM: tegra: re-calculate the LP1 data for Tegra30/114
In-Reply-To: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
References: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485519-4027-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch re-calculates the LP1 data of tegra30/114_sdram_pad_address
to base on its label not rely on others. This can make easier to
maintain if some other Tegra chips keep re-using these codes in the
future. And change the name of tegra30_sdram_pad_save to
tegra_sdram_pad_save to make it more common to other chips.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* new in this series
---
 arch/arm/mach-tegra/sleep-tegra30.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index c6fc15c..7c529a1 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -383,7 +383,7 @@ _pll_m_c_x_done:
 	add	r1, r1, #LOCK_DELAY
 	wait_until r1, r7, r3
 
-	adr	r5, tegra30_sdram_pad_save
+	adr	r5, tegra_sdram_pad_save
 
 	ldr	r4, [r5, #0x18]		@ restore CLK_SOURCE_MSELECT
 	str	r4, [r0, #CLK_RESET_CLK_SOURCE_MSELECT]
@@ -538,6 +538,7 @@ tegra30_sdram_pad_address:
 	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
 	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
+tegra30_sdram_pad_address_end:
 
 tegra114_sdram_pad_address:
 	.word	TEGRA_EMC0_BASE + EMC_CFG				@0x0
@@ -553,16 +554,17 @@ tegra114_sdram_pad_address:
 	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
 	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
+tegra114_sdram_pad_adress_end:
 
 tegra30_sdram_pad_size:
-	.word	tegra114_sdram_pad_address - tegra30_sdram_pad_address
+	.word	tegra30_sdram_pad_address_end - tegra30_sdram_pad_address
 
 tegra114_sdram_pad_size:
-	.word	tegra30_sdram_pad_size - tegra114_sdram_pad_address
+	.word	tegra114_sdram_pad_adress_end - tegra114_sdram_pad_address
 
-	.type	tegra30_sdram_pad_save, %object
-tegra30_sdram_pad_save:
-	.rept (tegra30_sdram_pad_size - tegra114_sdram_pad_address) / 4
+	.type	tegra_sdram_pad_save, %object
+tegra_sdram_pad_save:
+	.rept (tegra114_sdram_pad_adress_end - tegra114_sdram_pad_address) / 4
 	.long	0
 	.endr
 
@@ -693,7 +695,7 @@ halted:
  */
 tegra30_sdram_self_refresh:
 
-	adr	r8, tegra30_sdram_pad_save
+	adr	r8, tegra_sdram_pad_save
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r10
 	cmp	r10, #TEGRA30
 	adreq	r2, tegra30_sdram_pad_address
-- 
1.8.4
