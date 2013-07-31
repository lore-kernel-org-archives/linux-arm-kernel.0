From: broonie@kernel.org (Mark Brown)
Date: Wed, 31 Jul 2013 12:18:53 +0100
Subject: [PATCH 2/2] chipidea: Use devm_request_irq()
In-Reply-To: <20130731095411.GA2810@htj.dyndns.org>
References: <1375232669-27846-1-git-send-email-festevam@gmail.com>
 <1375232669-27846-2-git-send-email-festevam@gmail.com>
 <20130731073306.GZ1754@pengutronix.de>
 <20130731082054.GF8540@nchen-desktop>
 <20130731084645.GB1754@pengutronix.de>
 <20130731090512.GD9858@sirena.org.uk>
 <20130731094434.GC1754@pengutronix.de>
 <20130731095411.GA2810@htj.dyndns.org>
Message-ID: <20130731111853.GJ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 05:54:11AM -0400, Tejun Heo wrote:
> On Wed, Jul 31, 2013 at 11:44:34AM +0200, Uwe Kleine-K?nig wrote:

> > > > OK, so the possible problem is that remove is called while the irq is
> > > > still active. That means you have to assert that all resources the irq

> If your driver destruction path is running while your irq handler is
> still running, it's a crappy / broken driver.  You need a deactivation
> step whether you're using devm or not.  IRQs can be shared and the
> device should be in a quiesced state before the driver detaches
> itself.  Note that you can queue deactivation routine using devm.  For
> an example, please take a look at
> drivers/ata/libata-core.c::ata_host_start().

I'm not sure I understand how this relates the problem.  The main issue
here is that for the shared IRQ case quiescing the device doesn't make
any difference since one of the other users of the interrupt could cause
the interrupt handler to be called regardless of what the hardware is
doing.  This means that we need to guarantee that anything the interrupt
handler relies on has not been deallocated before the interrupt handler
is unregistered.

> irq deregistration.  Add an explicit deactivation step using
> devres_alloc().

> devm guarantees that the destruction callbacks are called in the
> reverse order of registration.

OK, that's helpful.  It'd be good to document this if it's something
the API is intending to guarantee, though - devres.txt doesn't mention
this and it's not something I'd intuitively expect to be the case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/e15fad37/attachment.sig>
