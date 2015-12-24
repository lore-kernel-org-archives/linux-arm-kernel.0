From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Dec 2015 19:35:38 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1450980773.11913.3.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
 <1450980773.11913.3.camel@collins>
Message-ID: <20151224193538.GJ579@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 07:12:53PM +0100, Paul Kocialkowski wrote:
> Le mercredi 23 d?cembre 2015 ? 11:56 +0000, Mark Brown a ?crit :

> > This isn't really adding support for the enable GPIO as the changelog
> > suggests, it's requesting but not managing the GPIO.  Since there is
> > core support for manging enable GPIOs this seems especially silly,
> > please tell the core about the GPIO and then it will work at runtime
> > too.

> It looks like the core bindings for GPIO can only be used instead of the
> rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
> case, where both the GPIO and register write have to be used to enable
> regulators.

> I think it would be worth making it possible to use both in core, since
> that situation is probably shared with other regulators. I suggest the
> following diff (that would be split into a separate patch in v2 of this
> series):

No, that's broken - the whole point with using a GPIO for enable control
on a lot of devices is that it is much faster than doing a register
write.  What I would expect to happen in this case is that when
initialsing the GPIO we set the register to enabled and then only manage
the GPIO at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/7fdb30be/attachment-0001.sig>
