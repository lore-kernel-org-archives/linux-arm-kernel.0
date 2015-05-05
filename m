From: eric@anholt.net (Eric Anholt)
Date: Mon, 04 May 2015 17:57:46 -0700
Subject: [PATCH 2/3 v7] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
References: <1430254460-26754-1-git-send-email-eric@anholt.net>
 <1430327374-6562-1-git-send-email-eric@anholt.net>
 <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
Message-ID: <871tivq1rp.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar <jassisinghbrar@gmail.com> writes:

> On Wed, Apr 29, 2015 at 10:39 PM, Eric Anholt <eric@anholt.net> wrote:
>
>> +
>> +struct bcm2835_mbox {
>> +       struct device *dev;
>> +       void __iomem *regs;
>> +       spinlock_t lock;
>> +       struct mbox_controller controller;
>> +};
>> +
>> +static struct bcm2835_mbox *mbox;
>> +
>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
>> +{
>> +       struct device *dev = mbox->dev;
>> +       struct mbox_chan *link = &mbox->controller.chans[0];
>> +
> I learn from Stephen's other post that the controller could have
> multiple channels. In which case this driver is poorly setup. Actually
> if the driver was designed properly there isn't anything special to be
> done.
>  Here you choose to waste 'dev_id' and hard-code dereferencing to channel-0

There's only the one channel according to the docs.  I wish we wouldn't
get derailed by speculation on the list when the documentation is
available. :(

>> +       while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
>> +               u32 msg = readl(mbox->regs + MAIL0_RD);
>> +               dev_dbg(dev, "Reply 0x%08X\n", msg);
>> +               mbox_chan_received_data(link, &msg);
>> +       }
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
>> +{
>> +       int ret = 0;
>> +       u32 msg = *(u32 *)data;
>> +
>> +       spin_lock(&mbox->lock);
>> +       writel(msg, mbox->regs + MAIL1_WRT);
>> +       dev_dbg(mbox->dev, "Request 0x%08X\n", msg);
>> +end:
>>
> Did you compile check the driver for errors and warnings?

At this point I'm so burned out on repainting this bikeshed that I
missed a spot of the current color.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/4ef0cb46/attachment-0001.sig>
