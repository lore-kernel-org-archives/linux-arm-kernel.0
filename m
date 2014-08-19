From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 19 Aug 2014 08:17:03 -0700
Subject: [PATCH] ARM: dts: Gateworks GW5520 support (i.MX6)
In-Reply-To: <20140818063510.GD2114@dragon>
References: <1407572602-14017-1-git-send-email-tharvey@gateworks.com>
 <20140818063510.GD2114@dragon>
Message-ID: <CAJ+vNU0qJrNtZMcPGWkGOPuHmyiV+3d-OM71PGDNRmnJZCS8SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 11:35 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Sat, Aug 09, 2014 at 01:23:22AM -0700, Tim Harvey wrote:
>> +&iomuxc {
>
> If you do not mind, I would ask you to put iomuxc node at the bottom of
> the file.  Doing so makes the file a bit easier to read.

will do

>
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_hog>;
>> +
>> +     imx6qdl-gw552x {
>> +             pinctrl_hog: hoggrp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_GPIO_9__GPIO1_IO09     0x80000000 /* USBHUB_RST# */
>> +                             MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x80000000 /* PCIESKT_WDIS# */
>
> Please use a proper pad configuration value instead of 0x80000000, which
> will rely on the hardware reset state or what bootloader configures.

will do

>
> Also, can these two pins be moved to some pinctrl entries used by
> particular client device?

Do you know of any appropriate bindings for a USB hub reset signal?
This does get configured and used properly in the bootloader but I
thought the common belief was that GPIO's should get configured in the
kernel as well (and of course I will use a value other than 0x8000000
so that its pinmuxed and padconf'd).

The PCISKT_WDIS# is a gpio that routes to the miniPCIe socket(s) WDIS#
signal. While no kernel driver uses it I think its valuable to
document to users such that they can export it and use it for rfkill
of wireless devices that may be placed in those sockets. I'm not aware
of a proper binding for an rfkill pin either.

If no bindings exist, are you saying these should be dropped and thus
functionality hidden from a user possibly trying to use them from
userspace through gpio-sysfs or are you saying they should be moved
into pinctrl groups for logical grouping?

>
>> +                     >;
>> +             };
>> +
>> +             pinctrl_gpmi_nand: gpminandgrp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_NANDF_CLE__NAND_CLE          0xb0b1
>> +                             MX6QDL_PAD_NANDF_ALE__NAND_ALE          0xb0b1
>> +                             MX6QDL_PAD_NANDF_WP_B__NAND_WP_B        0xb0b1
>> +                             MX6QDL_PAD_NANDF_RB0__NAND_READY_B      0xb000
>> +                             MX6QDL_PAD_NANDF_CS0__NAND_CE0_B        0xb0b1
>> +                             MX6QDL_PAD_NANDF_CS1__NAND_CE1_B        0xb0b1
>> +                             MX6QDL_PAD_SD4_CMD__NAND_RE_B           0xb0b1
>> +                             MX6QDL_PAD_SD4_CLK__NAND_WE_B           0xb0b1
>> +                             MX6QDL_PAD_NANDF_D0__NAND_DATA00        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D1__NAND_DATA01        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D2__NAND_DATA02        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D3__NAND_DATA03        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D4__NAND_DATA04        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D5__NAND_DATA05        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D6__NAND_DATA06        0xb0b1
>> +                             MX6QDL_PAD_NANDF_D7__NAND_DATA07        0xb0b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_i2c1: i2c1grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_EIM_D21__I2C1_SCL            0x4001b8b1
>> +                             MX6QDL_PAD_EIM_D28__I2C1_SDA            0x4001b8b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_i2c2: i2c2grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_KEY_COL3__I2C2_SCL           0x4001b8b1
>> +                             MX6QDL_PAD_KEY_ROW3__I2C2_SDA           0x4001b8b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_i2c3: i2c3grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_GPIO_3__I2C3_SCL             0x4001b8b1
>> +                             MX6QDL_PAD_GPIO_6__I2C3_SDA             0x4001b8b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_pcie: pciegrp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x80000000 /* PCIE_RST# */
>
> Fix 0x80000000.

will do

>
>> +                     >;
>> +             };
>> +
>> +             pinctrl_uart2: uart2grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA      0x1b0b1
>> +                             MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA      0x1b0b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_uart3: uart3grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_EIM_D24__UART3_TX_DATA       0x1b0b1
>> +                             MX6QDL_PAD_EIM_D25__UART3_RX_DATA       0x1b0b1
>> +                     >;
>> +             };
>> +
>> +             pinctrl_uart5: uart5grp {
>> +                     fsl,pins = <
>> +                             MX6QDL_PAD_KEY_COL1__UART5_TX_DATA      0x1b0b1
>> +                             MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA      0x1b0b1
>> +                     >;
>> +             };
>> +     };
>> +
>> +        gpio_leds {
>
> This node can just be saved by putting gpioledsgrp into imx6qdl-gw552x.
>> +                pinctrl_gpio_leds: gpioledsgrp {
>> +                        fsl,pins = <

ok - that makes sense, will do.

>
> Use tab for indentation.

oops - I guess checkpatch.pl doesn't catch that on dts/dtsi files

>
>> +                             MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x80000000 /* user1 led */
>> +                             MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x80000000 /* user2 led */
>> +                             MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* user3 led */
>
> Fix 0x80000000.

will do

>
> Shawn
>

Thanks for the review!

Tim
