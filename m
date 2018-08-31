From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Aug 2018 16:37:21 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831141123.GM30658@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
 <20180831141123.GM30658@n2100.armlinux.org.uk>
Message-ID: <20180831143721.GB19733@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can you see any down-sides to moving the netif_carrier_off() in
> mvneta_open() to phylink_start() ?

This sounds like a good idea.

What happens on the resume path?

I've not looked at any code.... Just thinking aloud. Can we suspend
with the link up? When we resume, so long as we were not doing WoL,
the link is down. If phylink_start() is not called, we have this miss
match again.

And what about the WoL case? The link is up. What happens if you do a
netif_carrier_off() in phylink_start(), you again have a miss match.
But that case is pretty common with us developers, tftpbooting the
box, with uboot setting the link up before handing over the Linux. So
that case probably works already.

    Andrew
