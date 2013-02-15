From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 15 Feb 2013 10:27:57 +0100
Subject: [PATCH v2 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130214105611.GG17833@n2100.arm.linux.org.uk>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
 <20130214105611.GG17833@n2100.arm.linux.org.uk>
Message-ID: <1360920477.4142.18.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Donnerstag, den 14.02.2013, 10:56 +0000 schrieb Russell King - ARM
Linux:
> On Wed, Feb 13, 2013 at 06:34:32PM +0100, Philipp Zabel wrote:
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Just be aware that PXA has a "gpio reset" facility which is used for SoC
> reset - see arch/arm/mach-pxa/reset.c
> 
> The use of gpio-reset would be ambiguous... or maybe PXA's usage could be
> combined somehow with this?

thank you for pointing this out. The PXA gpio reset code is used for
system/board reset and fiddles with the reset line to trigger all
possible types of reset without needing configuration. The code I
suggest is targeted at resetting peripheral devices, like I2C and SPI
ICs with a reset line connected via GPIO, and it has to be configured
for either active-high or active-low GPIOs. Should this be combined?
I wonder if it would be worth the effort to make the PXA gpio reset go
through this reset API, as there isn't even a struct device that would
be the reset "consumer".

In fact, I don't even think most drivers that currently implement gpio
resets themselves would gain much from switching to another level of
abstraction, unless the SoC already has an on-chip reset controller
anyway - in which case this would mostly increase overall consistency.

regards
Philipp
