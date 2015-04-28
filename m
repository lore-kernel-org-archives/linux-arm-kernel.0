From: eric@anholt.net (Eric Anholt)
Date: Tue, 28 Apr 2015 12:49:11 -0700
Subject: [PATCH 2/3 v5] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <CABb+yY2u_v1uSDrBgP2DRAOrDkXETfs_zmLACm=uRFALVYFjmA@mail.gmail.com>
References: <1430173644-19099-1-git-send-email-eric@anholt.net>
 <1430173644-19099-3-git-send-email-eric@anholt.net>
 <CABb+yY2u_v1uSDrBgP2DRAOrDkXETfs_zmLACm=uRFALVYFjmA@mail.gmail.com>
Message-ID: <87618g6nk8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar <jassisinghbrar@gmail.com> writes:

> On Tue, Apr 28, 2015 at 3:57 AM, Eric Anholt <eric@anholt.net> wrote:
>> From: Lubomir Rintel <lkundrak@v3.sk>
>>
>> Implement BCM2835 mailbox support as a device registered with the
>> general purpose mailbox framework. Implementation based on commits by
>> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
>> implementation.
>>
>> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
>> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
>>
> We could probably drop the history from changelog. Just talk about
> what the controller is and any specifics of the driver.

How about:

"This mailbox driver provides a single mailbox channel to write 32-bit
values to the VPU and get a 32-bit response.  The Raspberry Pi firmware
uses this mailbox channel to implement firmware calls, while Roku 2
(despite being derived from the same firmware source) doesn't."

>
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>>
> How come it has my s-o-b?

The patch had your s-o-b on it when I started working on it:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2014-October/001006.html

Presumably from:

http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-September/000692.html

I don't see your interaction in the cite for you, though, so if you'd
like the s-o-b removed, I'm happy to do so.  It's been an awfully long
time in development for this driver, with enough revisions, I figured I
just hadn't found where your involvement exactly was.

>> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
>> new file mode 100644
>> index 0000000..6910c71
>> --- /dev/null
>> +++ b/drivers/mailbox/bcm2835-mailbox.c
>> @@ -0,0 +1,220 @@
>> +/*
>> + *  Copyright (C) 2010 Broadcom
>> + *  Copyright (C) 2013-2014 Lubomir Rintel
>> + *  Copyright (C) 2013 Craig McGeachie
>> + *
> You may want to make it 2015

At this point I've probably done enough to merit adding a 2015 for
Broadcom.  Done.

>> +/* Status register: FIFO state. */
>> +#define ARM_MS_FULL            0x80000000
>> +#define ARM_MS_EMPTY           0x40000000
>>
> nit:  BIT(31) and BIT(30)
>
>> +
>> +/* Configuration register: Enable interrupts. */
>> +#define ARM_MC_IHAVEDATAIRQEN  0x00000001
>>
> nit: BIT(0)

Works for me.

>> +
>> +struct bcm2835_mbox {
>> +       struct device *dev;
>> +       void __iomem *regs;
>> +       spinlock_t lock;
>> +       bool started;
>> +       struct mbox_controller controller;
>> +};
>> +
>> +struct bcm2835_mbox *mbox;
>> +
> Bad omen. You assume any platform will ever have just one instance of
> the mailbox controller. Which may come true, but still is a taboo to
> think of.

On the other hand, when I've submitted to other subsystems people have
complained about how I have these extra lookups/container_ofs, instead
of just storing the obviously-only-one-of-them thing in a global.

I think a global makes definite sense for this driver.  But if I have to
go readd the code I had cleaned up, to act like there might be more than
one, I could.

>> +       struct mbox_chan *link = &mbox->controller.chans[0];
>> +
>> +       while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
>> +               u32 msg = readl(mbox->regs + MAIL0_RD);
>> +
>> +               if (!mbox->started) {
>> +                       dev_err(dev, "Reply 0x%08x with no client attached\n",
>> +                               msg);
>>
> This shouldn't happen unless the remote could send asynchronous
> commands to Linux. And even if it does, we shouldn't be seeing them
> before we are ready. Please move the "Enable the interrupt on data
> reception" from probe to bcm2835_startup(), and disable interrupts in
> bcm2835_shutdown()

Done.

>> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
>> +{
>> +       int ret = 0;
>> +       u32 msg = *(u32 *)data;
>> +
> Sorry, this is seen as an abuse. Please pass pointer to a u32 and not
> typecast the value.

This is a pointer to a u32 being passed in.  I think you misread, or I'm
misunderstanding you.

>> +       if (!mbox->started)
>> +               return -ENODEV;
>>
> This 'started' flag is unnecessary. API won't call send_data() before
> startup() or after shutdown().

Dropped.

>> +       if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
>> +               ret = -EBUSY;
>> +               goto end;
>> +       }
>>
> This check is unnecessary too. API would have already called
> last_tx_done() already to make sure this never hits.

Dropped.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150428/7a449b9e/attachment.sig>
