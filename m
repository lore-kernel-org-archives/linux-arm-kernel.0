From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 25 Feb 2018 09:54:12 +0000
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180224060039.GA3217@dragon>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
 <20180223150352.GU3217@dragon> <201802231630.45460.jbe@pengutronix.de>
 <1519400769.8609.3.camel@pengutronix.de>
 <AM4PR0401MB23242FA10FAFF2C23443940690C30@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <20180224060039.GA3217@dragon>
Message-ID: <AM3PR04MB306682908666E720E2BFD7F80C20@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Saturday, February 24, 2018 2:01 PM
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Juergen Borleis
> <jbe@pengutronix.de>; kernel at pengutronix.de; Mark Rutland
> <mark.rutland@arm.com>; devicetree at vger.kernel.org; Baruch Siach
> <baruch@tkos.co.il>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will.deacon@arm.com>; patchwork-lst at pengutronix.de; Rob
> Herring <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>; Fabio
> Estevam <fabio.estevam@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
> 
> Hi Bough,
> 
> On Sat, Feb 24, 2018 at 02:58:31AM +0000, Bough Chen wrote:
> > >Am Freitag, den 23.02.2018, 16:30 +0100 schrieb Juergen Borleis:
> > >> On Friday 23 February 2018 16:03:53 Shawn Guo wrote:
> > >> > On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> > >> > > +&usdhc1 {
> > >> > > +???pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > >> > > +???pinctrl-0 = <&pinctrl_usdhc1_cd_reset>,
> > >> <&pinctrl_usdhc1_clk_strobe>,
> > >> > > +?????????????? <&pinctrl_usdhc1_data>;
> > >> > > +???pinctrl-1 = <&pinctrl_usdhc1_cd_reset>,
> > >> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_100mhz>,
> > >> > > +?????????????? <&pinctrl_usdhc1_data_100mhz>;
> > >> > > +???pinctrl-2 = <&pinctrl_usdhc1_cd_reset>,
> > >> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_200mhz>,
> > >> > > +?????????????? <&pinctrl_usdhc1_data_200mhz>;
> > >> > > +???vqmmc-supply = <&sw4_reg>;
> > >> > > +???bus-width = <8>;
> > >> > > +???non-removable;
> > >> > > +???no-sd;
> > >> > > +???no-sdio;
> > >> > > +???status = "okay";
> > >> > > +};
> > >> >
> >
> > EMMC do not need cd pin, and I notice that pinctrl_usdhc1_cd_reset also
> contains a usdhc2 pad, this is wrong. So please remove
> pinctrl_usdhc1_cd_reset.
> > EMMC I/O voltage is fixed to 1.8v so I think no need to add vqmmc-supply,
> can remove this property here.
> > For pinctrl_usdhc1_clk_strobe, clock pad need to be pull down, otherwise
> you will meet data crc error in hs400 mode.
> 
> Thanks for the input.  I suspect that there are more than what you suggest
> here.  I remove vqmmc-supply and use the exactly same
> pinctrl_usdhc1 as NXP kernel, but still see errors below.
> 
> [    0.952795] mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc]
> using ADMA
> [    1.054622] mmc0: Tuning failed, falling back to fixed sampling clock
> [    1.076458] mmc0: new HS400 MMC card at address 0001
> [    1.081980] mmcblk0: mmc0:0001 R1J56L 13.8 GiB
> [    1.086880] mmcblk0boot0: mmc0:0001 R1J56L partition 1 4.00 MiB
> [    1.093156] mmcblk0boot1: mmc0:0001 R1J56L partition 2 4.00 MiB
> [    1.099220] mmcblk0rpmb: mmc0:0001 R1J56L partition 3 128 KiB, chardev
> (248:0)
> [    1.148214] mmc0: Tuning failed, falling back to fixed sampling clock
> [    1.266704] print_req_error: I/O error, dev mmcblk0, sector 0
> [    1.273487] Buffer I/O error on dev mmcblk0, logical block 0, async page
> read
> [    1.358863] print_req_error: I/O error, dev mmcblk0, sector 0
> [    1.365640] Buffer I/O error on dev mmcblk0, logical block 0, async page
> read
> [    1.372816]  mmcblk0: unable to read partition table
> [    7.231120] mmc0: switch to high-speed from hs200 failed, err:-110
> [    7.372241] mmc0: switch to high-speed from hs200 failed, err:-110
> [    7.378843] print_req_error: I/O error, dev mmcblk0, sector 0
> 

I did a few debug and made it work with below changes.
There's a few quirk delays used in downstream tree to handle some special
characteristic for uSDHC tuning.

Haibo is uSDHC expert from NXP. He can help follow up it later.

I'd suggest not enable HS400 or HS200 in this bring up series at this time
If we can't find a quick and reasonable way to fix it.

>From 0520477f5020632abdaccde440f0efcf6d284025 Mon Sep 17 00:00:00 2001
From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Sun, 25 Feb 2018 12:23:27 +0800
Subject: [PATCH 1/1] hs400 work new

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 2 ++
 drivers/mmc/host/sdhci-esdhc-imx.c           | 1 +
 drivers/mmc/host/sdhci.c                     | 5 ++++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index c0e5ee5d..5da40bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -167,7 +167,7 @@
 	            <&pinctrl_usdhc2_data_200mhz>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
+	status = "disabled";
 };
 
 &iomuxc {
@@ -316,6 +316,7 @@
 			>;
 		drive-strength = <7>;
 		slew-rate = <3>;
+		input-schmitt-enable;
 	};
 
 	pinctrl_usdhc1_data_200mhz: usdhc1data200grp {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50ed302..34fef6c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -357,6 +357,8 @@
 				clocks = <&clk IMX8MQ_CLK_DUMMY>,
 				         <&clk IMX8MQ_CLK_NAND_USDHC_BUS_DIV>,
 				         <&clk IMX8MQ_CLK_USDHC1_ROOT>;
+				assigned-clocks = <&clk IMX8MQ_CLK_USDHC1_DIV>;
+				assigned-clock-rates = <400000000>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step = <2>;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8b941f8..d26d3710 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1311,6 +1311,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
+	host->tuning_delay = 1;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3..548837d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2116,8 +2116,11 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
-			if (ctrl & SDHCI_CTRL_TUNED_CLK)
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				printk("tuning pass, delay 1ms\n");
+				mdelay(1);
 				return; /* Success! */
+			}
 			break;
 		}
 
-- 
2.7.4

Regards
Dong Aisheng

> Shawn
