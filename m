From: jacopo@jmondi.org (jmondi)
Date: Wed, 30 Aug 2017 09:35:28 +0200
Subject: [PATCH 3/4] arm: dts: gr-peach: Add ETHER pin group
In-Reply-To: <20170830072542.GH10398@verge.net.au>
References: <1503564523-31899-1-git-send-email-jacopo+renesas@jmondi.org>
 <1503564523-31899-4-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUoMU=qN3Qjoqmf6uxcS3j5hqthhuBDMPZzA+wSD_BH5A@mail.gmail.com>
 <20170824114656.GA3905@w540>
 <CAMuHMdU5Vep+m7XtjcbSvyXUzD_Pn2crcQ68VRmS4bgY44ut0w@mail.gmail.com>
 <20170824125359.GB3905@w540> <20170830072542.GH10398@verge.net.au>
Message-ID: <20170830073528.GB5584@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Aug 30, 2017 at 09:25:42AM +0200, Simon Horman wrote:
> On Thu, Aug 24, 2017 at 02:53:59PM +0200, jmondi wrote:
> > Thanks Geert,
> >
> > On Thu, Aug 24, 2017 at 01:56:16PM +0200, Geert Uytterhoeven wrote:
> > > Hi Jacopo,
> > >
> >
> > [snip]
> >
> > > > I haven't find any mention in device tree bindings documentation of a
> > > > "reset-gpio" property for sh_eth, in the code examples I've seen in
> > > > u-boot and mbed, the interface is reset before any actual
> > > > configuration is performed. I feel like that should be the place where
> > > > that gpio is requested and cycled...
> > >
> > > Documentation/devicetree/bindings/net/mdio.txt says
> > >
> > > These are generic properties that can apply to any MDIO bus.
> > >
> >
> > I have now used mdio defined generic properties
> >
> > &ether {
> > 	pinctrl-names = "default";
> > 	pinctrl-0 = <&ether_pins>;
> >
> > 	status = "okay";
> >
> > 	reset-gpios = <&port4 2 GPIO_ACTIVE_LOW>;
> > 	reset-delay-us = <5>;
> >
> > 	renesas,no-ether-link;
> > 	phy-handle = <&phy0>;
> > 	phy0: ethernet-phy at 0 {
> >                reg = <0>;
> > 	};
> > };
> >
> > I see the gpio being cycled, but same results as before: device gets
> > probed, address set, but I cannot ping, device gets probed, address
> > gets set, but I cannot ping
> >
> > --- target ---
> > [    0.000000] libphy: sh_mii: probed
> > [    0.000000] sh-eth e8203000.ethernet eth0: Base address at 0xe8203000, 68:14:97:20:97:00, IRQ 22.
> >
> > # ifconfig eth0 192.168.100.50
> > [    0.000000] Generic PHY e8203000.ethernet-ffffffff:00: attached PHY driver [Generic PHY] (mii_bus:phy_addr=e8203000.ethernet-f)
> >
> > --- host ---
> > $ping 192.168.100.50
> > PING 192.168.100.50 (192.168.100.50) 56(84) bytes of data.
> > >From 192.168.100.18 icmp_seq=1 Destination Host Unreachable
> > >From 192.168.100.18 icmp_seq=1 Destination Host Unreachable
> > >From 192.168.100.18 icmp_seq=1 Destination Host Unreachable
> >
> >
> > Let's leave this out of the DTS series I've just sent for now, ok?
>
> I'm a little confused by this. Am I right in thinking that you don't want
> this patch applied at this time and may resubmit it or an updated version
> later? With that understanding I have marked it as "Rejected" for now. Feel
> free to resubmit when you are ready.

Yes please, you got me right here.

Even if pix muxing is performed "correctly", and I can set ip address
and probe the interface, not traffic can be exchanged on it.

For this reason, let's not enable it at this time

Is this fine?
