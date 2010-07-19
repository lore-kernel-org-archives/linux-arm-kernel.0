From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 19 Jul 2010 17:30:36 +0900
Subject: [PATCH 4/4] ARM: S5PV210: Clock Framework: Flag Support for struct
	clk.
In-Reply-To: <1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1279528236-6076-5-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added .flags property to struct clk init_clocks[] and removed
init_clocks_disabled[], which became useless by BOOT_OFF bit of .flags.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  477 +++++++++++++++++++++++------------------
 1 files changed, 270 insertions(+), 207 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index af2af5e..bafba6f 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -660,8 +660,51 @@ static struct clk_ops clk_hclk_imem_ops = {
 	.get_rate	= s5pv210_clk_imem_get_rate,
 };
 
-static struct clk init_clocks_disable[] = {
+static struct clk init_clocks[] = {
 	{
+		.name		= "hclk_imem",
+		.id		= -1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 5),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+		.ops		= &clk_hclk_imem_ops,
+	}, {
+		.name		= "pdma",
+		.id		= 0,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 3),
+		.flags		= CLKFLAGS_BOOT_ON,
+	}, {
+		.name		= "pdma",
+		.id		= 1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 4),
+		.flags		= CLKFLAGS_BOOT_ON,
+	}, {
+		.name		= "mdma",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 2),
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "dmc",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 0),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "dmc",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 1),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
 		.name		= "csis",
 		.id		= -1,
 		.parent		= &clk_pclk_dsys.clk,
@@ -669,6 +712,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 31),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "rot",
 		.id		= -1,
@@ -677,6 +721,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1<<29),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "jpeg",
 		.id		= -1,
@@ -685,6 +730,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 28),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "fimc",
 		.id		= 0,
@@ -693,6 +739,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 24),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "fimc",
 		.id		= 1,
@@ -701,6 +748,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 25),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "fimc",
 		.id		= 2,
@@ -709,6 +757,15 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 26),
 		PD_SET(cam)
 		BD_SET(img)
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "nandxl",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 24),
+		BD_SET(memory)
+		.flags		= CLKFLAGS_BOOT_ON,
 	}, {
 		.name		= "nfcon",
 		.id		= -1,
@@ -716,6 +773,15 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1 << 28),
 		BD_SET(memory)
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "sromc",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1 << 26),
+		BD_SET(memory)
+		.flags		= CLKFLAGS_BOOT_ON,
 	}, {
 		.name		= "tvenc",
 		.id		= -1,
@@ -724,6 +790,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 10),
 		PD_SET(tv)
 		BD_SET(tv)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "hdmi",
 		.id		= -1,
@@ -732,6 +799,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 11),
 		PD_SET(tv)
 		BD_SET(tv)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "mixer",
 		.id		= -1,
@@ -740,6 +808,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 9),
 		PD_SET(tv)
 		BD_SET(tv)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "otg",
 		.id		= -1,
@@ -747,6 +816,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<16),
 		BD_SET(usb)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "usb-host",
 		.id		= -1,
@@ -754,6 +824,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<17),
 		BD_SET(usb)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "lcd",
 		.id		= -1,
@@ -762,6 +833,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1<<0),
 		PD_SET(lcd)
 		BD_SET(lcd)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "cfcon",
 		.id		= 0,
@@ -769,6 +841,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<25),
 		BD_SET(memory)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "vp",
 		.id		= -1,
@@ -777,6 +850,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 8),
 		PD_SET(tv)
 		BD_SET(tv)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "dsim",
 		.id		= -1,
