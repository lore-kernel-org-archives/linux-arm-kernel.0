From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jul 2017 20:38:20 +0100
Subject: [PATCH net-next 10/18] net: mvpp2: use the GoP interrupt for
 link status changes
In-Reply-To: <20170726162648.GK12049@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <20170726162648.GK12049@lunn.ch>
Message-ID: <20170726193820.GR31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 06:26:48PM +0200, Andrew Lunn wrote:
> And this is another bit of code you probably need to change in a while
> with phylink lands.

The way the MAC driver handles link up/down and configuration events
changes significantly when a MAC driver switches to phylink, since
a directly connected SFP cage needs to have the MAC reconfigured
between SGMII and 1000base-X modes.  If you add SFP+ into that, also
10Gbase-KR as well.

Note also that the "link up" condition for SFP (and probably SFF) is
more complex than just "is the module reporting that it's receiving
a signal" - especially with 1000base-X, there's negotiation to be
performed, so you also need to know (if the module is connected
directly to the MAC) whether the Serdes is in sync and has finished
negotiation (and itself says it has link with the remote end.)

With the Marvell 88x3310 PHY, the MAC driver already needs to switch
between 10Gbase-KR and SGMII modes, as the 88x3310 automatically
makes that switch on its MAC facing interface without software
intervention.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
