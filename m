From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 11:33:51 +0200
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
In-Reply-To: <53AA8D8C.2040705@eukrea.com>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
 <20140625060848.GE15686@pengutronix.de>
 <53AA8D8C.2040705@eukrea.com>
Message-ID: <20140625093351.GR15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 10:51:24AM +0200, Denis Carikli wrote:
> On 06/25/2014 08:08 AM, Sascha Hauer wrote:
> >It's a shame that the LCD controller doesn't do the reference counting.
> >I really think it should be fixed there and not in the drivers.If for
> >whatever reason this is not acceptable then it should be done in the
> >imxfb driver instead of shifting it further to the regulator core.
> I'm not sure that doing reference counting in the LCD class would be
> enough for the regulator case. Still it seems to be a good thing to
> do.
> 
> If I understood well, that assumes that the LCD driver is the only
> consumer and owner of that regulator.

No. All consumers of a regulator must make sure the regulator enable
count is balanced.

Image that the regulator in the imxfb is used by multiple consumers.
When you want to enable the backlight you must make sure that you
take a reference to the regulator yourself. Otherwise it may
happen that 'if (regulator_is_enabled())' is true because another
consumer has enabled it and your code does nothing. Then the other
consumer decides to disable the regulator which in this case will
accidently disable the backlight.

> 
> There is also the fact that the regulator core also enables or
> disables regulators by itself:
> For instance at boot it tries to disable the regulators that can be
> disabled, including this regulator.
> 
> So I don't see any ways to handle it correctly in the LCD.

It's simple. Add an lcd_enable flag to struct lcd_device. Make sure you
only call into the drivers when it differs from the current state.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
