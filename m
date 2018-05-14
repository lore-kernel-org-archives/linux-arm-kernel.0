From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 14 May 2018 11:26:00 +0200
Subject: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
In-Reply-To: <20180508115247.GF16141@n2100.armlinux.org.uk>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
 <20180508115247.GF16141@n2100.armlinux.org.uk>
Message-ID: <20180514092600.GA20663@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, May 08, 2018 at 12:52:47PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2018 at 03:56:32PM +0200, Antoine Tenart wrote:
> > SFP connectors can be solder on a board without having any of their pins
> > (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> > and the overall link status reporting is left to other layers.
> > 
> > In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> > This mode is set when it is not possible for the SFP code to get the
> > link status and as a result the link status is reported to be always UP
> > from the SFP point of view.
> 
> This looks weird to me.  SFP_DEV_* states track the netdevice up/down
> state and have little to do with whether LOS or MODDEF0 are implemented.

That's right.

> I think it would be better to have a new SFP_MOD_* and to force
> sm_mod_state to that in this circumstance.

The idea was to avoid depending on the state machine, as this could be
difficult to maintain in the future (it's hard to tell exactly what are
all the possible paths). But I get your point about SFP_DEV_.

I can have a look at adding a new SFP_MOD_, or I could add a broken flag
into 'struct sfp', although having a SFP_MOD_ would be proper.

Before doing so, we should decide whether or not this approach is valid,
as there were comments from Florian and Andrew asking for a fixed-link
solution. I think fixed-link wouldn't be perfect from the user point of
view, but I understand the point. If we go with fixed-link, then this
patch can be dropped (the two others net: sfp: patches could be kept).

What do you think?

Thanks,
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
