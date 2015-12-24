From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 24 Dec 2015 21:05:38 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151224193538.GJ579@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <1450980773.11913.3.camel@collins>
 <20151224193538.GJ579@sirena.org.uk>
Message-ID: <1450987538.11913.12.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 24 d?cembre 2015 ? 19:35 +0000, Mark Brown a ?crit :
> On Thu, Dec 24, 2015 at 07:12:53PM +0100, Paul Kocialkowski wrote:
> > Le mercredi 23 d?cembre 2015 ? 11:56 +0000, Mark Brown a ?crit :
> 
> > > This isn't really adding support for the enable GPIO as the changelog
> > > suggests, it's requesting but not managing the GPIO.  Since there is
> > > core support for manging enable GPIOs this seems especially silly,
> > > please tell the core about the GPIO and then it will work at runtime
> > > too.
> 
> > It looks like the core bindings for GPIO can only be used instead of the
> > rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
> > case, where both the GPIO and register write have to be used to enable
> > regulators.
> 
> > I think it would be worth making it possible to use both in core, since
> > that situation is probably shared with other regulators. I suggest the
> > following diff (that would be split into a separate patch in v2 of this
> > series):
> 
> No, that's broken - the whole point with using a GPIO for enable control
> on a lot of devices is that it is much faster than doing a register
> write.  What I would expect to happen in this case is that when
> initialsing the GPIO we set the register to enabled and then only manage
> the GPIO at runtime.

That GPIO is shared with all regulators that the chip provides, so doing
things this way certainly won't work if we don't want all the regulators
powered at all times: in that case, the GPIO has precedence over the
regulator-specific registers.

Doing things the other way round would work and I suppose that chips
that can use a GPIO over registers just wouldn't register any
ops->enable callback in their description.

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/b1fe28d0/attachment.sig>
