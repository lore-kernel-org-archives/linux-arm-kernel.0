From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 17:56:58 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <20140413154715.GE10033@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413154715.GE10033@lunn.ch>
Message-ID: <20140413175658.64b65a76@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 13 Apr 2014 17:47:15 +0200, Andrew Lunn wrote:

> > +				rtc at 68 {
> > +					pinctrl-0 = <&pmx_rtc>;
> > +					pinctrl-names = "default";
> > +					compatible = "ds1338";
> 
> Hi Thomas
> 
> Vendor prefix again.

Will do.

> > +					reg = <0x68>;
> > +				};
> > +			};
> > +
> > +			serial at 12000 {
> > +				clock-frequency = <166666667>;
> 
> I don't think you need this, so long as there is tclk in the node.

Ah, right, the 8250 driver is now capable of getting the clock rate
using a proper clock. Will fix that.

> > +	gpio_leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-0 = <&pmx_debug_led>;
> > +		pinctrl-names = "default";
> > +
> > +		led at 0 {
> > +			label = "rd88f5182:cpu";
> > +			linux,default-trigger = "heartbeat";
> 
> Jason probably won't like that.

I'm just doing a 1:1 functional conversion here.

> 
> > +			gpios = <&gpio0 0 0>;
> 
> gpio.h defines?

Indeed. Missed that one it seems, as I used them pretty much everywhere
else.

> > +static int __init rd88f5182_pci_init(void)
> > +{
> > +	if (of_machine_is_compatible("marvell,rd-88f5182-nas"))
> > +		pci_common_init(&rd88f5182_pci);
> > +
> > +	return 0;
> > +}
> > +
> > +subsys_initcall(rd88f5182_pci_init);
> 
> Nice to see you are checking for compatibility in the initcall. How
> far do you think this from a multi_v5 kernel?

I haven't thought too much about this yet. I'm hoping to do more
Orion5x DT conversion once this patch series is done, and then think
about multiplatform support.

To be honest, I find it pretty useless to have half of the Kirkwood
and Dove support in mach-mvebu, and half still in
mach-kirkwood/mach-dove, because it doesn't allow to remove any of the
legacy code in mach-kirkwood and mach-dove. But oh, well, I guess it's
only a temporary situation, until more boards are converted, or their
support simply removed.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
