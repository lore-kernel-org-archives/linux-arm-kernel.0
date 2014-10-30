From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 14:22:40 +0100
Subject: [PATCH RESEND V4 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox
 driver
In-Reply-To: <CAL1qeaG2DFyfsPa2wgDqOkYTbnJ-tXoiV48AF9EaSCf1QCtOyQ@mail.gmail.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-3-git-send-email-abrestic@chromium.org>
 <20141029113415.GD28356@ulmo.nvidia.com>
 <CAL1qeaG2DFyfsPa2wgDqOkYTbnJ-tXoiV48AF9EaSCf1QCtOyQ@mail.gmail.com>
Message-ID: <20141030132239.GC19386@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 11:02:36AM -0700, Andrew Bresticker wrote:
[...]
> > Maybe something like this patch would be more correct in handling
> > this:
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index afcb430508ec..85691a7d8ca6 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -117,10 +117,11 @@ static void poll_txdone(unsigned long data)
> >                 struct mbox_chan *chan = &mbox->chans[i];
> >
> >                 if (chan->active_req && chan->cl) {
> > -                       resched = true;
> >                         txdone = chan->mbox->ops->last_tx_done(chan);
> >                         if (txdone)
> >                                 tx_tick(chan, 0);
> > +                       else
> > +                               resched = true;
> >                 }
> >         }
> 
> ... but we still need to re-arm the timer if tx_tick() submits another
> message.  Perhaps the better thing to do is to have msg_submit() arm
> the timer.

I think we need both. If the last transmission isn't done yet we still
want to keep polling. And we also want to poll if a new message is sent
subsequently.

Perhaps it would be as easy as moving the poll handling code from
mbox_send_message() (if (chan->txdone_method == TXDONE_BY_POLL)) into
msg_submit()? That has the additional advantage of being able to omit
the polling when an error happens during the mbox' .send_data().

> >> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +     if (!res)
> >> +             return -ENODEV;
> >> +     mbox->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> >> +     if (!mbox->regs)
> >> +             return -ENOMEM;
> >
> > This doesn't look right. Upon closer inspection, the reason why you
> > don't use devm_request_resource() is because these registers are shared
> > with the XHCI controller.
> >
> > Perhaps a better design would be for the XHCI driver to expose the
> > mailbox rather than split it off into a separate driver.
> 
> Well that's what I had originally, but then it was suggested I make it
> a separate driver.
> 
> Stephen also brought this up during review and suggested that some
> sort of MFD would be the best way to structure this, but was fine with
> the way I have it now.  I can move this driver around (again) if you
> feel that strongly about it...

We've had this discussion only recently about the memory controller
driver. It used to be that there were separate drivers for the memory
controller part and the IOMMU part. But that resulted in hilarious DT
bindings. Granted, most of the issues had to do with unfortunate inter-
leaving of register regions, but generally I think there's nothing wrong
with exposing multiple interfaces from a single driver.

The downside of course is that you have to choose which subsystem is the
primary one and then get it merged via that tree. There's also a problem
in that the driver is now in a different directory than the others, so a
subsystem-wide change may not notice the "out-of-place" driver. But I
think we have pretty good tools to help with this type of thing.

Also, managing all the resources (regulators, clocks, resets, ...) that
a hardware block requires is much easier to do in a single driver than
spread over several. MFD could be an option somewhere halfway between
the two but also has some downsides. Most importantly it isn't going to
scale in the long run.

> >> diff --git a/include/soc/tegra/xusb.h b/include/soc/tegra/xusb.h
> >> new file mode 100644
> >> index 0000000..cfe211d
> >> --- /dev/null
> >> +++ b/include/soc/tegra/xusb.h
> >
> > Perhaps this should really be named xusb-mbox.h?
> 
> I'd prefer to leave it as xusb.h so that any other XUSB-related
> definitions can be left here.

Okay, that makes sense given that the mbox really is part of the larger
XUSB block.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/2d4eb3d4/attachment.sig>
