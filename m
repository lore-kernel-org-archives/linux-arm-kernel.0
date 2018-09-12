From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Wed, 12 Sep 2018 16:34:02 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831152131.GN30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
 <20180831143721.GB19733@lunn.ch>
 <20180831152131.GN30658@n2100.armlinux.org.uk>
Message-ID: <20180912143402.GA23373@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Aug 31, 2018 at 04:21:31PM +0100, Russell King - ARM Linux wrote:
> 
> I think some questions for Antoine are:

I just got back to this. Using the SFP port on the 7040-db board (which
is one of the problematic interfaces):

> - what is the state of the carrier at the start of mvpp2_start() ?

Always on.

> - when does the missing call to mac_link_up() occur - is it the first
>   time the netdev is brought up, or a subsequent time?

Only the first time the netdev is brought up. If the link is set down
and then up again, its phylink link state would be good, and a mismatch
with the carrier state occurs as expected.

> - is the carrier always off at the end of mvpp2_stop()?

Always off.

So the issue really is the phylink internal link state matching the
carrier on when phylink is started the first time (and hence mac_config
is not called).

I've made some patches to rework PPv2 not to mess things up in
mac_config(), I've added a call to netif_carrier_off() at the
beginning of phylink_start(), and then removed the netif_carrier_off()
call in mvneta's open() function. It seems to work fine, I tested a few
boards with various network configurations. I'll send them so that
we can have more people testing this, and have proper reviews, since
this seems to be an acceptable solution given the answers in this
thread.

Thanks,
Antoine

-- 
Antoine T?nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
