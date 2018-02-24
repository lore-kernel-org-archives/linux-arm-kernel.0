From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 14:00:40 +0800
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <AM4PR0401MB23242FA10FAFF2C23443940690C30@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
 <20180223150352.GU3217@dragon>
 <201802231630.45460.jbe@pengutronix.de>
 <1519400769.8609.3.camel@pengutronix.de>
 <AM4PR0401MB23242FA10FAFF2C23443940690C30@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Message-ID: <20180224060039.GA3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bough,

On Sat, Feb 24, 2018 at 02:58:31AM +0000, Bough Chen wrote:
> >Am Freitag, den 23.02.2018, 16:30 +0100 schrieb Juergen Borleis:
> >> On Friday 23 February 2018 16:03:53 Shawn Guo wrote:
> >> > On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> >> > > +&usdhc1 {
> >> > > +???pinctrl-names = "default", "state_100mhz", "state_200mhz";
> >> > > +???pinctrl-0 = <&pinctrl_usdhc1_cd_reset>,
> >> <&pinctrl_usdhc1_clk_strobe>,
> >> > > +?????????????? <&pinctrl_usdhc1_data>;
> >> > > +???pinctrl-1 = <&pinctrl_usdhc1_cd_reset>,
> >> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_100mhz>,
> >> > > +?????????????? <&pinctrl_usdhc1_data_100mhz>;
> >> > > +???pinctrl-2 = <&pinctrl_usdhc1_cd_reset>,
> >> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_200mhz>,
> >> > > +?????????????? <&pinctrl_usdhc1_data_200mhz>;
> >> > > +???vqmmc-supply = <&sw4_reg>;
> >> > > +???bus-width = <8>;
> >> > > +???non-removable;
> >> > > +???no-sd;
> >> > > +???no-sdio;
> >> > > +???status = "okay";
> >> > > +};
> >> >
> 
> EMMC do not need cd pin, and I notice that pinctrl_usdhc1_cd_reset also contains a usdhc2 pad, this is wrong. So please remove pinctrl_usdhc1_cd_reset. 
> EMMC I/O voltage is fixed to 1.8v so I think no need to add vqmmc-supply, can remove this property here.
> For pinctrl_usdhc1_clk_strobe, clock pad need to be pull down, otherwise you will meet data crc error in hs400 mode.

Thanks for the input.  I suspect that there are more than what you
suggest here.  I remove vqmmc-supply and use the exactly same
pinctrl_usdhc1 as NXP kernel, but still see errors below.

[    0.952795] mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc] using ADMA
[    1.054622] mmc0: Tuning failed, falling back to fixed sampling clock
[    1.076458] mmc0: new HS400 MMC card at address 0001
[    1.081980] mmcblk0: mmc0:0001 R1J56L 13.8 GiB 
[    1.086880] mmcblk0boot0: mmc0:0001 R1J56L partition 1 4.00 MiB
[    1.093156] mmcblk0boot1: mmc0:0001 R1J56L partition 2 4.00 MiB
[    1.099220] mmcblk0rpmb: mmc0:0001 R1J56L partition 3 128 KiB, chardev (248:0)
[    1.148214] mmc0: Tuning failed, falling back to fixed sampling clock
[    1.266704] print_req_error: I/O error, dev mmcblk0, sector 0
[    1.273487] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    1.358863] print_req_error: I/O error, dev mmcblk0, sector 0
[    1.365640] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    1.372816]  mmcblk0: unable to read partition table
[    7.231120] mmc0: switch to high-speed from hs200 failed, err:-110
[    7.372241] mmc0: switch to high-speed from hs200 failed, err:-110
[    7.378843] print_req_error: I/O error, dev mmcblk0, sector 0

Shawn
