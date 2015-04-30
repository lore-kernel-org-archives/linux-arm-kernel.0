From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 30 Apr 2015 10:56:33 +0530
Subject: [PATCH 2/3 v7] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1430327374-6562-1-git-send-email-eric@anholt.net>
References: <1430254460-26754-1-git-send-email-eric@anholt.net>
 <1430327374-6562-1-git-send-email-eric@anholt.net>
Message-ID: <CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:39 PM, Eric Anholt <eric@anholt.net> wrote:

> +
> +struct bcm2835_mbox {
> +       struct device *dev;
> +       void __iomem *regs;
> +       spinlock_t lock;
> +       struct mbox_controller controller;
> +};
> +
> +static struct bcm2835_mbox *mbox;
> +
> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
> +{
> +       struct device *dev = mbox->dev;
> +       struct mbox_chan *link = &mbox->controller.chans[0];
> +
I learn from Stephen's other post that the controller could have
multiple channels. In which case this driver is poorly setup. Actually
if the driver was designed properly there isn't anything special to be
done.
 Here you choose to waste 'dev_id' and hard-code dereferencing to channel-0

> +       while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
> +               u32 msg = readl(mbox->regs + MAIL0_RD);
> +               dev_dbg(dev, "Reply 0x%08X\n", msg);
> +               mbox_chan_received_data(link, &msg);
> +       }
> +       return IRQ_HANDLED;
> +}
> +
> +static int bcm2835_send_data(struct mbox_chan *link, void *data)
> +{
> +       int ret = 0;
> +       u32 msg = *(u32 *)data;
> +
> +       spin_lock(&mbox->lock);
> +       writel(msg, mbox->regs + MAIL1_WRT);
> +       dev_dbg(mbox->dev, "Request 0x%08X\n", msg);
> +end:
>
Did you compile check the driver for errors and warnings?

> +static int bcm2835_mbox_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       int ret = 0;
> +       struct resource *iomem;
> +
> +       mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +       if (mbox == NULL)
> +               return -ENOMEM;
> +       mbox->dev = dev;
> +       spin_lock_init(&mbox->lock);
> +
> +       ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
> +                              bcm2835_mbox_irq, 0, dev_name(dev), mbox);
>
Why even pass 'mbox' when you insist on ignoring 'dev_id' and access
the global variable again directly :D
