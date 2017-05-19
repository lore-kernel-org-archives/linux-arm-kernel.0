From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 17:24:10 +0100
Subject: [PATCH 5/6] gpio: mvebu: Add support for the Armada 7K/8K SoCs
In-Reply-To: <54efbdfb0a9800b2c72c6fa1d945c87182b242b4.1495210061.git-series.gregory.clement@free-electrons.com>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <54efbdfb0a9800b2c72c6fa1d945c87182b242b4.1495210061.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170519162410.GT22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:09:24PM +0200, Gregory CLEMENT wrote:
> The Armada 7K and 8K SoCs use the same gpio controller as most of the
> other mvebu SoCs. However, the main difference is that the GPIO
> controller is part of a bigger system controller, and a syscon is used to
> control the overall system controller. Therefore, the driver needs to be
> adjusted to retrieve the regmap of the syscon to access registers, and
> account for the fact that registers are located at a certain offset
> within the regmap.
> 
> This commit add the support of the syscon and introduce a new variant for
> this case.

Do you really need all this complexity of merging what seems to be two
GPIO devices into one for DT purposes?  The device itself appears to be
two instances of the orion-gpio controller, one at 0x100 into the
system controller and a second one at 0x140.

If you instantiate two orion-gpio controllers, then you don't need to
add the "mvchip->offset" stuff.

I'd also say that it was the more correct approach, rather than adding
more complexity to GPIO drivers to support whatever incarnation comes
next.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
