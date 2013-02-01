From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 16:02:36 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130201094613.38fa2ad0@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <510B268E.2040104@wwwdotorg.org> <20130201094613.38fa2ad0@skate>
Message-ID: <201302011602.36848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Thomas Petazzoni wrote:
> > So while it's obvious that window base address and size shouldn't be
> > static, I wonder if the assignment of a specific window ID to a
> > specific root port ID shouldn be dynamic or static. For example, if
> > your HW configuration leaves you with 6 windows available, you could
> > support 2 PCIe root ports by statically assigning 3 windows to serve
> > each of those 2 root ports. Would that work, or are there systems
> > where over-commit is needed, e.g. if there's no IO space behind a
> > root port, you could get away with two windows per root port, and
> > hence be able to run 3 root ports rather than just 2? Still, if you
> > know which PCIe devices are being the root ports, you could still
> > represent the over-commit statically in DT
> 
> For now, I haven't figured out how not to allocate an I/O window if the
> downstream device doesn't use I/O, but I'd like to achieve that, as it
> would save one of the two windows needed per PCIe interface... and many
> PCIe devices don't need the I/O window.

The easiest hack would be to only ever allow one I/O window on exactly
one of the ports, and not do PIO on the other ports at all. Given the
various troubles of making any other combination work, that sounds like
a good enough compromise to me. A lot of the add-on cards would not
work in the remaining ports anyway, and worrying too much about that
legacy hardware may just not be worth it. That way, you only need 11
windows for PCIe (10*mem, 1*IO), which will always fit.

Do you actually have /any/ PCIe cards with PIO BARs that you can test
with?

	Arnd
