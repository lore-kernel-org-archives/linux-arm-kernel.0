From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Aug 2017 10:12:43 +0200
Subject: [PATCH v3 3/4] net: stmmac: register parent MDIO node for
 sun8i-h3-emac
In-Reply-To: <f14fe754-6339-32a0-3439-2daff6dd1d7e@gmail.com>
References: <CAGb2v67hQXSoCKP7qW+KRUYX+0djQ1Z23cQ67Lyg6G7ozGyfGQ@mail.gmail.com>
 <20170821132015.GB1703@lunn.ch>
 <20170821133104.qvrhvwin2rdg4aqo@flea.lan>
 <20170821142321.GE1703@lunn.ch>
 <CAGb2v64E4T=1ff3POGuXZA=MvjGAnKQ6OF6A3sT_cU-=jh6zNw@mail.gmail.com>
 <bfe784b6-5137-8fcd-dbd0-ad96974f4060@gmail.com>
 <20170822181140.GA11596@Red>
 <352ae66b-78a4-e88b-4544-a8edd9390b0c@gmail.com>
 <20170823074942.yt3c5gvnmdw5pqge@flea.home>
 <f14fe754-6339-32a0-3439-2daff6dd1d7e@gmail.com>
Message-ID: <20170824081243.ckihyjehv5derslx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 09:31:53AM -0700, Florian Fainelli wrote:
> On 08/23/2017 12:49 AM, Maxime Ripard wrote:
> > Hi Florian,
> > 
> > On Tue, Aug 22, 2017 at 11:35:01AM -0700, Florian Fainelli wrote:
> >>>>> So I think what you are saying is either impossible or engineering-wise
> >>>>> a very stupid design, like using an external MAC with a discrete PHY
> >>>>> connected to the internal MAC's MDIO bus, while using the internal MAC
> >>>>> with the internal PHY.
> >>>>>
> >>>>> Now can we please decide on something? We're a week and a half from
> >>>>> the 4.13 release. If mdio-mux is wrong, then we could have two mdio
> >>>>> nodes (internal-mdio & external-mdio).
> >>>>
> >>>> I really don't see a need for a mdio-mux in the first place, just have
> >>>> one MDIO controller (current state) sub-node which describes the
> >>>> built-in STMMAC MDIO controller and declare the internal PHY as a child
> >>>> node (along with 'phy-is-integrated'). If a different configuration is
> >>>> used, then just put the external PHY as a child node there.
> >>>>
> >>>> If fixed-link is required, the mdio node becomes unused anyway.
> >>>>
> >>>> Works for everyone?
> >>>
> >>> If we put an external PHY with reg=1 as a child of internal MDIO,
> >>> il will be merged with internal PHY node and get
> >>> phy-is-integrated.
> >>
> >> Then have the .dtsi file contain just the mdio node, but no internal or
> >> external PHY and push all the internal and external PHY node definition
> >> (in its entirety) to the per-board DTS file, does not that work?
> > 
> > If possible, I'd really like to have the internal PHY in the
> > DTSI. It's always there in hardware anyway, and duplicating the PHY,
> > with its clock, reset line, and whatever info we might need in the
> > future in each and every board DTS that uses it will be very error
> > prone and we will have the usual bunch of issues that come up with
> > duplication.
> 
> OK, then what if you put the internal PHY in the DTSI, mark it with a
> status = "disabled" property, and have the per-board DTS put a status =
> "okay" property along with a "phy-is-integrated" boolean property? Would
> that work?

Yeah, that would work for me.

> What I really don't think is necessary is:
> 
> - duplicating the "mdio" controller node for external vs. internal PHY,
> because this is not accurate, there is just one MDIO controller, but
> there may be different kinds of MDIO/PHY devices attached

Agreed.

> - having the STMMAC driver MDIO probing code having to deal with a
> "mdio" sub-node or an "internal-mdio" sub-node because this is confusing
> and requiring more driver-level changes that are error prone

I don't really have an opinion on that one, so I'll defer to your
judgment of what's best :)

I guess we have an agreement. Andrew, is that ok for you too?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/e36bb6ca/attachment.sig>
