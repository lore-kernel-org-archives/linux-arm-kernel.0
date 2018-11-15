From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2018 15:44:00 -0800
Subject: Regression in next with spi return from transfer_one()
In-Reply-To: <20181115221241.GQ2089@sirena.org.uk>
References: <20181115211451.GH53235@atomide.com>
 <20181115221241.GQ2089@sirena.org.uk>
Message-ID: <20181115234359.GJ53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@kernel.org> [181115 22:12]:
> On Thu, Nov 15, 2018 at 01:14:51PM -0800, Tony Lindgren wrote:
> 
> > Commit 810923f3bf06 ("spi: Deal with slaves that return from
> > transfer_one() unfinished") causes a regression at least on
> > droid 4 with SPI PMIC and regulators on the PMIC. During boot
> > the device just hangs there waiting for rootfs to appear on
> > MMC. Reverting 810923f3bf06 makes things work again.
> 
> > Any ideas why this might be?
> 
> Wow, that's not obvious...  as far as I can tell the code in the !slave
> case is identical so unless the controller is somehow getting mistakenly
> flagged as a slave it looks like it should be something to do with it
> being pushed into a function.  Could you try logging what the timeout
> ends up getting set to?

It seems to be caused because of the now missing "if (ret > 0) {"
line somehow that was there earlier. New code sets ms to 200 it
seems, then dmesg shows:

SPI transfer timed out

The old code is not updating ms and it's set to 1.

Regards,

Tony
