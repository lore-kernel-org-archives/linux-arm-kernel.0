From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 May 2018 12:52:47 +0100
Subject: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
In-Reply-To: <20180504135643.23466-3-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
Message-ID: <20180508115247.GF16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 03:56:32PM +0200, Antoine Tenart wrote:
> SFP connectors can be solder on a board without having any of their pins
> (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> and the overall link status reporting is left to other layers.
> 
> In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> This mode is set when it is not possible for the SFP code to get the
> link status and as a result the link status is reported to be always UP
> from the SFP point of view.

This looks weird to me.  SFP_DEV_* states track the netdevice up/down
state and have little to do with whether LOS or MODDEF0 are implemented.

I think it would be better to have a new SFP_MOD_* and to force
sm_mod_state to that in this circumstance.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
