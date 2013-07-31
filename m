From: htejun@gmail.com (Tejun Heo)
Date: Wed, 31 Jul 2013 07:32:44 -0400
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731111853.GJ9858@sirena.org.uk>
References: <1375232669-27846-1-git-send-email-festevam@gmail.com>
 <1375232669-27846-2-git-send-email-festevam@gmail.com>
 <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
 <20130731111853.GJ9858@sirena.org.uk>
Message-ID: <20130731113244.GI2810@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 31, 2013 at 12:18:53PM +0100, Mark Brown wrote:
> I'm not sure I understand how this relates the problem.  The main issue
> here is that for the shared IRQ case quiescing the device doesn't make
> any difference since one of the other users of the interrupt could cause
> the interrupt handler to be called regardless of what the hardware is
> doing.  This means that we need to guarantee that anything the interrupt
> handler relies on has not been deallocated before the interrupt handler
> is unregistered.

Yeah, if all resources are allocated using devm - note that you can
hook in non-devm resources using devres_alloc() - all resources which
would be necessary for the interrupt handler would have been allocated
before the irq was allocated, right?  And thus they'll of course
released after the IRQ is freed.  The problem arises when devm and
non-devm releases are mixed as non-devm ones would happen before all
devm ones messing up the release sequencing.

> OK, that's helpful.  It'd be good to document this if it's something
> the API is intending to guarantee, though - devres.txt doesn't mention

Oh, it's definitely guaranteed.  Nothing would work otherwise.

> this and it's not something I'd intuitively expect to be the case.

Oops... I guess I forgot to mention that.  Care to submit a patch?

Thanks.

-- 
tejun
