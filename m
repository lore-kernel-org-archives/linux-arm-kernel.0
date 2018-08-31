From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 31 Aug 2018 17:08:38 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831141123.GM30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
Message-ID: <20180831150838.GE32574@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Aug 31, 2018 at 03:11:23PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 31, 2018 at 03:36:51PM +0200, Antoine Tenart wrote:
> > With the above code remove one case did not worked anymore: when the
> > port is configured as a fixed-link because the SFP cage can't be
> > described and used (on the 7040-db and 8040-db boards). In such cases
> > phylink is called, mac_config() is called, but link_up() is never
> > called. I'm not sure this is actually an issue in phylink, but the PPv2
> > driver should probably take care of this weird case itself (by calling
> > explicitly link_up()). What do you think?
> 
> Fixed link should work:
> 
> - when a fixed link is configured, link_config.link is set true.
> - when phylink_start() is called, mac_config() will be called to do the
>   initial setup, and a resolve is triggered.
> - phylink_resolve() will read the fixed link state, which in the case
>   of no GPIO, will inherit link_config.link.
>   - you will then see another mac_config() call.
> 
> Now what happens depends whether you've set the netdev's carrier state
> in the driver - if you haven't, the netdev's carrier state should be
> off.  Since the state mismatches the link_state.link (which will be
> true), you will get a mac_link_up() call.

OK, that makes sense. Thanks for the explanations.

> mvneta ensures this state by always calling netif_carrier_off() in
> mvneta_open(), maybe that ought to be in phylink_start() as that's the
> state that phylink expects when phylink_start() has been called.  So,
> maybe it's a phylink bug.
> 
> Can you see any down-sides to moving the netif_carrier_off() in
> mvneta_open() to phylink_start() ?

I removed most of my previous fix, and called netif_carrier_off() just
before phylink_start() in PPv2. I worked, and it seemed to me all cases
were working fine.

As calling netif_carrier_off() seems to be a phylink assumption, I would
agree to call it directly from within phylink_start(). But I don't have
the full picture here.

If such a solution is OK for you, and if no one raises an issue in the
next days, I can send a series to add a netif_carrier_off() call, fix
PPv2, and remove mvneta's call to netif_carrier_off() in mvneta_open().

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
