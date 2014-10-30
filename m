From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 30 Oct 2014 09:57:59 -0700
Subject: [PATCH RESEND V4 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox
 driver
In-Reply-To: <20141030132239.GC19386@ulmo>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-3-git-send-email-abrestic@chromium.org>
 <20141029113415.GD28356@ulmo.nvidia.com>
 <CAL1qeaG2DFyfsPa2wgDqOkYTbnJ-tXoiV48AF9EaSCf1QCtOyQ@mail.gmail.com>
 <20141030132239.GC19386@ulmo>
Message-ID: <CAL1qeaFUKmkRGRr06bWK-yqypHCg_U1qJmUJc9p24xiDLDoaug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:22 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Oct 29, 2014 at 11:02:36AM -0700, Andrew Bresticker wrote:
> [...]
>> > Maybe something like this patch would be more correct in handling
>> > this:
>> >
>> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> > index afcb430508ec..85691a7d8ca6 100644
>> > --- a/drivers/mailbox/mailbox.c
>> > +++ b/drivers/mailbox/mailbox.c
>> > @@ -117,10 +117,11 @@ static void poll_txdone(unsigned long data)
>> >                 struct mbox_chan *chan = &mbox->chans[i];
>> >
>> >                 if (chan->active_req && chan->cl) {
>> > -                       resched = true;
>> >                         txdone = chan->mbox->ops->last_tx_done(chan);
>> >                         if (txdone)
>> >                                 tx_tick(chan, 0);
>> > +                       else
>> > +                               resched = true;
>> >                 }
>> >         }
>>
>> ... but we still need to re-arm the timer if tx_tick() submits another
>> message.  Perhaps the better thing to do is to have msg_submit() arm
>> the timer.
>
> I think we need both. If the last transmission isn't done yet we still
> want to keep polling. And we also want to poll if a new message is sent
> subsequently.
>
> Perhaps it would be as easy as moving the poll handling code from
> mbox_send_message() (if (chan->txdone_method == TXDONE_BY_POLL)) into
> msg_submit()? That has the additional advantage of being able to omit
> the polling when an error happens during the mbox' .send_data().

Yes, this is exactly what I've done :).
