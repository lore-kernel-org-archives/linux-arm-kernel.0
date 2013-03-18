From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Mar 2013 19:44:53 -0400
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <87mwu0pamh.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwu0pamh.fsf@natisbad.org>
Message-ID: <20130318234453.GN13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

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

			    gpio = <&gpio1 14 0>;

GPIO_HIGH_VIRT_BASE is the second bank of gpios.

hth,

Jason.
