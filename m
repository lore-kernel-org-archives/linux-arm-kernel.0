From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Dec 2016 16:18:14 +0100
Subject: [PATCH] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20161221102047.28036-1-uwe@kleine-koenig.org>
References: <20161221102047.28036-1-uwe@kleine-koenig.org>
Message-ID: <20161221151814.GJ30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 11:20:47AM +0100, Uwe Kleine-K?nig wrote:
> The Turris Omnia features a Marvell MV88E7176 ethernet switch. Add it to
> the dts.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> when the MAC is operated in rgmii mode and the switch in rgmii-id
> communication between them works fine. The other way round it doesn't work.
> The fixed-link nodes in the cpu port description is necessary to let the
> mv88e6xxx driver use the phy-mode description. Is this a bug?

It is somewhat deliberate. Normally, there is no phy at all for a cpu
port or a dsa port. If there is no phy, it makes no sense to set the
phy-mode. With fixed-link, there is a phy connected to the MAC, in
terms of how the network stack sees the devices. It is a somewhat
special phy, in fact its bandwidth is fixed, but it does support
phy-handle, and a few other phy properties and callbacks.

> Regarding the binding, I think the label in the port nodes is strange.
> 
> 	label = "lan2"
> 
> for an external port is fine. But
> 
> 	label = "cpu"
> 
> for a port facing a CPU MAC looks wrong, still more as the Turris Omnia has
> two ports connected to the SoC and so there are two ports with the same
> label.

This is somewhat historical. When DSA was designed, only one CPU port
was expected. There are in fact quite a few devices with two CPU
ports. I have some old proof of concept patches to support this, with
some basic load balancing. In the last few weeks, John Crispin has
been working on them, and has duel CPU ports working for the qca8k.
So i expect early next year we can make the Marvell chips support dual
CPU ports as well.

> I would suggest to use a separate property for that, e.g.
> 
> 	cpu-port;
> 
> and no label.

I would suggest keeping this idea for DSA v3, otherwise we end up with
messy code for little gain.

      Andrew
