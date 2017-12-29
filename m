From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Dec 2017 11:38:50 +0000
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171228074623.GA28444@lunn.ch> <20171228100519.GE2626@kwain>
 <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain>
 <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
Message-ID: <20171229113850.GX10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 12:12:15PM +0100, Marcin Wojtas wrote:
> Hi Russell,
> 
> I see that I misspelled your email address, hence the series remained unnoticed:
> https://lkml.org/lkml/2017/12/18/216
> 
> In terms of the phylink support, I think the most important are:
> * 3/8
> https://lkml.org/lkml/2017/12/18/211
> * 7/8
> https://lkml.org/lkml/2017/12/18/207
> 
> I think the way of obtaining PHY fwnode and connecting it from the
> latter patch could be incorporated to the phylink code. Although I
> didn't get much feedback, the whole ACPI-handling of MDIO bus and the
> PHYs touch ACPI specification and I expect it a slower to get merged.
> Hence my idea is following:
> * Send v2 with ACPI supporting link-irq only in mvpp2.c
> * Extract MDIO bus handling for ACPI and propose PHY handling
> modifications in phylink.
> 
> This way we may push the two things forwards in more efficient way.
> I'm looking forward to your opinion.

Agreed - as we have very few users of phylink at the moment (they're
mostly all in external trees) we can easily change the phylink
interfaces.  The first step is solving the ACPI representation of the
MDIO bus and attached devices, and until that is settled, not much can
be done.

However, it seems to me that the issues of adding ACPI to mvpp2 vs
adding phylink to mvpp2 are two entirely separate problems that don't
really conflict with each other - since the "phy" problem afflicts
both.

However, I'm not sure what this "link-irq" thing is that you talk
about (and I suspect it's one of the things that I've been trying for
months to find out about from Antoine when he says that there's stuff
that mvpp2 supports that phylink doesn't.)  So, I'm left to guess, and
I guess it's the mvpp2-variant of mvneta's in-band autonegotiation.
Continuing to guess from the mvpp2 phylink conversion patch, this mvpp2
variant is selected by not providing a phy handle in DT, whereas
mvneta's variant is selected using the ethernet-standard property
'managed = "in-band-status"'.

If my guessing is correct, I have to wonder why mvpp2 invented a
different way to represent this from mvneta?  This makes it much more
difficult to convert mvpp2 to phylink, and it also makes it difficult
to add SFP support ignoring the phylink issue (since there is no phy
handle there either.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
