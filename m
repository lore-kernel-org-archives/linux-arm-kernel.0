From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 06 Jul 2010 14:48:47 +0900
Subject: [PATCH] ARM: S5PV210: add clocks (struct clk).
Message-ID: <1278395327-9072-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many clocks were not listed in the previous
arch/arm/mach-s5pv210/clock.c

We have added clocks defined as CLK_GATE_IPx[] in the user manual of
S5PV210. However, the clocks that were not turned on at the boot time
when tested with the previous kernel versions (2.6.32, 2.6.29) are
defined in "init_clocks_disabled" so that they are turned off at the
boot time.

The clocks added from CLK_GATE_IPx are:
	CSIS, JPEG, FIMC0 - 2, NFCON, SROMC, TVENC, HDMI, MIXER, VP,
	DSIM, TSI, HOSTIF, MODEM, PCM0 - 2, I2C-HDMI-PHY, I2C-HDMI-DDC,
	AC97, SPDIF, SECKEY, IEM-APC, IEM-IEC, CHIP-ID, PDMA0 - 1,
	MDMA, DMC0 - 1, NANDXL, TZIC0 - 3, VIC0 - 3, SECJTAG, CORESIGHT,
	SDM, SECSS, SYSCON, GPIO, TZPC0 - 3

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  298 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 297 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index b3d156c..aa2b1c5 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -275,12 +275,72 @@ static struct clk_ops clk_hclk_imem_ops = {
 
 static struct clk init_clocks_disable[] = {
 	{
+		.name		= "csis",
+		.id		= -1,
+		.parent		= &clk_pclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 31),
+	}, {
 		.name		= "rot",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1<<29),
 	}, {
+		.name		= "jpeg",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "fimc",
+		.id		= 0,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 24),
+	}, {
+		.name		= "fimc",
+		.id		= 1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "fimc",
+		.id		= 2,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "nfcon",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "sromc",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "tvenc",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "hdmi",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "mixer",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 9),
+	}, {
 		.name		= "otg",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
@@ -305,6 +365,18 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<25),
 	}, {
+		.name		= "vp",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "dsim",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_hclk_psys.clk,
@@ -329,6 +401,42 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<19),
 	}, {
+		.name		= "tsi",
+		.id		= -1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 20),
+	}, {
+		.name		= "hostif",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "modem",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 9),
+	}, {
+		.name		= "pcm",
+		.id		= 0,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "pcm",
+		.id		= 1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "pcm",
+		.id		= 2,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 30),
+	}, {
 		.name		= "systimer",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
@@ -401,6 +509,18 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<21),
 	}, {
+		.name		= "i2c_hdmi_phy",
+		.id		= -1,
+		.parent		= &clk_pclk_dsys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "i2c_hdmi_ddc",
+		.id		= -1,
+		.parent		= &clk_pclk_dsys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
 		.name		= "i2s_v50",
 		.id		= 0,
 		.parent		= &clk_p,
@@ -418,6 +538,41 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "ac97",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "spdif",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "seckey",
+		.id		= -1,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "iem_apc",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "iem_iec",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "chip_id",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 0),
 	},
 };
 
@@ -426,10 +581,129 @@ static struct clk init_clocks[] = {
 		.name		= "hclk_imem",
 		.id		= -1,
 		.parent		= &clk_hclk_msys.clk,
-		.ctrlbit	= (1 << 5),
 		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 5),
 		.ops		= &clk_hclk_imem_ops,
 	}, {
+		.name		= "pdma",
+		.id		= 0,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "pdma",
+		.id		= 1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "mdma",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "dmc",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "dmc",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "nandxl",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 24),
+	}, {
+		.name		= "tzic",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "tzic",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "tzic",
+		.id		= 2,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 30),
+	}, {
+		.name		= "tzic",
+		.id		= 3,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 31),
+	}, {
+		.name		= "vic",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 24),
+	}, {
+		.name		= "vic",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "vic",
+		.id		= 2,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "vic",
+		.id		= 3,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
+		.name		= "secjtag",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "coresight",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "sdm",
+		.id		= -1,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "secss",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "syscon",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
 		.name		= "uart",
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
@@ -453,6 +727,28 @@ static struct clk init_clocks[] = {
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 20),
+	}, {
+		.name		= "tzpc",
+		.id		= 0,
+		.parent		= &clk_pclk_msys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "tzpc",
+		.id		= 1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "tzpc",
+		.id		= 2,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "tzpc",
+		.id		= 3,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 8),
 	},
 };
 
-- 
1.6.3.3
