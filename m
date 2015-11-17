From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Nov 2015 16:21:18 +0000
Subject: [PATCH] ARM: mvebu: add reference to ETH connectors for A385-AP
In-Reply-To: <7560280.yqEeu9J2fA@wuerfel>
References: <1447775620-25919-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <7560280.yqEeu9J2fA@wuerfel>
Message-ID: <20151117162118.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 04:57:20PM +0100, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 16:53:40 Thomas Petazzoni wrote:
> > This commit adds some comments to the Armada 385 AP Device Tree
> > description to indicate which Ethernet interface matches which
> > physical connector on the board.
> > 
> > This is especially useful on this board, since the mapping between the
> > logical interface names and the physical ports is not very
> > straightforward. It also doesn't match the numbering of the interfaces
> > done by U-Boot:
> > 
> >  U-Boot interface | Linux interface | Physical port
> >  -----------------+-----------------+--------------
> >    egiga0         |     eth2        |   CON4
> >    egiga1         |     eth0        |   CON2
> >    egiga2         |     eth1        |   CON3
> >  -----------------+-----------------+--------------
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> 
> Would it be possible to use entries in /aliases to fix the order of the
> interfaces and make them match the physical ports?

Unfortunately not, and I believe davem is averse to "fixing" this problem
in the kernel.  It's really problematical, especially if you are running
a debian based distro and want to be able to say "I want egiga0 configured
like _this_".  You're entirely at the mercy of the ordering that the DT
compiler decides to place the nodes, and the ordering which the kernel
decides to probe the interfaces, etc.

Yes, there's always the ethernet MAC which can be used to identify them,
but debian at least doesn't have a way to identify interfaces in its
/etc/network/interfaces file by ethernet MAC.

So, use the modern network-manager daemon... umm no, not if you want to
use bridging or any of the other such facilities.

This whole area is really very annoying.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
