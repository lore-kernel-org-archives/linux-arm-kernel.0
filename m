From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 18 Apr 2012 11:38:02 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120417123006.GC3852@pengutronix.de>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <20120414134814.GA3852@pengutronix.de>
 <CAA+hA=T0FAfuGKcW0vAKO+OWyFdM-6vQqVo53xKf8y28m7gPOQ@mail.gmail.com>
 <20120415141736.GG24997@S2101-09.ap.freescale.net>
 <20120416034713.GB17173@shlinux2.ap.freescale.net>
 <20120416034646.GI24997@S2101-09.ap.freescale.net>
 <20120417095722.GF17173@shlinux2.ap.freescale.net>
 <20120417123006.GC3852@pengutronix.de>
Message-ID: <20120418033801.GA18021@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 08:30:06PM +0800, Sascha Hauer wrote:
> On Tue, Apr 17, 2012 at 05:57:23PM +0800, Dong Aisheng wrote:
> > Sascha & Shawn,
> > 
> > Just let you know:
> > After changes the pinctrl table may look like:
> > (i also removed fsl,* config properties since it was introduced for better
> > readability before, but after dtc macro support is available, it could also
> > be removed. So i removed now. Then the using is much similar as iomux-v3).
> > 
> > iomuxc at 020e0000 {
> >         compatible = "fsl,imx6q-iomuxc";
> >         reg = <0x020e0000 0x4000>;
> > 
> >         /* shared pinctrl settings */
> >         uart4 {
> >                 pinctrl_uart4_1: uart4grp-1 {
> >                         fsl,pins = <58 61>;
> >                         fsl,configs = <0x12407>
> 
> Why do we have a hex value for the config now? This should be
> independent on how we describe the mux settings.
> 
Yes, that's independent on mux.
Originally for config, it is like:
fsl,pull = <2>;
fsl,pue = <1>;
fsl,pke = <1>;
fsl,speed = <2>;
fsl,drive-strength = <6>;
fsl,slew-rate = <1>;
fsl,hysteresis = <1>;

But i think, as mux, after dtc supports macro, we do not need them any more.
A macro seems enough to tell people what the config data means.
Like:
/define/ MX6Q_UART_PAD_CTRL 0x12407

Since i have already changed mux to raw data, i also want to change config to
raw data at the same time and this is also easy to use.

> Also I think a single fsl,configs entry for a pin group is not
> enough, what for example with I2C where the data line needs a pullup
> whereas the clock line does not?
> 
For this case, the hex value for fsl,configs has not difference as the original one.

The original purpose is put the same config pins in one group and the config value
functions on all the pins in that group.
But if we have a pin needs different config, we need separate it in another group.
For example,
i2c1 {
	pinctrl_i2c_scl: i2c1clk-1 {
		fsl,pins = <...>;
		fsl,configs = <PULLUP..>;
	};
	pinctrl_i2c_sda: i2c1sda-1 {
		fsl,pins = <...>;
		fsl,configs = <NO_PULLUP...>;
	};
};

I have ever also considered another approach for imx which can avoid this issue
by dropping the fsl,configs property which is like:
i2c1 {
	pinctrl_i2c1: i2c1 {
		fsl,pins = <MX6Q_PAD_EIM_D21__I2C1_SCL PULLUP..
			    MX6Q_PAD_EIM_D28__I2C1_SDA PULLDOWN..>
	};
};
Each pin can have its specific pad config setting.
Without macro support, it is like:
i2c1 {
	pinctrl_i2c1: i2c1 {
		/* the value is write randomly, just for showing example */
		fsl,pins = <1001 0x13502 /* with pull up */
			    1056 0x3502>; /* no pull up */
	};
};
The benefit is that it can get better flexibility and the drawback is that
for pins have no config, we still need write a dummy value
to tell the core this pin have no config.
For iomux v3, it's
#define NO_PAD_CTRL                     (1 << 16)
It works for mx5, but for mx6, it needs to be :
#define NO_PAD_CTRL                     (1 << 17) /* bigger than 16 */
(It seems it's not good enough since in the future it may need change again)

Then dts file will look like:
pinctrl_i2c1: i2c1 {
	fsl,pins = <1001 0x20000	/* no config */
		    1056 0x20000>;	/* no config */
};
pinctrl_xxx: xxx1 {
	fsl,pins = <1001 0x20000	/* no config */
		    1056 0x20000	/* no config */
		    1066 0x20000	/* no config */
		    1076 0x20000	/* no config */
		    1086 0x20000	/* no config */
		    1096 0x20000	/* no config */
		    1006 0x20000	/* no config */
		    1016 0x20000	/* no config */
		    1026 0x20000	/* no config */
};
First the 0x20000 cause confusing, second the 0x20000 data is a little redundancy
and many pins may have the same config.

One way may add a property to tell core whether pins have config, but that seems
does not work since it's possible some pins have config while others not.

This is unlike the current way, we can do not define fsl,configs property to tell
driver no config need for these pins.
And based on the assumption that most pins have the same pin config setting.
I chosed the original approach.
The is also the same way as Tegra does.

What do you think of those two approaches? What's your suggestion?

Regards
Dong Aisheng
