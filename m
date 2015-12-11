From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Dec 2015 10:40:22 +0100
Subject: [PATCH] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <20151211084630.GW11966@pengutronix.de> (Sascha Hauer's message
 of "Fri, 11 Dec 2015 09:46:30 +0100")
References: <1449683383-5022-1-git-send-email-gregory.clement@free-electrons.com>
 <20151210073756.GA11966@pengutronix.de>
 <871tau8hpj.fsf@free-electrons.com>
 <20151211084630.GW11966@pengutronix.de>
Message-ID: <87wpsl727t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
 
 On ven., d?c. 11 2015, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Thu, Dec 10, 2015 at 04:08:08PM +0100, Gregory CLEMENT wrote:
>> Hi Sascha,
>>  
>>  On jeu., d?c. 10 2015, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> 
>> > Hi Gregory,
>> >
>> > On Wed, Dec 09, 2015 at 06:49:43PM +0100, Gregory CLEMENT wrote:
>> >> With device tree it is no more possible to reset the PHY at board
>> >> level. Furthermore, doing in the driver allow to power down the PHY when
>> >> the network interface is no more used.
>> >> 
>> >> The patch introduces a new optional property "phy-reset-gpio" inspired
>> >> from the one use for the FEC.
>> >
>> > I don't think it's a good idea to further extend the usage of this
>> > binding. The driver should use the phy-handle property and
>> > of_phy_connect() which gives you a proper device node for the phy. Then
>> > the phy device node should get the reset gpio. I know it's more work,
>> 
>> So you suggest to pass from this binding:
>> macb1: ethernet at fc028000 {
>> 	phy-mode = "rmii";
>> 	status = "okay";
>> 	#address-cells = <1>;
>> 	#size-cells = <0>;
>> 	status = "okay";
>> 	phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;
>> 
>> 	ethernet-phy at 1 {
>> 		reg = <0x1>;
>> 		interrupt-parent = <&pioB>;
>> 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>> 
>> 	};
>> };
>> 
>> to this binding
>> macb1: ethernet at fc028000 {
>> 	phy-mode = "rmii";
>> 	status = "okay";
>> 	#address-cells = <1>;
>> 	#size-cells = <0>;
>> 	status = "okay";
>> 
>> 	ethernet-phy at 1 {
>> 		reg = <0x1>;
>> 		interrupt-parent = <&pioB>;
>> 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>>                 phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;
>> 	};
>> };
>
> s/phy-reset-gpio/reset-gpios/, but yes.

So I took this way. But I had several issues. The first one was that to
be able to create a phy device it must first be detected by
get_phy_device from of_mdiobus_register_phy.  But in order to be
detected it must answer during the scan of the mii bus. That means we
can't bind the gpio to the device in order to use it because when we
need to manage the reset gpio the device is not yet created.

So I see 2 options:

- leaving the phy-reset-gpios property in the ethernet node. Thanks to
  this we can use the gpiod functions, and it is still possible to use
  manage the power management.

- using a reset-gpios property inside the phy node. But then the only
  solution to get a reference on it, will be to use
  of_get_named_gpio. All the gpiod functions need a reference to the
  device that we won't have at this point. Also we will only be able to
  power up the reset, but we won't have any reference to it latter.

Thanks,

Gregory

>
> I had assumed you do not use a phy description in the device tree at all
> since the macb driver doesn't use of_phy_connect(). Apparently there are
> other possibilities to connect the phy device nodes with the phys
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
