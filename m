From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Apr 2012 10:38:51 +0200
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <20120427073546.GR2234@S2101-09.ap.freescale.net>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
 <20120427034401.GE2234@S2101-09.ap.freescale.net>
 <CAOMZO5DLwrKJQjZD3RWptd4TjUHq=4HLopnzZbFRFvB60pm8XA@mail.gmail.com>
 <20120427050549.GG2234@S2101-09.ap.freescale.net>
 <20120427062732.GM20039@pengutronix.de>
 <20120427073546.GR2234@S2101-09.ap.freescale.net>
Message-ID: <20120427083851.GZ17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:35:48PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 08:27:32AM +0200, Uwe Kleine-K?nig wrote:
> > This seems to me to be a userspace problem? My guess is applying the
> > patch changed the kernel version (appends '+') and you didn't run make
> > modules_install and/or depmod?!
> > 
> Hmm, what the modules are we missing here?  That's actually my question.
> Fabio, Uwe, Sascha, you do not see this error message with your testing?

Every imx spi user (in fact most spi users no matter which driver)
will see this message.

See:

commit ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Feb 22 10:05:38 2012 +0100

    spi: create a message queueing infrastructure
    
    This rips the message queue in the PL022 driver out and pushes
    it into (optional) common infrastructure. Drivers that want to
    use the message pumping thread will need to define the new
    per-messags transfer methods and leave the deprecated transfer()
    method as NULL.
    
    Most of the design is described in the documentation changes that
    are included in this patch.
    
    Since there is a queue that need to be stopped when the system
    is suspending/resuming, two new calls are implemented for the
    device drivers to call in their suspend()/resume() functions:
    spi_master_suspend() and spi_master_resume().
    
    ChangeLog v1->v2:
    - Remove Kconfig entry and do not make the queue support optional
      at all, instead be more agressive and have it as part of the
      compulsory infrastructure.
    - If the .transfer() method is implemented, delete print a small
      deprecation notice and do not start the transfer pump.
    - Fix a bitrotted comment.
    ChangeLog v2->v3:
    - Fix up a problematic sequence courtesy of Chris Blair.
    - Stop rather than destroy the queue on suspend() courtesy of
      Chris Blair.
    
    Signed-off-by: Chris Blair <chris.blair@stericsson.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
