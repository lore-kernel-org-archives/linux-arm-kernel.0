From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Apr 2018 15:32:19 +0200
Subject: [Question] MFD driver that handles clocks/resets and populates
 child nodes
In-Reply-To: <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
 <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
Message-ID: <20180402133219.GA10520@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
> 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
> >> The maintainer of DWC3, Felipe Balbi, requested to
> >> split the glue layer driver into small parts such as
> >> reset, regulator, phy, etc.
> >
> > What exactly did Felipe ask for? Did he ask that the patch be split
> > up, one patch per reset, regulator, phy etc?
> 
> 
> Yeah.  That is what we understood from his comments.
> 
> 
> These are the feed-backs from him.
> 
> https://lkml.org/lkml/2018/1/23/298
> https://lkml.org/lkml/2018/1/24/352

> > Are all these resources used just by the DWC3? Or is it a true MFD,
> > multiple functions?
> 
> I do not think this is a real MFD.
> 
> This is a DWC3 glue layer, i.e.
> a collection of misc registers that control
> the DWC3 IP.
> 
> 
> Just splitting it into small pieces
> to use PHY, reset, regulator framework in Linux.
> 
> Of course, the price of this approach
> is so cluttered Device Tree,
> honestly I do not like it much.

This however the correct way to do this. You should have a phy driver,
and a regulator driver, and a reset driver. The DWC3 then uses
phandles to these drivers.

How is the IO map area 65b00000 split up. Can you cleanly separate it
into sub areas, which do not overlap, so you have a sub-area for the
PHY driver, a sub-area for the regulator driver and a sub-area for the
reset area? If you can cleanly split it up, you don't need an MFD. If
however the registers are in overlapping areas, you do need an
MFD. The MFD core provides access to the registers, while its children
implement PHY, reset, regulator etc.

	  Andrew
