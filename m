From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 Nov 2018 16:29:07 +0100
Subject: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
In-Reply-To: <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
Message-ID: <20181120152907.GA28796@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2018 at 11:27:17AM -0600, Jassi Brar wrote:
> On Mon, Nov 12, 2018 at 9:18 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The mailbox framework supports blocking transfers via completions for
> > clients that can sleep. In order to support blocking transfers in cases
> > where the transmission is not permitted to sleep, add a new ->flush()
> > callback that controller drivers can implement to busy loop until the
> > transmission has been completed. This will automatically be called when
> > available and interrupts are disabled for clients that request blocking
> > transfers.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 8 ++++++++
> >  include/linux/mailbox_controller.h | 4 ++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 674b35f402f5..0eaf21259874 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> >                 unsigned long wait;
> >                 int ret;
> >
> > +               if (irqs_disabled() && chan->mbox->ops->flush) {
> > +                       ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > +                       if (ret < 0)
> > +                               tx_tick(chan, ret);
> > +
> > +                       return ret;
> > +               }
> > +
> This is hacky. I think we can do without busy waiting in atomic
> context. You could queue locally while in atomic context and then
> transfer in blocking mode. I don't think we should worry about the
> 'throughput' as there already is no h/w rate control even with
> busy-waiting.

I actually tried to do that before I added this flushing mechanism. The
problem is, like you said, one of rate control. As mentioned in the
cover letter, the shared mailboxes implemented in tegra-hsp are used as
RX and TX channels for the TCU, which is like a virtual UART. The TTY
driver included as part of this series will use one of the mailboxes to
transmit data that is written to the console. The problem is that if
these transmissions are not rate-limited on the TTY driver side, the
console will just keep writing data and eventually overflow the buffer
that we have in the mailbox subsystem.

The problem is that data comes in at a much higher rate than what we can
output. This is especially true at boot when the TCU console takes over
and the whole log buffer is dumped on it.

So the only way to rate-limit is to either make mbox_send_message()
block, but that can only be done in non-atomic context. The console,
however, will always run in atomic context, so the only way to do rate-
limiting is by busy looping.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/20d316ab/attachment-0001.sig>
