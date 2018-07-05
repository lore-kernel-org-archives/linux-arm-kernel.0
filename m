From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 6 Jul 2018 00:37:30 +0200
Subject: [PATCH 3/3] ARM: dts: Add devicetree for Storlink/Storm SL93512R
In-Reply-To: <CACRpkdbgoVjCaTE3xg1Q_-UKG3cdVdDdNFW4j1UOA9bX0o-wpQ@mail.gmail.com>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-3-linus.walleij@linaro.org>
 <20180704205627.GF23469@lunn.ch>
 <CACRpkdbgoVjCaTE3xg1Q_-UKG3cdVdDdNFW4j1UOA9bX0o-wpQ@mail.gmail.com>
Message-ID: <20180705223730.GQ23469@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +                             vsc: port at 6 {
> > > +                                     reg = <6>;
> > > +                                     label = "cpu";
> > > +                                     ethernet = <&gmac1>;
> > > +                                     phy-mode = "rgmii";
> > > +                                     fixed-link {
> > > +                                             speed = <1000>;
> > > +                                             full-duplex;
> > > +                                             pause;
> > > +                                     };
> 
> So this DSA side is fine like so.

Hi Linus

Yes, this is how i normally do it, if the defaults don't work. Most
DSA drivers will configure the CPU port to its maximum speed. But if
you need to slow it down, you can use a fixed-link. e.g. i have boards
with a 1Gbps switch connected to a SoC with 100Mbps Ethernet. So i
need a fixed link with speed=<100>.

> (...)
> 
> > > +             ethernet at 60000000 {
> > > +                     status = "okay";
> > > +
> > > +                     ethernet-port at 0 {
> > > +                             phy-mode = "rgmii";
> > > +                             phy-handle = <&phy0>;
> > > +                     };
> > > +                     ethernet-port at 1 {
> > > +                             phy-mode = "rgmii";
> > > +                             phy-handle = <&vsc>;
> >
> > This looks odd. The switch port is not a PHY. Normally you use a
> > fixed-phy.
> 
> I tried some stuff but can't figure this out any other way that also
> works :(
> 
> I guess you mean a fixed-link as the kernel has no references
> to fixed-phy.

Sorry, yes, i meant fixed link.
 
> This works:
> 
>             ethernet-port at 1 {
>                 phy-mode = "rgmii";
>                 phy-handle = <&vsc>;
>                 fixed-link {
>                     speed = <1000>;
>                     full-duplex;
>                     pause;
>                 };
>             };
>
> Is it better? It is still using phy-handle... I couldn't find a way to live
> without that. But maybe this was all you expected? phy-mode
> and phy-handle still OK despite being named phy-something?
> 
> Or do you have some example of how it should look?

arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts 

&eth0 {
        phy-mode = "rgmii-id";
        status = "okay";

        fixed-link {
                speed = <1000>;
                full-duplex;
        };
};

phy-mode is O.K, since you need to set RGMII.

phy-handle should not be used, since the fixed-link takes its
place. But it could be your MAC driver has problems, does not
correctly support fixed link, and has phy-handle as being mandatory,
when it should not be.

Which MAC driver is this?

     Andrew
