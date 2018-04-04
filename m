From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Apr 2018 15:41:19 +0100
Subject: [PATCH v3 2/4] mfd: add Gateworks System Controller core driver
In-Reply-To: <20180404131239.GD20869@lunn.ch>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-3-git-send-email-tharvey@gateworks.com>
 <CAJ+vNU3-gaTcMAzo5wB6oSfE-JQC3NBVRJS5zFMTE-nVpD4F5g@mail.gmail.com>
 <20180403164715.GA5676@lunn.ch>
 <CAJ+vNU31f+iY5LOG6QmdJetb=pPvY_gpKoS+49FSy70U1Ksd8g@mail.gmail.com>
 <20180404131239.GD20869@lunn.ch>
Message-ID: <20180404144119.GD7691@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 03:12:39PM +0200, Andrew Lunn wrote:
> > What about the 'reset' functionality? Is there something in the power
> > supply API for hooking in a GPIO based power switch (in my case it
> > would be i2c) as I would think that would be common for ATX supplies?
> > I didn't see anything in Documentation/power.

> > This is what led me to the restart handler idea. Ultimately when
> > someone issues a 'reboot' I would like it to use the GSC to
> > power-cycle the board.

> I think you end up with the same problem. By the time you need to turn
> the power supply off, too much of the kernel is shut down to be able
> to use I2C. And if you are in the middle of an Oops, you have no idea
> of the current state. Another I2C transaction could be under way etc.
> All the current reset drivers are pretty much self contained, atomic
> and use KISS hardware like a GPIO.

> Maybe you best bet is to see if you can find any other I2C PMICs which
> the kernel supports.

Most systems have a handshake for final power down via asserting signals
rather than using register writes, the final power down sequence usually
runs way after software.  There's a few things that don't which just
unceremoniously cut the power earlier on without completing the full
power down sequence which for all practical purposes mostly works.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/57136718/attachment.sig>
