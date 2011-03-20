From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Sun, 20 Mar 2011 21:30:07 +0100
Subject: [PATCH v3 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300653009-11675-8-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for EmbeddedArtists LPC2478 Developer's Kit, consisting
of the LPC2478OEM board, with QVGA base board. For details, see:

http://www.embeddedartists.com/products/kits/lpc2478_kit.php

The mach-types change included is simply one generated from
http://www.arm.linux.org.uk/developer/machines/, and is only
included so this patch can be build.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
changes since v2:
        * Changed machine name from web interface, and
          included mach-types update generated from there.

changes since v1:
        * Fixed RTC clock rate
        * Marked mfp_cfgs as __initdata.
        * renamed LPC2478OEM to more appropriate EA2478DEVKIT.
---
 arch/arm/mach-lpc2k/Kconfig             |    7 ++
 arch/arm/mach-lpc2k/Makefile            |    2 +
 arch/arm/mach-lpc2k/common.h            |   21 +++++
 arch/arm/mach-lpc2k/mach-ea2478devkit.c |  122 +++++++++++++++++++++++++++++++
 arch/arm/tools/mach-types               |  113 +++++++++++++++++++++-------
 5 files changed, 237 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/common.h
 create mode 100644 arch/arm/mach-lpc2k/mach-ea2478devkit.c

diff --git a/arch/arm/mach-lpc2k/Kconfig b/arch/arm/mach-lpc2k/Kconfig
index fad47b8..210b641 100644
--- a/arch/arm/mach-lpc2k/Kconfig
+++ b/arch/arm/mach-lpc2k/Kconfig
@@ -2,4 +2,11 @@ if ARCH_LPC2K
 
 comment "LPC2K machines"
 
+config MACH_EA2478DEVKIT
+	bool "Embedded Artists LPC2478 Developer's Kit"
+	help
+	  Say Y if you want the kernel to support the EmbeddedArtists
+	  LPC2478 Developer's Kit. For more hardware details, see:
+	  http://www.embeddedartists.com/products/kits/lpc2478_kit.php
+
 endif
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 2c50bb9..93e27fb 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1,3 @@
 obj-y	:= clock.o irq.o gpio.o mfp.o time.o
+
+obj-$(CONFIG_MACH_EA2478DEVKIT) += mach-ea2478devkit.o
diff --git a/arch/arm/mach-lpc2k/common.h b/arch/arm/mach-lpc2k/common.h
new file mode 100644
index 0000000..6b775d9
--- /dev/null
+++ b/arch/arm/mach-lpc2k/common.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef LPC2K_COMMON_H
+#define LPC2K_COMMON_H
+
+struct sys_timer;
+
+extern void lpc2k_init_clocks(unsigned long xtal, unsigned long rtc);
+extern void lpc2k_mfp_config(unsigned long *mfp_cfgs, int num);
+extern void lpc2k_init_irq(void);
+
+extern struct sys_timer lpc2k_timer;
+
+#endif /* LPC2K_COMMON_H */
diff --git a/arch/arm/mach-lpc2k/mach-ea2478devkit.c b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
new file mode 100644
index 0000000..d59f5ba
--- /dev/null
+++ b/arch/arm/mach-lpc2k/mach-ea2478devkit.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/mfp-lpc24xx.h>
+#include <mach/hardware.h>
+
+#include "common.h"
+
+#define EXTPOLAR	0x14c
+
+static unsigned long mfp_cfgs[] __initdata = {
+	/* UART0 */
+	P0_2_TXD0,
+	P0_3_RXD0,
+	/* USB Host */
+	P0_12_USB_PPWR2,
+	P0_13_USB_UP_LED2,
+	P0_31_USB_Dp2,
+	P1_30_VBUS,
+	P1_31_USB_OVRCR2,
+	/* USB Gadget */
+	P0_29_USB_Dp1,
+	P0_30_USB_Dn1,
+	/* Ethernet */
+	P1_0_ENET_TXD0,
+	P1_1_ENET_TXD1,
+	P1_4_ENET_TX_EN,
+	P1_8_ENET_CRS,
+	P1_9_ENET_RXD0,
+	P1_10_ENET_RXD1,
+	P1_14_ENET_RX_ERR,
+	P1_15_ENET_REF_CLK,
+	P1_16_ENET_MDC,
+	P1_17_ENET_MDIO,
+	/* I2C0 */
+	P0_27_SDA0,
+	P0_28_SCL0,
+	/* SPI */
+	P0_15_SCK,
+	P0_17_MISO,
+	P0_18_MOSI,
+	/* LCD */
+	P0_4_LCDVD0,
+	P0_5_LCDVD1,
+	P0_6_LCDVD8,
+	P0_7_LCDVD9,
+	P0_8_LCDVD16,
+	P0_9_LCDVD17,
+	P1_20_LCDVD10,
+	P1_21_LCDVD11,
+	P1_22_LCDVD12,
+	P1_23_LCDVD13,
+	P1_24_LCDVD14,
+	P1_25_LCDVD15,
+	P1_26_LCDVD20,
+	P1_27_LCDVD21,
+	P1_28_LCDVD22,
+	P1_29_LCDVD23,
+	P2_0_LCDPWR,
+	P2_1_LCDLE,
+	P2_2_LCDDCLK,
+	P2_3_LCDFP,
+	P2_4_LCDM,
+	P2_5_LCDLP,
+	P2_6_LCDVP4,
+	P2_7_LCDVP5,
+	P2_8_LCDVP6,
+	P2_9_LCDVP7,
+	P2_11_LCDCLKIN,
+	P2_12_LCDVP18,
+	P2_13_LCDVP19,
+	P4_28_LCDVP2,
+	P4_29_LCDVP3,
+	/* Backlight */
+	P1_18_PWM1,
+	/* MMC/SD */
+	P1_2_MCICLK,
+	P1_3_MCICMD,
+	P1_5_MCIPWR,
+	P1_6_MCIDAT0,
+	P1_7_MCIDAT1,
+	P1_11_MCIDAT2,
+	P1_12_MCIDAT3,
+};
+
+void __init ea2478devkit_init_machine(void)
+{
+	lpc2k_mfp_config(mfp_cfgs, ARRAY_SIZE(mfp_cfgs));
+}
+
+static void __init ea2478devkit_init_irq(void)
+{
+	/* XXX workaround for the fact that EINT3 is connected to high-active
+	 * signal, but can't be disabled. As the EINT3 interrupt is also used
+	 * for GPIO interrupts, this will cause an interrupt storm without
+	 * this setting.
+	 */
+	iowrite32(ioread32(APB_SCB_BASE + EXTPOLAR) | (1 << 3),
+		APB_SCB_BASE + EXTPOLAR);
+
+	lpc2k_init_irq();
+	lpc2k_init_clocks(12000000UL, 32768UL);
+}
+
+MACHINE_START(EA2478DEVKIT, "Embedded Artists LPC2478 Developer's Kit")
+	.init_irq	= ea2478devkit_init_irq,
+	.timer		= &lpc2k_timer,
+	.init_machine	= ea2478devkit_init_machine,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9d6feaa..852cc95 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -12,7 +12,7 @@
 #
 #   http://www.arm.linux.org.uk/developer/machines/?action=new
 #
-# Last update: Mon Feb 7 08:59:27 2011
+# Last update: Fri Mar 18 20:55:51 2011
 #
 # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
 #
@@ -1319,7 +1319,6 @@ mistral			MACH_MISTRAL		MISTRAL			1315
 msm			MACH_MSM		MSM			1316
 ct5910			MACH_CT5910		CT5910			1317
 ct5912			MACH_CT5912		CT5912			1318
-hynet_ine		MACH_HYNET_INE		HYNET_INE		1319
 hynet_app		MACH_HYNET_APP		HYNET_APP		1320
 msm7200			MACH_MSM7200		MSM7200			1321
 msm7600			MACH_MSM7600		MSM7600			1322
@@ -1777,7 +1776,6 @@ wdg002			MACH_WDG002		WDG002			1785
 sg560adsl		MACH_SG560ADSL		SG560ADSL		1786
 nextio_n2800_ica	MACH_NEXTIO_N2800_ICA	NEXTIO_N2800_ICA	1787
 dove_db			MACH_DOVE_DB		DOVE_DB			1788
-marvell_newdb		MACH_MARVELL_NEWDB	MARVELL_NEWDB		1789
 vandihud		MACH_VANDIHUD		VANDIHUD		1790
 magx_e8			MACH_MAGX_E8		MAGX_E8			1791
 magx_z6			MACH_MAGX_Z6		MAGX_Z6			1792
@@ -1877,7 +1875,6 @@ ued			MACH_UED		UED			1885
 esiblade		MACH_ESIBLADE		ESIBLADE		1886
 eye02			MACH_EYE02		EYE02			1887
 imx27kbd		MACH_IMX27KBD		IMX27KBD		1888
-sst61vc010_fpga		MACH_SST61VC010_FPGA	SST61VC010_FPGA		1889
 kixvp435		MACH_KIXVP435		KIXVP435		1890
 kixnp435		MACH_KIXNP435		KIXNP435		1891
 africa			MACH_AFRICA		AFRICA			1892
@@ -2308,7 +2305,6 @@ ecac2378		MACH_ECAC2378		ECAC2378		2319
 tazkiosk		MACH_TAZKIOSK		TAZKIOSK		2320
 whiterabbit_mch		MACH_WHITERABBIT_MCH	WHITERABBIT_MCH		2321
 sbox9263		MACH_SBOX9263		SBOX9263		2322
-oreo			MACH_OREO		OREO			2323
 smdk6442		MACH_SMDK6442		SMDK6442		2324
 openrd_base		MACH_OPENRD_BASE	OPENRD_BASE		2325
 incredible		MACH_INCREDIBLE		INCREDIBLE		2326
@@ -2374,7 +2370,6 @@ sch_m490		MACH_SCH_M490		SCH_M490		2386
 rbl01			MACH_RBL01		RBL01			2387
 omnifi			MACH_OMNIFI		OMNIFI			2388
 otavalo			MACH_OTAVALO		OTAVALO			2389
-sienna			MACH_SIENNA		SIENNA			2390
 htc_excalibur_s620	MACH_HTC_EXCALIBUR_S620	HTC_EXCALIBUR_S620	2391
 htc_opal		MACH_HTC_OPAL		HTC_OPAL		2392
 touchbook		MACH_TOUCHBOOK		TOUCHBOOK		2393
@@ -2446,7 +2441,6 @@ siogentoo1		MACH_SIOGENTOO1		SIOGENTOO1		2458
 siogentoo2		MACH_SIOGENTOO2		SIOGENTOO2		2459
 sm3k			MACH_SM3K		SM3K			2460
 acer_tempo_f900		MACH_ACER_TEMPO_F900	ACER_TEMPO_F900		2461
-sst61vc010_dev		MACH_SST61VC010_DEV	SST61VC010_DEV		2462
 glittertind		MACH_GLITTERTIND	GLITTERTIND		2463
 omap_zoom3		MACH_OMAP_ZOOM3		OMAP_ZOOM3		2464
 omap_3630sdp		MACH_OMAP_3630SDP	OMAP_3630SDP		2465
@@ -2498,7 +2492,6 @@ hiram			MACH_HIRAM		HIRAM			2510
 phy3250			MACH_PHY3250		PHY3250			2511
 ea3250			MACH_EA3250		EA3250			2512
 fdi3250			MACH_FDI3250		FDI3250			2513
-whitestone		MACH_WHITESTONE		WHITESTONE		2514
 at91sam9263nit		MACH_AT91SAM9263NIT	AT91SAM9263NIT		2515
 ccmx51			MACH_CCMX51		CCMX51			2516
 ccmx51js		MACH_CCMX51JS		CCMX51JS		2517
@@ -2561,7 +2554,6 @@ magnolia2		MACH_MAGNOLIA2		MAGNOLIA2		2573
 emxx			MACH_EMXX		EMXX			2574
 outlaw			MACH_OUTLAW		OUTLAW			2575
 riot_bei2		MACH_RIOT_BEI2		RIOT_BEI2		2576
-riot_vox		MACH_RIOT_VOX		RIOT_VOX		2577
 riot_x37		MACH_RIOT_X37		RIOT_X37		2578
 mega25mx		MACH_MEGA25MX		MEGA25MX		2579
 benzina2		MACH_BENZINA2		BENZINA2		2580
@@ -2582,7 +2574,6 @@ omap3_bulldog		MACH_OMAP3_BULLDOG	OMAP3_BULLDOG		2594
 pca101			MACH_PCA101		PCA101			2595
 buzzc			MACH_BUZZC		BUZZC			2596
 sasie2			MACH_SASIE2		SASIE2			2597
-davinci_cio		MACH_DAVINCI_CIO	DAVINCI_CIO		2598
 smartmeter_dl		MACH_SMARTMETER_DL	SMARTMETER_DL		2599
 wzl6410			MACH_WZL6410		WZL6410			2600
 wzl6410m		MACH_WZL6410M		WZL6410M		2601
@@ -2591,7 +2582,6 @@ wzl6410i		MACH_WZL6410I		WZL6410I		2603
 spacecom1		MACH_SPACECOM1		SPACECOM1		2604
 pingu920		MACH_PINGU920		PINGU920		2605
 bravoc			MACH_BRAVOC		BRAVOC			2606
-cybo2440		MACH_CYBO2440		CYBO2440		2607
 vdssw			MACH_VDSSW		VDSSW			2608
 romulus			MACH_ROMULUS		ROMULUS			2609
 omap_magic		MACH_OMAP_MAGIC		OMAP_MAGIC		2610
@@ -2667,7 +2657,7 @@ msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
 micro2440		MACH_MICRO2440		MICRO2440		2680
 am2440			MACH_AM2440		AM2440			2681
 tq2440			MACH_TQ2440		TQ2440			2682
-lpc2478oem		MACH_LPC2478OEM		LPC2478OEM		2683
+ea2478devkit		MACH_EA2478DEVKIT	EA2478DEVKIT		2683
 ak880x			MACH_AK880X		AK880X			2684
 cobra3530		MACH_COBRA3530		COBRA3530		2685
 pmppb			MACH_PMPPB		PMPPB			2686
@@ -2683,7 +2673,6 @@ lkevm			MACH_LKEVM		LKEVM			2695
 mw6410			MACH_MW6410		MW6410			2696
 terastation_wxl		MACH_TERASTATION_WXL	TERASTATION_WXL		2697
 cpu8000e		MACH_CPU8000E		CPU8000E		2698
-catania			MACH_CATANIA		CATANIA			2699
 tokyo			MACH_TOKYO		TOKYO			2700
 msm7201a_surf		MACH_MSM7201A_SURF	MSM7201A_SURF		2701
 msm7201a_ffa		MACH_MSM7201A_FFA	MSM7201A_FFA		2702
@@ -2741,7 +2730,6 @@ wbd222			MACH_WBD222		WBD222			2753
 mt65xx			MACH_MT65XX		MT65XX			2754
 msm8x60_surf		MACH_MSM8X60_SURF	MSM8X60_SURF		2755
 msm8x60_sim		MACH_MSM8X60_SIM	MSM8X60_SIM		2756
-vmc300			MACH_VMC300		VMC300			2757
 tcc8000_sdk		MACH_TCC8000_SDK	TCC8000_SDK		2758
 nanos			MACH_NANOS		NANOS			2759
 stamp9g10		MACH_STAMP9G10		STAMP9G10		2760
@@ -2750,7 +2738,6 @@ h6053			MACH_H6053		H6053			2762
 smint01			MACH_SMINT01		SMINT01			2763
 prtlvt2			MACH_PRTLVT2		PRTLVT2			2764
 ap420			MACH_AP420		AP420			2765
-htcshift		MACH_HTCSHIFT		HTCSHIFT		2766
 davinci_dm365_fc	MACH_DAVINCI_DM365_FC	DAVINCI_DM365_FC	2767
 msm8x55_surf		MACH_MSM8X55_SURF	MSM8X55_SURF		2768
 msm8x55_ffa		MACH_MSM8X55_FFA	MSM8X55_FFA		2769
@@ -2761,7 +2748,6 @@ oreo_controller		MACH_OREO_CONTROLLER	OREO_CONTROLLER		2773
 kopin_models		MACH_KOPIN_MODELS	KOPIN_MODELS		2774
 ttc_vision2		MACH_TTC_VISION2	TTC_VISION2		2775
 cns3420vb		MACH_CNS3420VB		CNS3420VB		2776
-lpc2			MACH_LPC2		LPC2			2777
 olympus			MACH_OLYMPUS		OLYMPUS			2778
 vortex			MACH_VORTEX		VORTEX			2779
 s5pc200			MACH_S5PC200		S5PC200			2780
@@ -2788,7 +2774,6 @@ ti8168evm		MACH_TI8168EVM		TI8168EVM		2800
 neocoreomap		MACH_NEOCOREOMAP	NEOCOREOMAP		2801
 withings_wbp		MACH_WITHINGS_WBP	WITHINGS_WBP		2802
 dbps			MACH_DBPS		DBPS			2803
-sbc9261			MACH_SBC9261		SBC9261			2804
 pcbfp0001		MACH_PCBFP0001		PCBFP0001		2805
 speedy			MACH_SPEEDY		SPEEDY			2806
 chrysaor		MACH_CHRYSAOR		CHRYSAOR		2807
@@ -2812,7 +2797,6 @@ p565			MACH_P565		P565			2824
 acer_a4			MACH_ACER_A4		ACER_A4			2825
 davinci_dm368_bip	MACH_DAVINCI_DM368_BIP	DAVINCI_DM368_BIP	2826
 eshare			MACH_ESHARE		ESHARE			2827
-hw_omapl138_europa	MACH_HW_OMAPL138_EUROPA	HW_OMAPL138_EUROPA	2828
 wlbargn			MACH_WLBARGN		WLBARGN			2829
 bm170			MACH_BM170		BM170			2830
 netspace_mini_v2	MACH_NETSPACE_MINI_V2	NETSPACE_MINI_V2	2831
@@ -2879,7 +2863,6 @@ davinci_picto		MACH_DAVINCI_PICTO	DAVINCI_PICTO		2891
 mecha			MACH_MECHA		MECHA			2892
 bubba3			MACH_BUBBA3		BUBBA3			2893
 pupitre			MACH_PUPITRE		PUPITRE			2894
-tegra_harmony		MACH_TEGRA_HARMONY	TEGRA_HARMONY		2895
 tegra_vogue		MACH_TEGRA_VOGUE	TEGRA_VOGUE		2896
 tegra_e1165		MACH_TEGRA_E1165	TEGRA_E1165		2897
 simplenet		MACH_SIMPLENET		SIMPLENET		2898
@@ -2969,7 +2952,6 @@ netspace_lite_v2	MACH_NETSPACE_LITE_V2	NETSPACE_LITE_V2	2983
 ssc			MACH_SSC		SSC			2984
 premierwave_en		MACH_PREMIERWAVE_EN	PREMIERWAVE_EN		2985
 wasabi			MACH_WASABI		WASABI			2986
-vivow			MACH_VIVOW		VIVOW			2987
 mx50_rdp		MACH_MX50_RDP		MX50_RDP		2988
 universal_c210		MACH_UNIVERSAL_C210	UNIVERSAL_C210		2989
 real6410		MACH_REAL6410		REAL6410		2990
@@ -3017,12 +2999,10 @@ remus			MACH_REMUS		REMUS			3031
 at91cap7xdk		MACH_AT91CAP7XDK	AT91CAP7XDK		3032
 at91cap7stk		MACH_AT91CAP7STK	AT91CAP7STK		3033
 kt_sbc_sam9_1		MACH_KT_SBC_SAM9_1	KT_SBC_SAM9_1		3034
-oratisrouter		MACH_ORATISROUTER	ORATISROUTER		3035
 armada_xp_db		MACH_ARMADA_XP_DB	ARMADA_XP_DB		3036
 spdm			MACH_SPDM		SPDM			3037
 gtib			MACH_GTIB		GTIB			3038
 dgm3240			MACH_DGM3240		DGM3240			3039
-atlas_i_lpe		MACH_ATLAS_I_LPE	ATLAS_I_LPE		3040
 htcmega			MACH_HTCMEGA		HTCMEGA			3041
 tricorder		MACH_TRICORDER		TRICORDER		3042
 tx28			MACH_TX28		TX28			3043
@@ -3062,7 +3042,6 @@ clod			MACH_CLOD		CLOD			3077
 rump			MACH_RUMP		RUMP			3078
 tenderloin		MACH_TENDERLOIN		TENDERLOIN		3079
 shortloin		MACH_SHORTLOIN		SHORTLOIN		3080
-crespo			MACH_CRESPO		CRESPO			3081
 antares			MACH_ANTARES		ANTARES			3082
 wb40n			MACH_WB40N		WB40N			3083
 herring			MACH_HERRING		HERRING			3084
@@ -3111,7 +3090,6 @@ smartqv3		MACH_SMARTQV3		SMARTQV3		3126
 smartqv7		MACH_SMARTQV7		SMARTQV7		3127
 paz00			MACH_PAZ00		PAZ00			3128
 acmenetusfoxg20		MACH_ACMENETUSFOXG20	ACMENETUSFOXG20		3129
-htcwillow		MACH_HTCWILLOW		HTCWILLOW		3130
 fwbd_0404		MACH_FWBD_0404		FWBD_0404		3131
 hdgu			MACH_HDGU		HDGU			3132
 pyramid			MACH_PYRAMID		PYRAMID			3133
@@ -3162,7 +3140,6 @@ b5500			MACH_B5500		B5500			3177
 s5500			MACH_S5500		S5500			3178
 icon			MACH_ICON		ICON			3179
 elephant		MACH_ELEPHANT		ELEPHANT		3180
-msm8x60_fusion		MACH_MSM8X60_FUSION	MSM8X60_FUSION		3181
 shooter			MACH_SHOOTER		SHOOTER			3182
 spade_lte		MACH_SPADE_LTE		SPADE_LTE		3183
 philhwani		MACH_PHILHWANI		PHILHWANI		3184
@@ -3174,13 +3151,11 @@ ag5evm			MACH_AG5EVM		AG5EVM			3189
 sc575plc		MACH_SC575PLC		SC575PLC		3190
 sc575hmi		MACH_SC575IPC		SC575IPC		3191
 omap3_tdm3730		MACH_OMAP3_TDM3730	OMAP3_TDM3730		3192
-g7			MACH_G7			G7			3193
 top9000_eval		MACH_TOP9000_EVAL	TOP9000_EVAL		3194
 top9000_su		MACH_TOP9000_SU		TOP9000_SU		3195
 utm300			MACH_UTM300		UTM300			3196
 tsunagi			MACH_TSUNAGI		TSUNAGI			3197
 ts75xx			MACH_TS75XX		TS75XX			3198
-msm8x60_fusn_ffa	MACH_MSM8X60_FUSN_FFA	MSM8X60_FUSN_FFA	3199
 ts47xx			MACH_TS47XX		TS47XX			3200
 da850_k5		MACH_DA850_K5		DA850_K5		3201
 ax502			MACH_AX502		AX502			3202
@@ -3285,7 +3260,7 @@ rfl109145_ssrv		MACH_RFL109145_SSRV	RFL109145_SSRV		3304
 nmh			MACH_NMH		NMH			3305
 wn802t			MACH_WN802T		WN802T			3306
 dragonet		MACH_DRAGONET		DRAGONET		3307
-geneva_b		MACH_GENEVA_B		GENEVA_B		3308
+geneva_b4		MACH_GENEVA_B		GENEVA_B		3308
 at91sam9263desk16l	MACH_AT91SAM9263DESK16L	AT91SAM9263DESK16L	3309
 bcmhana_sv		MACH_BCMHANA_SV		BCMHANA_SV		3310
 bcmhana_tablet		MACH_BCMHANA_TABLET	BCMHANA_TABLET		3311
@@ -3316,3 +3291,85 @@ rover_g8		MACH_ROVER_G8		ROVER_G8		3335
 t5388p			MACH_T5388P		T5388P			3336
 dingo			MACH_DINGO		DINGO			3337
 goflexhome		MACH_GOFLEXHOME		GOFLEXHOME		3338
+lanreadyfn511		MACH_LANREADYFN511	LANREADYFN511		3340
+omap3_baia		MACH_OMAP3_BAIA		OMAP3_BAIA		3341
+omap3smartdisplay	MACH_OMAP3SMARTDISPLAY	OMAP3SMARTDISPLAY	3342
+xilinx			MACH_XILINX		XILINX			3343
+a2f			MACH_A2F		A2F			3344
+sky25			MACH_SKY25		SKY25			3345
+ccmx53			MACH_CCMX53		CCMX53			3346
+ccmx53js		MACH_CCMX53JS		CCMX53JS		3347
+ccwmx53			MACH_CCWMX53		CCWMX53			3348
+ccwmx53js		MACH_CCWMX53JS		CCWMX53JS		3349
+frisms			MACH_FRISMS		FRISMS			3350
+msm7x27a_ffa		MACH_MSM7X27A_FFA	MSM7X27A_FFA		3351
+msm7x27a_surf		MACH_MSM7X27A_SURF	MSM7X27A_SURF		3352
+msm7x27a_rumi3		MACH_MSM7X27A_RUMI3	MSM7X27A_RUMI3		3353
+dimmsam9g20		MACH_DIMMSAM9G20	DIMMSAM9G20		3354
+dimm_imx28		MACH_DIMM_IMX28		DIMM_IMX28		3355
+amk_a4			MACH_AMK_A4		AMK_A4			3356
+gnet_sgme		MACH_GNET_SGME		GNET_SGME		3357
+shooter_u		MACH_SHOOTER_U		SHOOTER_U		3358
+vmx53			MACH_VMX53		VMX53			3359
+rhino			MACH_RHINO		RHINO			3360
+armlex4210		MACH_ARMLEX4210		ARMLEX4210		3361
+swarcoextmodem		MACH_SWARCOEXTMODEM	SWARCOEXTMODEM		3362
+snowball		MACH_SNOWBALL		SNOWBALL		3363
+pcm049			MACH_PCM049		PCM049			3364
+vigor			MACH_VIGOR		VIGOR			3365
+oslo_amundsen		MACH_OSLO_AMUNDSEN	OSLO_AMUNDSEN		3366
+gsl_diamond		MACH_GSL_DIAMOND	GSL_DIAMOND		3367
+cv2201			MACH_CV2201		CV2201			3368
+cv2202			MACH_CV2202		CV2202			3369
+cv2203			MACH_CV2203		CV2203			3370
+vit_ibox		MACH_VIT_IBOX		VIT_IBOX		3371
+dm6441_esp		MACH_DM6441_ESP		DM6441_ESP		3372
+at91sam9x5ek		MACH_AT91SAM9X5EK	AT91SAM9X5EK		3373
+libra			MACH_LIBRA		LIBRA			3374
+easycrrh		MACH_EASYCRRH		EASYCRRH		3375
+tripel			MACH_TRIPEL		TRIPEL			3376
+endian_mini		MACH_ENDIAN_MINI	ENDIAN_MINI		3377
+xilinx_ep107		MACH_XILINX_EP107	XILINX_EP107		3378
+nuri			MACH_NURI		NURI			3379
+janus			MACH_JANUS		JANUS			3380
+ddnas			MACH_DDNAS		DDNAS			3381
+tag			MACH_TAG		TAG			3382
+tagw			MACH_TAGW		TAGW			3383
+nitrogen_vm_imx51	MACH_NITROGEN_VM_IMX51	NITROGEN_VM_IMX51	3384
+viprinet		MACH_VIPRINET		VIPRINET		3385
+bockw			MACH_BOCKW		BOCKW			3386
+eva2000			MACH_EVA2000		EVA2000			3387
+steelyard		MACH_STEELYARD		STEELYARD		3388
+ea2468devkit		MACH_LPC2468OEM		LPC2468OEM		3389
+sdh001			MACH_MACH_SDH001	MACH_SDH001		3390
+fe2478microblox		MACH_LPC2478MICROBLOX	LPC2478MICROBLOX	3391
+nsslsboard		MACH_NSSLSBOARD		NSSLSBOARD		3392
+geneva_b5		MACH_GENEVA_B5		GENEVA_B5		3393
+spear1340		MACH_SPEAR1340		SPEAR1340		3394
+rexmas			MACH_REXMAS		REXMAS			3395
+msm8960_cdp		MACH_MSM8960_CDP	MSM8960_CDP		3396
+msm8960_mdp		MACH_MSM8960_MDP	MSM8960_MDP		3397
+msm8960_fluid		MACH_MSM8960_FLUID	MSM8960_FLUID		3398
+msm8960_apq		MACH_MSM8960_APQ	MSM8960_APQ		3399
+helios_v2		MACH_HELIOS_V2		HELIOS_V2		3400
+mif10p			MACH_MIF10P		MIF10P			3401
+iam28			MACH_IAM28		IAM28			3402
+picasso			MACH_PICASSO		PICASSO			3403
+mr301a			MACH_MR301A		MR301A			3404
+notle			MACH_NOTLE		NOTLE			3405
+eelx2			MACH_EELX2		EELX2			3406
+moon			MACH_MOON		MOON			3407
+ruby			MACH_RUBY		RUBY			3408
+goldengate		MACH_GOLDENGATE		GOLDENGATE		3409
+ctbu_gen2		MACH_CTBU_GEN2		CTBU_GEN2		3410
+kmp_am17_01		MACH_KMP_AM17_01	KMP_AM17_01		3411
+wtplug			MACH_WTPLUG		WTPLUG			3412
+mx27su2			MACH_MX27SU2		MX27SU2			3413
+nb31			MACH_NB31		NB31			3414
+hjsdu			MACH_HJSDU		HJSDU			3415
+td3_rev1		MACH_TD3_REV1		TD3_REV1		3416
+eag_ci4000		MACH_EAG_CI4000		EAG_CI4000		3417
+net5big_nand_v2		MACH_NET5BIG_NAND_V2	NET5BIG_NAND_V2		3418
+cpx2			MACH_CPX2		CPX2			3419
+net2big_nand_v2		MACH_NET2BIG_NAND_V2	NET2BIG_NAND_V2		3420
+ecuv5			MACH_ECUV5		ECUV5			3421
-- 
1.7.1
