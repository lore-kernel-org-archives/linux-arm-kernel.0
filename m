From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Nov 2016 21:16:41 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479126185.15557.5@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
Message-ID: <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomas,

On Mon, Nov 14, 2016 at 01:23:05PM +0100, tomas.hlavacek at nic.cz wrote:
> On Sat, Nov 5, 2016 at 9:38 PM, Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> wrote:
> > This machine is an open hardware router by cz.nic driven by a
> > Marvell Armada 385.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> > ---
> > 
> > Hello,
> > 
> > the following components are working:
> > 
> >  - WAN port
> >  - eMMC
> 
> But I not not sure about DDR50 mode. At least with kernel 4.4, that we use
> in production, we had to limit to SDR50 to overcome I/O errors and
> communication instability, if I can remember it correctly. So it might need
> more testing with the current kernel.

I didn't test that extensively, but the eMMC serves my rootfs and I
didn't had any problems so far.

> > Still missing is support for the switch. Wireless fails to probe, didn't
> > debug this up to now. SFP is untested as is UART1.
> 
> Actually SFP is connected to SGMII interface of eth1, which is routed
> through SERDES 5. The SGMII line is shared between the SFP and metallic PHY
> 88E1514. There is a autonomous high-speed switch connected to the SFPDET
> signal from SFP cage. It disconnects the metallic SFP and connects SGMII to
> SFP once the module is connected.
> 
> The SFP is also connected to the I2C mux port 4 and to GPIO expander for
> reading/driving SFPDET, LOS, TXFLT, TXDIS signals:
> 
> &i2c0 {
>        pinctrl-names = "default";
>        pinctrl-0 = <&i2c0_pins>;
>        status = "okay";
>        clock-frequency = <100000>;
> 
>        i2cmux at 70 {
>                compatible = "nxp,pca9547";
>                #address-cells = <1>;
>                #size-cells = <0>;
>                reg = <0x70>;
>                status = "okay";
> 
> ...
> 
>                i2c at 7 {
>                        /* SFP+ GPIO expander */
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>                        reg = <7>;
> 
>                        sfpgpio: gpio at 71 {
>                                compatible = "nxp,pca9538";
>                                reg = <0x71>;
>                                interrupt-parent = <&gpio1>;
>                                interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
>                                gpio-controller;
>                                #gpio-cells = <2>;
>                        };

I have authored a nearly identical snippet, mine looks as follows:

+               i2c at 7 {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+                       reg = <7>;
+
+                       pcawan: gpio at 71 {
+                               compatible = "nxp,pca9538";
+                               reg = <0x71>;
+
+                               pinctrl-names = "default";
+                               pinctrl-0 = <&pcawan_pins>;
+
+                               interrupt-parent = <&gpio1>;
+                               interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+
+                               gpio-controller;
+                               #gpio-cells = <2>;
+
+                               interrupt-controller;
+                               #interrupt-cells = <2>;
+                       };
+               };

The interrupt-controller part doesn't seem to work though, at least

+               interrupt-parent = <&pcawan>;
+               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;

in the phy node gives an error.


>                };
> 	};
> };
> 
> We have our proprietary support hacked onto mvneta driver for disconnecting
> PHY on the fly. It is a bit nasty, so I suggest to ignore SFP in this DTS
> altogether and let's wait till "phylink based SFP module support" or
> something alike hits upstream, so we can base the SFP support on solid code;
> unless somebody has a better idea, of course.
> 
> > 
> > 
> > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > new file mode 100644
> > index 000000000000..d3cd8a4d713d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > @@ -0,0 +1,246 @@
> ...
> > +
> > +			/* USB part of the eSATA/USB 2.0 port */
> 
> This comment is perhaps some error inherited from my development DTS. We do
> not have any eSATA, perhaps PCIe/USB 2.0 slot.

oh right. I changed it for v3.
 
> > 
> > +			usb at 58000 {
> > +				status = "okay";
> > +			};
> > +
> > +
> > +&eth0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ge0_rgmii_pins>;
> > +	status = "okay";
> > +	phy-mode = "rgmii-id";
> > +
> > +	fixed-link {
> > +		speed = <1000>;
> > +		full-duplex;
> > +	};
> > +};
> > +
> > +&eth1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&ge1_rgmii_pins>;
> > +	status = "okay";
> > +	phy-mode = "rgmii-id";
> > +
> > +	fixed-link {
> > +		speed = <1000>;
> > +		full-duplex;
> > +	};
> > +};
> > +
> 
> Actually eth0 and eth1 (both are RGMII) are connected to the 88E6176 switch.
> The problem is that from what I have read so far the switch can not operate
> in DSA mode with two CPU ports. We currently operate the switch in "normal
> mode" with the eth0 and eth1 set to fixed-link 1000/full and with
> proprietary driver (derived from OpenWRT switch drivers). I would say that
> these records for eth0 and eth1 are therefore redundant, because it does
> nothing without the switch support and it would most likely change once we
> have DSA driver (using only eth0).

Right. They do nothing currently. In my local tree I have a
specification for the switch which allows to read the phy registers of
the lan ports, but communication isn't possible yet. For this AFAIK I
need at least one of these. I mailed a few iterations with Andrew here,
but no success so far. Also dropping one cpu port from the definition
didn't help.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/a783ea53/attachment.sig>
