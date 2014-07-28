From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Jul 2014 11:41:48 +0200
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140725164518.GQ21766@n2100.arm.linux.org.uk>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140725131217.GS8181@intel.com> <20140725163746.GC20328@lukather>
 <20140725164518.GQ21766@n2100.arm.linux.org.uk>
Message-ID: <20140728094148.GC3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jul 25, 2014 at 05:45:19PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 25, 2014 at 06:37:46PM +0200, Maxime Ripard wrote:
> > Hi Vinod,
> > 
> > On Fri, Jul 25, 2014 at 06:42:17PM +0530, Vinod Koul wrote:
> > > - don't use devm_request_irq(). You have irq enabled and you have killed
> > >   tasklet. This is too racy. You need to ensure no irqs can be generated before killing
> > >   tasklets.
> > 
> > Ok, would calling disable_irq before killing the tasklet an option for
> > you ? that would allow to keep the devm_request_irq.
> 
> That's not really an acceptable approach if you can use shared
> interrupts.

We don't, but yes, I see your point.

> A better alternative would be devm_free_irq() to give a definite point
> that the interrupt is unregistered in the driver remove sequence.  That
> allows you to keep the advantage of devm_request_irq() to clean up during
> the initialisation side.

Ah, right, thanks.

> An alternative approach would be to ensure that the hardware is quiesced,
> and interrupts are disabled.  Then call synchronize_irq() on it, and at
> that point, you should be certain that your interrupt handler should not
> process any further interrupts for your device (though, in a shared
> interrupt environment, it would still be called should a different device
> on the shared line raise its interrupt.)

Actually, unless I'm missing something, that's pretty much what we're
doing here.

I disable all interrupts in the DMA controller, I call
synchronize_irq, and then kill the tasklet. The only interrupts I
could get are spurious, and we made sure such kind of interrupts
couldn't schedule the tasklet either.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/5d00e9e9/attachment.sig>
