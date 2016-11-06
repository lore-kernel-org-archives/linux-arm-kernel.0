From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 6 Nov 2016 20:32:25 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161106162809.GA14042@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <20161105212326.GC1216@lunn.ch>
 <20161105212748.vtdprlxxismy5xmk@perseus.defre.kleine-koenig.org>
 <20161106104534.lsdyppz5qcnjcqe4@perseus.defre.kleine-koenig.org>
 <20161106111109.GD9617@lunn.ch>
 <20161106141716.fwgje74rhhixnixq@perseus.defre.kleine-koenig.org>
 <20161106162809.GA14042@lunn.ch>
Message-ID: <20161106193225.7tgnbitphktpdk6r@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I just noticed that I dropped the other recipents from the conversation.
I readded them also adding some context.

> > On Sun, Nov 06, 2016 at 05:28:09PM +0100, Andrew Lunn wrote:
> > > On Sun, Nov 06, 2016 at 11:45:34AM +0100, Uwe Kleine-K?nig wrote:
> > > > +     switch at 0 {
> > > > +             compatible = "marvell,mv88e6176", "marvell,mv88e6085";
> > > 
> > > All currently supported switches are compatible with the mv88e6085, in
> > > terms of probing. During the probe it can read an ID register to find
> > > out what specific switch it is, so you don't need additional details
> > > here. So please drop the marvell,mv88e6176, it will never be used.
> > 
> > That's what I know from several imx devices, for example look at
> > 
> > $ git grep imx25 arch/arm/boot/dts/imx25.dtsi
> > 
> > There are several instances of imx25-something,
> > imx$earliersoc-something. Given there is a good reason for this, I
> > wonder why it's different here.
> 
> Possibly because you cannot easily tell the variants apart using ID
> registers in the devices register space? For the switch it is very
> easy, port register 3 is the ID. It only becomes an issue when probe
> cannot find this register. There is a new generation mv88e6390 which
> i'm currently adding support for which has moved the port
> registers. So i need to add a new compatible string so probe knows
> where to look.

Even if you cannot easily distinguish between an "fsl,imx35-cspi" and an
"fsl,imx27-cspi" by inspecting hardware registers, it would be enough to
write in imx25.dtsi

	compatible = "fsl,imx35-cspi";

still we're writing

	compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";

because it never hurts and is helpful when later some differences are
found and it documents the situation more accurately.

I wonder what the dt people have to say here.

> > > From what you say here, the switch is in mulit-chip mode, at address
> > > 0x10. So set the reg property to <0x10>.
> > 
> > When using 0x10 I get
> > 
> > 	mv88e6085 f1072004.mdio-mi:10: switch 0x176 probed: Marvell 88E6176, revision 1
> 
> Great.
> 
> > 
> > so now I have to find out how to use this.
> 
> Just use them as normal interfaces. ip addr add 10.42.42.42/24 dev
> lan4, brctrl addif br0 lan2, ethtool -S lan1 etc.
> 
> The whole idea is that they are just normal Linux network interfaces.

That's how I expected things to be, but

	uwe at omnia:~$ dmesg | tail
	...
	[ 2164.644589] libphy: mdio_driver_register: mv88e6085
	[ 2164.649823] mv88e6085 f1072004.mdio-mi:10: switch 0x176 probed: Marvell 88E6176, revision 1
	uwe at omnia:~$ ls /sys/class/net/
	eth0  eth1  eth2  lo

there are no additional interfaces. I will debug a bit further.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161106/854a7843/attachment.sig>
