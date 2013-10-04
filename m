From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Oct 2013 13:07:03 -0300
Subject: IMX6 USDHC card detection
In-Reply-To: <20131003193623.GF12758@n2100.arm.linux.org.uk>
References: <20131003193623.GF12758@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DrdXpWuULubSjSw7fhCm40JiXnVZwu=YMjzX1sW_tuuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 4:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Having spent many hours chasing around wondering why controller based
> card detection doesn't work on IMX6, I've finally found it.
>
> The hardware is setup such that we have a card detect signal routed to
> GPIO 4.  If we try and use the host controller's built-in card detection,
> things go awry - the host controller believes that a card is always
> inserted.
>
> This appears to be because the kernel sets the D3CD bit in the PROT_CTRL
> register.  This enables card detection via the DAT3 signal, which
> indicates a logic '1' level when a card is inserted.  SD cards have a 50k
> pullup internally which provides the card detection mechanism, and hosts
> are expected to have a weak pull-down on this signal.
>
> However, the default setup of the SD data lines in IOMUX is this (eg):
>
>              MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
>              MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
>              MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
>              MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
>
> Bits 14 and 15 indicate "pull this pin up via a 22K resistor".
>
> What you end up with is the SD controller believes that a card is always
> inserted no matter what you do.  You can see this through the PRES_STATE
> register - you see bit 18 assert/deassert appropriately on card insertion
> and removals indicating that the socket CD signal is changing state, but
> you don't see the card inserted bit (bit 16) ever change.  Neither does
> the kernel react in any way.
>
> So, are the defaults for DATA3 signals really appropriate, or should they
> be adjusted (in other words, 0x13059 for DATA3).  The alternative is to
> ignore the built-in host card detection, and configure the CD pin as a
> GPIO instead.

Ran a quick test on a mx6qsabresd.

The original imx6qdl-sabresd.dtsi uses cd-gpio for sdhc3 port and I removed it:

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -164,8 +164,6 @@
                        fsl,pins = <
                                MX6QDL_PAD_GPIO_4__GPIO1_IO04   0x80000000
                                MX6QDL_PAD_GPIO_5__GPIO1_IO05   0x80000000
-                               MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x80000000
-                               MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x80000000
                                MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
                                MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
                                MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
@@ -239,7 +237,5 @@
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_usdhc3_1>;
        bus-width = <8>;
-       cd-gpios = <&gpio2 0 0>;
-       wp-gpios = <&gpio2 1 0>;
        status = "okay";
 };

After this change,  the SD controller internal card detection also worked fine.

I see your point of SD3 needing a pull-down, so also tested:

--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1197,7 +1197,7 @@

MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059

MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059

MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-
MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+
MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x13059

MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059

MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059

MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059

and the internal card detection also worked fine here.
