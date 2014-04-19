From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 19 Apr 2014 09:46:33 +0200
Subject: [PATCH 26/29] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <534BC5DA.7030106@gmail.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-27-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BC5DA.7030106@gmail.com>
Message-ID: <20140419094633.2fa0b190@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon, 14 Apr 2014 13:26:18 +0200, Sebastian Hesselbarth wrote:

> > +	chosen {
> > +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> 
> + [linux,]stdout-path = &uart0;

Done. Should it be linux,stdout-path, or stdout-path? As of 3.15-rc1,
it seems that only linux,stdout-path is being used.

> > +		devbus-bootcs {
> 
> Use node label references where applicable.

Ok. Which node labels do you suggest for the devbus-* nodes?

> > +				pmx_misc_gpios: pmx-misc-gpios {
> 
> Sort alphabetically by node label.

Will do, thanks.


> > +	gpio_leds {
> 
> s/gpio_leds/gpio-leds/

Will do.

> 
> > +		compatible = "gpio-leds";
> > +		pinctrl-0 = <&pmx_debug_led>;
> > +		pinctrl-names = "default";
> > +
> > +		led at 0 {
> > +			label = "rd88f5182:cpu";
> > +			linux,default-trigger = "heartbeat";
> > +			gpios = <&gpio0 0 0>;
> 
> Use gpio.h dt-include?

Sure, I missed that one.


> > +&mdio {
> > +	status = "okay";
> > +
> > +	ethphy: ethernet-phy {
> > +		reg = <8>;
> 
> Can you evaluate if it is GMII or RGMII[-id] and add a
> phy-connection-type property now? This is something that
> bothers me already on kirkwood.

I'll try to do this for this board for which I believe I have the
schematics, but for edmini_v2 or d2net, I don't have the schematics.
I'll see if I can infer the information from some U-Boot output, or by
dumping some register.


> > + * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
> 
> Maybe add Ronen to the Signed-off tag, too? Or at least put him
> on Cc?

Signed-off-by looks a bit strong, because Ronen has never seen this
patch nor been involved in writing it. I'll Cc him.


> > +	pin = RD88F5182_PCI_SLOT0_IRQ_A_PIN;
> > +	if (gpio_request(pin, "PCI IntA") == 0) {
> > +		if (gpio_direction_input(pin) == 0) {
> > +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
> > +		} else {
> > +			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
> 
> I am not sure, what is the correct way of using it, but maybe it is
> pr_err()? I'd also be interested in the latest policy of using it.

Indeed pr_err() is the right thing to use now. However here I'm just
replicating existing code, so I'd prefer to keep it as is in this
commit, if possible. I'm anyway planning on removing this PCI platform
code soon, but this is going to be for after this series is merged.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
