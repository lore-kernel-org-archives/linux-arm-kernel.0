From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 29 Apr 2015 07:37:25 +0530
Subject: [PATCH 2/3 v5] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <87618g6nk8.fsf@eliezer.anholt.net>
References: <1430173644-19099-1-git-send-email-eric@anholt.net>
 <1430173644-19099-3-git-send-email-eric@anholt.net>
 <CABb+yY2u_v1uSDrBgP2DRAOrDkXETfs_zmLACm=uRFALVYFjmA@mail.gmail.com>
 <87618g6nk8.fsf@eliezer.anholt.net>
Message-ID: <CABb+yY2OLOPNf=9YyEmw_9m4h4a+sx5FAOkRK9Yc1ZKxDMFd1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 1:19 AM, Eric Anholt <eric@anholt.net> wrote:
> Jassi Brar <jassisinghbrar@gmail.com> writes:
>
>>> +
>>> +struct bcm2835_mbox {
>>> +       struct device *dev;
>>> +       void __iomem *regs;
>>> +       spinlock_t lock;
>>> +       bool started;
>>> +       struct mbox_controller controller;
>>> +};
>>> +
>>> +struct bcm2835_mbox *mbox;
>>> +
>> Bad omen. You assume any platform will ever have just one instance of
>> the mailbox controller. Which may come true, but still is a taboo to
>> think of.
>
> On the other hand, when I've submitted to other subsystems people have
> complained about how I have these extra lookups/container_ofs, instead
> of just storing the obviously-only-one-of-them thing in a global.
>
> I think a global makes definite sense for this driver.
>
0) Why is 'mbox' not even static?
1) It makes sense for system wide entities like stack/protocol
instance. But this is _one_ controller instance with _one_ mailbox
instance. You think any platform will ever only need one mailbox or
use two classes of controllers?
2) "Avoidable global statics are generally bad"

>>> +       if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
>>> +               ret = -EBUSY;
>>> +               goto end;
>>> +       }
>>>
>> This check is unnecessary too. API would have already called
>> last_tx_done() already to make sure this never hits.
>
> Dropped.
>
I see it's not yet.