@@ -785,6 +859,100 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 2),
 		PD_SET(lcd)
 		BD_SET(lcd)
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "tzic",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 28),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+		BD_SET(intc)
+	}, {
+		.name		= "tzic",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 29),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+		BD_SET(intc)
+	}, {
+		.name		= "tzic",
+		.id		= 2,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 30),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+		BD_SET(intc)
+	}, {
+		.name		= "tzic",
+		.id		= 3,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 31),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+		BD_SET(intc)
+	}, {
+		.name		= "vic",
+		.id		= 0,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 24),
+		BD_SET(intc)
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "vic",
+		.id		= 1,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 25),
+		BD_SET(intc)
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "vic",
+		.id		= 2,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 26),
+		BD_SET(intc)
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "vic",
+		.id		= 3,
+		.parent		= &clk_hclk_msys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 27),
+		BD_SET(intc)
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "secjtag",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 11),
+		BD_SET(debug)
+	}, {
+		.name		= "coresight",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 8),
+		BD_SET(debug)
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "sdm",
+		.id		= -1,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 1),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "secss",
+		.id		= -1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip2_ctrl,
+		.ctrlbit	= (1 << 0),
+		BD_SET(security)
+		.flags		= CLKFLAGS_ALWAYS_ON,
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
@@ -792,6 +960,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<16),
 		BD_SET(hsmmc)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
@@ -799,6 +968,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<17),
 		BD_SET(hsmmc)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
@@ -806,6 +976,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<18),
 		BD_SET(hsmmc)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "hsmmc",
 		.id		= 3,
@@ -813,6 +984,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1<<19),
 		BD_SET(hsmmc)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "tsi",
 		.id		= -1,
@@ -820,6 +992,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 20),
 		BD_SET(hsmmc)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "hostif",
 		.id		= -1,
@@ -827,6 +1000,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 10),
 		BD_SET(debug)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "modem",
 		.id		= -1,
@@ -834,108 +1008,168 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip2_ctrl,
 		.ctrlbit	= (1 << 9),
 		BD_SET(debug)
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "syscon",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 27),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 26),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 17),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 18),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 19),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 20),
+		.flags		= CLKFLAGS_ALWAYS_ON,
 	}, {
 		.name		= "pcm",
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 28),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "pcm",
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 29),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "pcm",
 		.id		= 2,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 30),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "systimer",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<16),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "watchdog",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<22),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "rtc",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<15),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2c",
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<7),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2c",
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<8),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2c",
 		.id		= 2,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<9),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<12),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "spi",
 		.id		= 1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<13),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "spi",
 		.id		= 2,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<14),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "timers",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<23),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "adc",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<24),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "keypad",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<21),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2c_hdmi_phy",
 		.id		= -1,
 		.parent		= &clk_pclk_dsys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 11),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2c_hdmi_ddc",
 		.id		= -1,
 		.parent		= &clk_pclk_dsys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 10),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2s_v50",
 		.id		= 0,
@@ -944,248 +1178,88 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1<<4),
 		/* Note that only i2s-0 is connected to pd_audio */
 		PD_SET(audio)
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2s_v32",
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 5),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "i2s_v32",
 		.id		= 1,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 6),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "ac97",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 1),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "spdif",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 0),
