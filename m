From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Dec 2015 16:08:08 +0100
Subject: [PATCH] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <20151210073756.GA11966@pengutronix.de> (Sascha Hauer's message
 of "Thu, 10 Dec 2015 08:37:56 +0100")
References: <1449683383-5022-1-git-send-email-gregory.clement@free-electrons.com>
 <20151210073756.GA11966@pengutronix.de>
Message-ID: <871tau8hpj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
 
 On jeu., d?c. 10 2015, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Hi Gregory,
>
> On Wed, Dec 09, 2015 at 06:49:43PM +0100, Gregory CLEMENT wrote:
>> With device tree it is no more possible to reset the PHY at board
>> level. Furthermore, doing in the driver allow to power down the PHY when
>> the network interface is no more used.
>> 
>> The patch introduces a new optional property "phy-reset-gpio" inspired
>> from the one use for the FEC.
>
> I don't think it's a good idea to further extend the usage of this
> binding. The driver should use the phy-handle property and
> of_phy_connect() which gives you a proper device node for the phy. Then
> the phy device node should get the reset gpio. I know it's more work,

So you suggest to pass from this binding:
macb1: ethernet at fc028000 {
	phy-mode = "rmii";
	status = "okay";
	#address-cells = <1>;
	#size-cells = <0>;
	status = "okay";
	phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;

	ethernet-phy at 1 {
		reg = <0x1>;
		interrupt-parent = <&pioB>;
		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;

	};
};

to this binding
macb1: ethernet at fc028000 {
	phy-mode = "rmii";
	status = "okay";
	#address-cells = <1>;
	#size-cells = <0>;
	status = "okay";

	ethernet-phy at 1 {
		reg = <0x1>;
		interrupt-parent = <&pioB>;
		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
                phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;
	};
};

> but doing it like this gives you additional goodies like proper handling
> of the max-speed property, a fixed-link if necessary and picking the

Currently there is phy_connect_direct so we can already handle the
preperty of the phy.

> correct phy if there are muliple phys on the bus.

but I agree with this one.

Gregory

>
> Sascha
>
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
