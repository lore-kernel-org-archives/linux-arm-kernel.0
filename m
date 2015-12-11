From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 10:33:22 +0000
Subject: [PATCH] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <20151211102130.GA11966@pengutronix.de>
References: <1449683383-5022-1-git-send-email-gregory.clement@free-electrons.com>
 <20151210073756.GA11966@pengutronix.de>
 <871tau8hpj.fsf@free-electrons.com>
 <20151211084630.GW11966@pengutronix.de>
 <87wpsl727t.fsf@free-electrons.com>
 <20151211102130.GA11966@pengutronix.de>
Message-ID: <20151211103322.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 11:21:30AM +0100, Sascha Hauer wrote:
> On Fri, Dec 11, 2015 at 10:40:22AM +0100, Gregory CLEMENT wrote:
> > So I see 2 options:
> > 
> > - leaving the phy-reset-gpios property in the ethernet node. Thanks to
> >   this we can use the gpiod functions, and it is still possible to use
> >   manage the power management.
> > 
> > - using a reset-gpios property inside the phy node. But then the only
> >   solution to get a reference on it, will be to use
> >   of_get_named_gpio. All the gpiod functions need a reference to the
> >   device that we won't have at this point. Also we will only be able to
> >   power up the reset, but we won't have any reference to it latter.
> 
> Have you seen fwnode_get_named_gpiod()? This seems to be the right
> function for the job.

Except:

1. You don't have a dev->fwnode pointer setup.
2. Using &dev->of_node->fwnode is really going underneath the covers.

I've pointed this problem out several times with the fwnode code, which
seems to be a half-baked and incomplete design when it comes to DT.

I'd suggest using of_get_named_gpio_flags() et.al. and converting the
resulting gpio number to a gpio descriptor - or trying to push DT and
fwnode people to initialise dev->fwnode so that a proper transition to
fwnode for DT can be made.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
