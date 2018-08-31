From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Aug 2018 16:21:31 +0100
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831143721.GB19733@lunn.ch>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
 <20180831143721.GB19733@lunn.ch>
Message-ID: <20180831152131.GN30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 04:37:21PM +0200, Andrew Lunn wrote:
> > Can you see any down-sides to moving the netif_carrier_off() in
> > mvneta_open() to phylink_start() ?
> 
> This sounds like a good idea.
> 
> What happens on the resume path?

Suspend/resume should be safe, because we force the link down when
phylink_stop() is called.

Looking at mvneta again, mvneta_stop_dev() is called in the suspend
path, which then calls phylink_stop().  This causes us to call
mac_link_down() and netif_carrier_off().  So, at the point of suspend,
the netdev carrier is set down and the mac taken down.

When resuming, mvneta_start_dev() calls phylink_start(), which undoes
the changes above, calling mac_link_up() if the link is now up.

So, as long as netdevs don't mess with the carrier state in their
suspend/resume functions, and they call phylink_start()/phylink_stop()
there, everything will work as intended - and that's really the key
issue here.

> I've not looked at any code.... Just thinking aloud. Can we suspend
> with the link up? When we resume, so long as we were not doing WoL,
> the link is down. If phylink_start() is not called, we have this miss
> match again.

It depends what you mean by "link up".  Are you talking about the PHYs
link to the external world (which is normally what's responsible for
handling WOL) or are you talking about keeping the MAC and its rings
alive so it can process packets while suspended.

If the former, that's the responsibility of phylib to manage, if the
latter, the netdev must not call phylink_stop() in its suspend function.

Either way, not messing with the netdev's carrier state is key.

The only exception to this is that the carrier should be down at open()
time.  However, I don't see anything in net/core that fiddles with the
carrier state for a net device, so the default state at boot should be
carrier-off.

I think some questions for Antoine are:

- what is the state of the carrier at the start of mvpp2_start() ?
- when does the missing call to mac_link_up() occur - is it the first
  time the netdev is brought up, or a subsequent time?
- is the carrier always off at the end of mvpp2_stop()?

Having a local reproducer may help, so if you can point to a DT fragment
and set of steps to reproduce, it could be helpful.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
