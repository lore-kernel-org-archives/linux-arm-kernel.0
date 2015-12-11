From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 Dec 2015 09:46:30 +0100
Subject: [PATCH] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <871tau8hpj.fsf@free-electrons.com>
References: <1449683383-5022-1-git-send-email-gregory.clement@free-electrons.com>
 <20151210073756.GA11966@pengutronix.de>
 <871tau8hpj.fsf@free-electrons.com>
Message-ID: <20151211084630.GW11966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 04:08:08PM +0100, Gregory CLEMENT wrote:
> Hi Sascha,
>  
>  On jeu., d?c. 10 2015, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > Hi Gregory,
> >
> > On Wed, Dec 09, 2015 at 06:49:43PM +0100, Gregory CLEMENT wrote:
> >> With device tree it is no more possible to reset the PHY at board
> >> level. Furthermore, doing in the driver allow to power down the PHY when
> >> the network interface is no more used.
> >> 
> >> The patch introduces a new optional property "phy-reset-gpio" inspired
> >> from the one use for the FEC.
> >
> > I don't think it's a good idea to further extend the usage of this
> > binding. The driver should use the phy-handle property and
> > of_phy_connect() which gives you a proper device node for the phy. Then
> > the phy device node should get the reset gpio. I know it's more work,
> 
> So you suggest to pass from this binding:
> macb1: ethernet at fc028000 {
> 	phy-mode = "rmii";
> 	status = "okay";
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	status = "okay";
> 	phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;
> 
> 	ethernet-phy at 1 {
> 		reg = <0x1>;
> 		interrupt-parent = <&pioB>;
> 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> 
> 	};
> };
> 
> to this binding
> macb1: ethernet at fc028000 {
> 	phy-mode = "rmii";
> 	status = "okay";
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	status = "okay";
> 
> 	ethernet-phy at 1 {
> 		reg = <0x1>;
> 		interrupt-parent = <&pioB>;
> 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
>                 phy-reset-gpio = <&pioE 6 GPIO_ACTIVE_HIGH>;
> 	};
> };

s/phy-reset-gpio/reset-gpios/, but yes.

I had assumed you do not use a phy description in the device tree at all
since the macb driver doesn't use of_phy_connect(). Apparently there are
other possibilities to connect the phy device nodes with the phys

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
