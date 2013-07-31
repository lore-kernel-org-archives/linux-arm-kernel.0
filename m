From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 12:50:27 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731113244.GI2810@htj.dyndns.org>
References: <1375232669-27846-1-git-send-email-festevam@gmail.com>
 <1375232669-27846-2-git-send-email-festevam@gmail.com>
 <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
 <20130731113244.GI2810@htj.dyndns.org>
Message-ID: <20130731115027.GN9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 07:32:44AM -0400, Tejun Heo wrote:

> Yeah, if all resources are allocated using devm - note that you can
> hook in non-devm resources using devres_alloc() - all resources which
> would be necessary for the interrupt handler would have been allocated
> before the irq was allocated, right?  And thus they'll of course
> released after the IRQ is freed.  The problem arises when devm and
> non-devm releases are mixed as non-devm ones would happen before all
> devm ones messing up the release sequencing.



> > OK, that's helpful.  It'd be good to document this if it's something
> > the API is intending to guarantee, though - devres.txt doesn't mention

> Oh, it's definitely guaranteed.  Nothing would work otherwise.

Most things would work just fine - most of the uses of devm_ are just
resource allocations that can safely be freed in essentially any order.
It doesn't really matter if you free the driver's private structure
before you free the clock that's pointing to it or whatever since
neither has any real connection to the other.

> > this and it's not something I'd intuitively expect to be the case.

> Oops... I guess I forgot to mention that.  Care to submit a patch?

I'll take a look.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/c5f64924/attachment.sig>
