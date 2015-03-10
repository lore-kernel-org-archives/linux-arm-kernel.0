From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 09:58:18 +0000
Subject: [PATCH 0/3] add power-supply support to dw_hdmi
In-Reply-To: <1429128.MSqYm0qZ9p@phil>
References: <1429128.MSqYm0qZ9p@phil>
Message-ID: <20150310095818.GG8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 12:21:21AM +0100, Heiko Stuebner wrote:
> At least the Rockchip variant of the dw_hdmi should control its supplying
> regulators. A cursory glance at the imx manual didn't any equivalent there,
> so I'm not sure if there are similar controllable regulators present.
> 
> Patch1 is only a small fix to keep {devm_}regulator_bulk_get quiet in
> the deferring case and could go directly to the regulator tree, if ok.
> 
> Patch3 is the addition of the supplies to the rk3288 boards and I would
> take it into my dts branch if patch2 gets deemed acceptable.

I have a problem with this approach.

Rather than trying to shove everything into the generic part of the driver,
what we should be doing is ensuring that the generic part stays generic,
and the specific implementation details end up in the appropriate place.

As Rockchip needs these external regulators, they should be in that part
of the driver, and controlled appropriately from the encoder callbacks.
The encoder has sufficient callbacks to be able to turn on/off regulators
both before and after the bridge has been disabled/enabled.

When we see more implementations with regulators, then we can think about
moving it into the core dw_hdmi driver code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
