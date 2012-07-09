From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 16:40:34 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207091018.25979.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341821163-17885-1-git-send-email-shawn.guo@linaro.org>
 <201207091018.25979.marex@denx.de>
Message-ID: <20120709084032.GF11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 10:18:25AM +0200, Marek Vasut wrote:
> > +				pwm3_pins_a: pwm3 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <
> > +						0x31c0 /* MX28_PAD_PWM3__PWM_3 
> */
> > +					>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};
> 
> Drop the pwm3 stuff, it's not used.
> 
Okay.  I saw the following in mach-m28evk.c, and thought it's being
used by backlight.  But you knows it better than me.

static const iomux_cfg_t m28evk_pads[] __initconst = {
	...
        /* Backlight */
        MX28_PAD_PWM3__GPIO_3_28 | MXS_PAD_CTRL,
};

> > +			pinctrl at 80018000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&hog_pins_a>;
> > +
> > +				hog_pins_a: hog-gpios at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <
> > +						0x30a3 /* 
> MX28_PAD_AUART2_CTS__GPIO_3_10 */
> > +						0x30b3 /* 
> MX28_PAD_AUART2_RTS__GPIO_3_11 */

These two were copied from your initial m28evk DTS file, which says
GPIO_3_10 is used as wp-gpios of mmc0 and GPIO_3_11 is used as
phy-reset-gpios of fec.

> > +						0x3103 /* 
> MX28_PAD_PWM0__GPIO_3_16 */
> > +						0x3113 /* 
> MX28_PAD_PWM1__GPIO_3_17 */
> 
>From what mach-m28evk.c tells, they are used as m28evk_leds.

> What's this part for ?
> 
See above.

> > +					>;
> > +					fsl,drive-strength = <0>;
> > +					fsl,voltage = <1>;
> > +					fsl,pull-up = <0>;
> > +				};

<snip>

> > +	leds {
> 
> Drop the led section, it's some ancient nonsense from who-knows-where :-(
> 
Okay.  Now I know why you have above comment.

> > +		compatible = "gpio-leds";
> > +
> > +		user1 {
> > +			label = "Heartbeat1";
> > +			gpios = <&gpio3 16 0>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +
> > +		user2 {
> > +			label = "Heartbeat2";
> > +			gpios = <&gpio3 17 0>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> > +
> > +	backlight {
> 
> Drop this backlight too please.
> 
Okay.

> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm 3 5000000>;
> > +		brightness-levels = <0 4 8 16 32 64 128 255>;
> > +		default-brightness-level = <6>;
> > +	};
> > +};

<snip>

> > +static void __init m28evk_init(void)
> > +{
> > +	update_fec_mac_prop(OUI_DENX);
> > +
> > +	mxsfb_pdata.mode_list = m28evk_video_modes;
> > +	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
> > +	mxsfb_pdata.default_bpp = 16;
> > +	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
> > +}
> > +
> >  static void __init mxs_machine_init(void)
> >  {
> >  	if (of_machine_is_compatible("fsl,imx28-evk"))
> >  		imx28_evk_init();
> >  	else if (of_machine_is_compatible("fsl,imx23-evk"))
> >  		imx23_evk_init();
> > +	else if (of_machine_is_compatible("denx,m28evk"))
> > +		m28evk_init();
> 
> I think you need to call imx28_evk_init() here ?
> 
Eh, why?

> > 
> >  	of_platform_populate(NULL, of_default_bus_match_table,
> >  			     mxs_auxdata_lookup, NULL);
> > @@ -223,6 +252,7 @@ static const char *imx23_dt_compat[] __initdata = {
> > 
> >  static const char *imx28_dt_compat[] __initdata = {
> >  	"crystalfontz,cfa10036",
> > +	"denx,m28evk",
> >  	"fsl,imx28-evk",
> >  	"fsl,imx28",
> >  	NULL,

-- 
Regards,
Shawn
