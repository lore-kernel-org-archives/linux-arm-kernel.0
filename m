From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Apr 2016 18:01:22 +0200
Subject: [PATCH v4 4/5] dt-bindings: arm: add DT binding for Marvell
 CP110 system controller
In-Reply-To: <20160328194756.GA28967@rob-hp-laptop>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459070777-18049-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160328194756.GA28967@rob-hp-laptop>
Message-ID: <20160413180122.4f997a9a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 28 Mar 2016 14:47:56 -0500, Rob Herring wrote:

> > + - reg: register area of the CP110 system controller 0
> > + - #clock-cells: must be set to 2
> > + - core-clock-output-names must be set to:
> > +    "cpm-apll", "cpm-ppv2-core", "cpm-eip", "cpm-core", "cpm-nand-core"
> > + - gatable-clock-indices must be set to:
> > +	<0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>,
> > +	<9>, <11>, <12>, <13>, <14>, <15>, <16>, <18>,
> > +	<22>, <23>, <24>, <25>, <26>
> 
> You aren't skipping very many spots. I'd just fill the unused names in 
> with "none" or something.
> 
> > + - gatable-clock-output-names must be set to:
> > +	"cpm-audio", "cpm-communit", "cpm-nand", "cpm-ppv2", "cpm-sdio",
> > +	"cpm-mg-domain", "cpm-mg-core", "cpm-xor1", "cpm-xor0", "cpm-gop-dp", "cpm-pcie_x10",
> > +	"cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor", "cpm-sata", "cpm-sata-usb",
> > +	"cpm-gop-macro", "cpm-usb3h0", "cpm-usb3h1", "cpm-usb3dev", "cpm-eip150",
> > +	"cpm-eip197"

In fact, the more I think of it, the less I find encoding the clock
output names in the DT to be useful for such a driver. For generic
clock drivers, it makes complete sense, but here the driver is really
tied to the specific system controller of that SoC, so the clock names
will not change.

In addition, those gatable clocks are not independent from each other:
many of them are parent from others (this wasn't encoded into the
driver until now, because I didn't had this info until now). So the
driver will anyway have to have a lot of knowledge about which clock is
child/parent of which one. Which means the driver is anyway really
tied to that specific system controller.

Does it still make sense to encode the clock names in the DT in such a
case, or should the driver be providing the clock names?

(I don't have a strong opinion either way, I'm just asking what is the
preference of the DT and clock maintainers on the matter.).

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
