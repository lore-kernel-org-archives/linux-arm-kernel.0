From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 6 Jan 2016 09:15:18 +0000
Subject: [PATCH v2 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160106080358.GD9030@ibawizard.net>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160106080358.GD9030@ibawizard.net>
Message-ID: <1452071716.30372.61.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr

On Wed, 2016-01-06 at 09:03 +0100, Petr ?tetiar wrote:
> Marcel Ziswiler <marcel.ziswiler@toradex.com> [2016-01-05 17:39:01]:
> 
> Hi Marcel,
> 
> thanks for taking care of this, I'm quite busy with other tasks :(

You're welcome. I know that feeling.

> > - integrated review feedback from Lucas
> 
> You've probably missed few of them :) See my nitpicks bellow.

I don't think so but we don't necessarily agree with all of Lucas'
findings plus the discussion about some of the stuff hasn't really
concluded.

> > - left and even added some more comments as I don't see why putting
> > any
> > ? explanatory comments in dts' should be such a bad thing to do

> You've marked this as v2

Well, as Stefan pointed out we at Toradex are/were working on this as
well and we discussed whether we should just ignore whatever you have
done or not done and post our own stuff but decided to rather join
efforts now as you already jumped ahead.

>  so I think, that you should only work on the
> feedback. Ideally you shouldn't add any new stuff if it wasn't
> requested
> otherwise you're wasting reviewer time.

I don't think so. What is important is that any changes are clearly
declared which we did.

> > - completely got rid of the memory node as that is something
> > typically filled
> > ? in by the boot loader e.g. U-Boot
> 
> If I'm not mistaken, it wasn't requested by the reviewer.

Lucas was actually nitpicking about the location thereof and rather
than moving it we decided to just get rid of it as it does not only not
add any value but is simply wrong on most of the modules featuring
different amount of memory.

> > - without the regulators simple-bus it no longer boots
> 
> It works for me on 4.4.0-rc3 with following DTS[1]. BTW, this DTS is
> my
> preparation for v2 patch series.

I only tried with -next stuff so it might be something is just broken
there I guess.

> > - fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver
> > to be
> > ? enabled)
> 
> Great!

Yeah, that one took us a day to figure it all out. At the end we
actually stumbled over your PCIe reset patch inverting the meaning of
active-low vs. active-high (;-p).

> > + * This file is dual-licensed: you can use it either under the
> > terms
> > + * of the GPL or the X11 license, at your option. Note that this
> > dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> 
> Hope you've some kind of ACK from FSL and Linaro :)

Well, all new DTS' are now dual-licensed including several i.MX 6
related ones so we are not doing anything special there really.

> > +		reg_usb_otg_vbus: usb_otg_vbus {
> > +			compatible = "regulator-fixed";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 =
> > <&pinctrl_regulator_usbotg_pwr>;
> > +			regulator-name = "usb_otg_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +			status = "disabled";
> > +		};
> 
> I'm not sure, but it seems to me, that we should move this regulator
> into the
> carrier board DTS. On our custom carrier board we've this regulator
> always on
> and we use this GPIO for heartbeat LED, so I've this in our carrier
> board
> DTS[2]:

Yes, you are absolutely right and e.g. on Apalis T30 [1] that is
exactly how we did it.

> 	reg_usb_otg_vbus: usb_otg_vbus {
> 		/* Regulator is always on, and we use GPIO for
> heartbeat LED */
> 		pinctrl-0 = <>;
> 		gpio = <>;
> 
> 		compatible = "regulator-fixed";
> 		regulator-name = "usb_otg_vbus";
> 		regulator-min-microvolt = <5000000>;
> 		regulator-max-microvolt = <5000000>;
> 		regulator-always-on;
> 	};
> 
> 	...
> 
> 	usbotg {
> 		/* GPIO3_IO22 is Heartbeat LED */
> 		pinctrl_regulator_usbotg_pwr: gpio_regulator_usbotg_pwr
> {
> 		};
> 	};
> 
> > +/* PAD Ctrl values for common settings */
> > +/*
> > + * (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | PAD_CTL_PKE
> > |
> > + *??PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm)
> > + */
> > +#define PAD_CTRL_HYS_PU 0x1b0b0
> 
> This was requested to be reworked. I've simply replaced all the
> macros with
> hex values.

I don't think the reviewers really concluded on the action to be taken
on here and just using hex values is probably the most stupid solution.

> > +		pinctrl_usdhc3_100mhz: usdhc3grp-100mhz { /*
> > 100Mhz */
> > +			fsl,pins = <
> > +				MX6QDL_PAD_SD3_CMD__SD3_CMD
> > 0x170B9
> 
> As per review comments, all hex values should be lowercase.

Yes, we probably missed that one.

> 1. https://github.com/ynezz/linux-2.6/blob/b27de46e67605fe1a8e386b065
> 845a9708e8e792/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> 2. https://github.com/ynezz/linux-2.6/blob/ec678e3734d9fff35f7ba96054
> 69a68a3e424020/arch/arm/boot/dts/imx6qdl-apalis-gaben-
> flexisbc.dtsi#L143
> 
> Thanks!

Thank you.

> -- ynezz


[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tegra30-apalis-eval.dts#n235

Cheers

Marcel