+		.flags		= CLKFLAGS_BOOT_OFF,
+	}, {
+		.name		= "tzpc",
+		.id		= 0,
+		.parent		= &clk_pclk_msys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 5),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "tzpc",
+		.id		= 1,
+		.parent		= &clk_pclk_psys.clk,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 6),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "tzpc",
+		.id		= 2,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 7),
+		.flags		= CLKFLAGS_ALWAYS_ON,
+	}, {
+		.name		= "tzpc",
+		.id		= 3,
+		.enable		= s5pv210_clk_ip4_ctrl,
+		.ctrlbit	= (1 << 8),
+		.flags		= CLKFLAGS_ALWAYS_ON,
 	}, {
 		.name		= "seckey",
 		.id		= -1,
 		.enable		= s5pv210_clk_ip4_ctrl,
 		.ctrlbit	= (1 << 3),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "iem_apc",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip4_ctrl,
 		.ctrlbit	= (1 << 2),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "iem_iec",
 		.id		= -1,
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip4_ctrl,
 		.ctrlbit	= (1 << 1),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	}, {
 		.name		= "chip_id",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
 		.enable		= s5pv210_clk_ip4_ctrl,
 		.ctrlbit	= (1 << 0),
-	},
-};
-
-static struct clk init_clocks[] = {
-	{
-		.name		= "hclk_imem",
-		.id		= -1,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 5),
-		.ops		= &clk_hclk_imem_ops,
-	}, {
-		.name		= "pdma",
-		.id		= 0,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 3),
-	}, {
-		.name		= "pdma",
-		.id		= 1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 4),
-	}, {
-		.name		= "mdma",
-		.id		= -1,
-		.parent		= &clk_hclk_dsys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 2),
-	}, {
-		.name		= "dmc",
-		.id		= 0,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= "dmc",
-		.id		= 1,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip0_ctrl,
-		.ctrlbit	= (1 << 1),
-	}, {
-		.name		= "nandxl",
-		.id		= -1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip1_ctrl,
-		.ctrlbit	= (1 << 24),
-		BD_SET(memory)
-	}, {
-		.name		= "sromc",
-		.id		= -1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip1_ctrl,
-		.ctrlbit	= (1 << 26),
-		BD_SET(memory)
-	}, {
-		.name		= "tzic",
-		.id		= 0,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 28),
-		BD_SET(intc)
-	}, {
-		.name		= "tzic",
-		.id		= 1,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 29),
-		BD_SET(intc)
-	}, {
-		.name		= "tzic",
-		.id		= 2,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 30),
-		BD_SET(intc)
-	}, {
-		.name		= "tzic",
-		.id		= 3,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 31),
-		BD_SET(intc)
-	}, {
-		.name		= "vic",
-		.id		= 0,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 24),
-		BD_SET(intc)
-	}, {
-		.name		= "vic",
-		.id		= 1,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 25),
-		BD_SET(intc)
-	}, {
-		.name		= "vic",
-		.id		= 2,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 26),
-		BD_SET(intc)
-	}, {
-		.name		= "vic",
-		.id		= 3,
-		.parent		= &clk_hclk_msys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 27),
-		BD_SET(intc)
-	}, {
-		.name		= "secjtag",
-		.id		= -1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 11),
-		BD_SET(debug)
-	}, {
-		.name		= "coresight",
-		.id		= -1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 8),
-		BD_SET(debug)
-	}, {
-		.name		= "sdm",
-		.id		= -1,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 1),
-	}, {
-		.name		= "secss",
-		.id		= -1,
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1 << 0),
-		BD_SET(security)
-	}, {
-		.name		= "syscon",
-		.id		= -1,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 27),
-	}, {
-		.name		= "gpio",
-		.id		= -1,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 26),
-	}, {
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 17),
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 18),
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 19),
-	}, {
-		.name		= "uart",
-		.id		= 3,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1 << 20),
-	}, {
-		.name		= "tzpc",
-		.id		= 0,
-		.parent		= &clk_pclk_msys.clk,
-		.enable		= s5pv210_clk_ip4_ctrl,
-		.ctrlbit	= (1 << 5),
-	}, {
-		.name		= "tzpc",
-		.id		= 1,
-		.parent		= &clk_pclk_psys.clk,
-		.enable		= s5pv210_clk_ip4_ctrl,
-		.ctrlbit	= (1 << 6),
-	}, {
-		.name		= "tzpc",
-		.id		= 2,
-		.enable		= s5pv210_clk_ip4_ctrl,
-		.ctrlbit	= (1 << 7),
-	}, {
-		.name		= "tzpc",
-		.id		= 3,
-		.enable		= s5pv210_clk_ip4_ctrl,
-		.ctrlbit	= (1 << 8),
+		.flags		= CLKFLAGS_BOOT_OFF,
 	},
 };
 
@@ -1757,7 +1831,6 @@ static struct clk *clks[] __initdata = {
 
 void __init s5pv210_register_clocks(void)
 {
-	struct clk *clkp;
 	int ret;
 	int ptr;
 
@@ -1771,16 +1844,6 @@ void __init s5pv210_register_clocks(void)
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
-	clkp = init_clocks_disable;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-		(clkp->enable)(clkp, 0);
-	}
-
 #ifdef CONFIG_S5PV210_POWERDOMAIN
 	/* According to the state of the members, turn on/off power domains
 	 * and blocks. */
-- 
1.6.3.3
