From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 15:39:57 +0200
Subject: [PATCHv3 3/4] of: provide a binding for fixed link PHYs
In-Reply-To: <20140308055033.BE0F2C405B0@trevor.secretlab.ca>
References: <1393930704-24374-1-git-send-email-thomas.petazzoni@
 free-electrons.com>
 <1393930704-24374-4-git-send-email-thomas.petazzoni@ free-electrons.com>
 <20140308055033.BE0F2C405B0@trevor.secretlab.ca>
Message-ID: <20140515153957.75a8aa2a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

Sorry for bringing back this old topic, but I'm working on this again,
hopefully reaching an acceptable solution this time. One question for
you below.

On Sat, 08 Mar 2014 05:50:33 +0000, Grant Likely wrote:

> > +Example:
> > +
> > +ethernet at 0 {
> > +	...
> > +	phy = <&phy0>;
> > +	phy0: phy at 0 {
> > +	      fixed-link;
> > +	      speed = <1000>;
> > +	      full-duplex;
> > +	};
> 
> The phy phandle to a child node is superfluous. A phandle to a fixed
> child node doesn't make a whole lot of sense.

[...]

> There should be no address portion in the node name. It isn't a child
> device, the node is merely more configuration data for the parent.
> 
> Example:
> 
> ethernet at 0 {
> 	...
> 	fixed-link {
> 	      speed = <1000>;
> 	      full-duplex;
> 	};

For my current use case, I'm personally fine with that. But that
doesn't work well with Florian Fainelli's which to potentially have the
"fixed-link" node as part of another node in the DT, in the case the
PHY is configurable through some separate SPI/I2C bus. See his comment
in http://article.gmane.org/gmane.linux.network/306789:

"""
Another problem with that "old" 'fixed-link' property is that we are
not properly capturing and representing Ethernet switches/PHYs whose
data-path are isolated from the control path. For instance such
devices will traditionally expose their control path as a
MMIO/GPIO/I2C/SPI interface. Using the 5-digit 'fixed-link' property
we are not representing this, on one side the Ethernet MAC is just
told to hardcode the link parameters with some parameters, and on
other side, any MMIO/GPIO/I2C/SPI device is not equipped with the
correct properties to express the fact that is also has a data-path
connected to an Ethernet MAC.

What I like about this new binding is that we could place the
'fixed-link' related properties in e.g: a SPI slave node, and have the
Ethernet MAC be pointed at it by a phandle to tell it: look this is
your PHY, it might not be one you could address on a MDIO bus, so I
have been providing additional properties to help you with the link
configuration.
"""

What is your opinion about this?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
