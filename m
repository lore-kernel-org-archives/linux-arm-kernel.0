From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Mar 2013 07:07:50 +0100
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <87mwu0pamh.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwu0pamh.fsf@natisbad.org>
Message-ID: <20130319060750.GD21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 12:10:46AM +0100, Arnaud Ebalard wrote:
> Hi guys,
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> >> +void __init netgear_readynas_init(void)
> >> +{
> >> +	u32 val;
> >> +
> >> +	kirkwood_ge00_init(&netgear_readynas_ge00_data);
> >> +	kirkwood_pcie_init(KW_PCIE0);
> >> +
> >> +	/* USB 3.0 controller power on */
> >> +	mdelay(3000);
> >> +	val = readl(GPIO_HIGH_VIRT_BASE + 0x4);
> >> +	writel(val & ~(0x1 << 14), GPIO_HIGH_VIRT_BASE + 0x4);
> >> +	val = readl(GPIO_HIGH_VIRT_BASE);
> >> +	writel(val | (0x1 << 14), GPIO_HIGH_VIRT_BASE);
> >
> > As Jason said, you can use a fixed regulator, in DT. Something like:
> >
> >         regulators {
> >                 compatible = "simple-bus";
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> >                 usb_power: regulator at 1 {
> >                         compatible = "regulator-fixed";
> >                         reg = <1>;
> >                         regulator-name = "USB Power";
> >                         regulator-min-microvolt = <5000000>;
> >                         regulator-max-microvolt = <5000000>;
> >                         enable-active-high;
> >                         regulator-always-on;
> >                         regulator-boot-on;
> >                         gpio = <&gpio0 14 0>;
> >                 };
> >         };
> 
> I spent a lot of time on this, trying various things and reading various
> elements of Docomentation/ but for some reason, it does not work, i.e. I
> always end up w/ something lik: 
> 
> [    7.599773] USB Power: Failed to request enable GPIO14: -517
> [    7.605963] reg-fixed-voltage 1.regulator: Failed to register regulator: -517
> [    7.613163] platform 1.regulator: Driver reg-fixed-voltage requests probe deferral

Although this is quite noisy, it is actually not an error. What it is
saying is that it failed to get the gpio and it will try again
later. -517 is EDEFERE. It failed, because at this point, the GPIO
driver has not yet loaded. Later in the boot the gpio driver
loaded. It around the time you see:

kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver

At some point, the kernel will retry again to load all drivers which
failed with EDEFER and the second time the regulator driver should
load.

Take a look in /sys/class/regulator/ See if there is a regulator
there with the name file containing "USB power".

      Andrew
