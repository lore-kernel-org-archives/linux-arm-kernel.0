From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 21 Apr 2015 16:42:25 +0900
Subject: [PATCH 1/3] mailbox: add support for APM X-Gene platform mailbox
 driver
In-Reply-To: <1424216448-28665-1-git-send-email-fkan@apm.com>
References: <1424216448-28665-1-git-send-email-fkan@apm.com>
Message-ID: <CABb+yY31bGbQ4xipyW9pe+J6QV3con=QFuasEfmpgNNfkKKPVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 8:40 AM, Feng Kan <fkan@apm.com> wrote:

> +#define MBOX_CON_NAME                  "slimpro-mbox"
> +#define MBOX_REG_SET_OFFSET            0x1000
> +#define MBOX_CNT                       8
> +#define MBOX_STATUS_AVAIL_MASK         0x00010000
> +#define MBOX_STATUS_ACK_MASK           0x00000001
>
Nit: BIT(16) and BIT(0) is more readable

> +/* Configuration and Status Registers */
> +struct slimpro_mbox_reg {
> +       u32 in;
> +       u32 din0;
> +       u32 din1;
> +       u32 rsvd1;
> +       u32 out;
> +       u32 dout0;
> +       u32 dout1;
> +       u32 rsvd2;
> +       u32 status;
> +       u32 statusmask;
> +};
> +
Why not the normal way of defining offset macros, like most drivers do?

> +struct slimpro_mbox_chan {
> +       struct device *dev;
> +       struct mbox_chan *chan;
> +       struct slimpro_mbox_reg __iomem *reg;
> +       int id;
> +       int irq;
> +       u32 rx_msg[3];
> +};
> +
> +struct slimpro_mbox {
> +       struct mbox_controller mb_ctrl;
> +       struct slimpro_mbox_chan mc[MBOX_CNT];
> +       struct mbox_chan chans[MBOX_CNT];
> +};
> +
> +static struct slimpro_mbox_chan *to_slimpro_mbox_chan(struct mbox_chan *chan)
> +{
> +       if (!chan || !chan->con_priv)
> +               return NULL;
This seems un-necessary. Anyway you don't care for NULL returned :)
Probably just kill this function?

> +
> +       return (struct slimpro_mbox_chan *)chan->con_priv;
> +}
> +
> +static void mb_chan_send_msg(struct slimpro_mbox_chan *mb_chan, u32 *msg)
> +{
> +       writel(msg[1], &mb_chan->reg->dout0);
> +       writel(msg[2], &mb_chan->reg->dout1);
> +       writel(msg[0], &mb_chan->reg->out);
> +}
> +
> +static void mb_chan_recv_msg(struct slimpro_mbox_chan *mb_chan)
> +{
> +       mb_chan->rx_msg[1] = readl(&mb_chan->reg->din0);
> +       mb_chan->rx_msg[2] = readl(&mb_chan->reg->din1);
> +       mb_chan->rx_msg[0] = readl(&mb_chan->reg->in);
> +}
> +
maybe move the send/recv function inline the caller?

> +static void mb_chan_enable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
> +{
> +       u32 val = readl(&mb_chan->reg->statusmask);
> +
> +       val &= ~mask;
> +
> +       writel(val, &mb_chan->reg->statusmask);
> +}
> +
> +static void mb_chan_disable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
> +{
> +       u32 val = readl(&mb_chan->reg->statusmask);
> +
> +       val |= mask;
> +
> +       writel(val, &mb_chan->reg->statusmask);
> +}
> +
> +static int mb_chan_status_ack(struct slimpro_mbox_chan *mb_chan)
> +{
> +       u32 val = readl(&mb_chan->reg->status);
> +
> +       if (val & MBOX_STATUS_ACK_MASK) {
> +               writel(MBOX_STATUS_ACK_MASK, &mb_chan->reg->status);
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static int mb_chan_status_avail(struct slimpro_mbox_chan *mb_chan)
> +{
> +       u32 val = readl(&mb_chan->reg->status);
> +
> +       if (val & MBOX_STATUS_AVAIL_MASK) {
> +               mb_chan_recv_msg(mb_chan);
> +               writel(MBOX_STATUS_AVAIL_MASK, &mb_chan->reg->status);
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static irqreturn_t slimpro_mbox_irq(int irq, void *id)
> +{
> +       struct slimpro_mbox_chan *mb_chan = id;
> +
> +       if (mb_chan_status_ack(mb_chan))
> +               mbox_chan_txdone(mb_chan->chan, 0);
> +
> +       if (mb_chan_status_avail(mb_chan)) {
> +               mb_chan_recv_msg(mb_chan);
>
you already did this in mb_chan_status_avail()  is it needed?

> +               mbox_chan_received_data(mb_chan->chan, mb_chan->rx_msg);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
> +{
> +       struct slimpro_mbox_chan *mb_chan = to_slimpro_mbox_chan(chan);
> +
> +       mb_chan_send_msg(mb_chan, msg);
> +       return 0;
> +}
> +
> +static int slimpro_mbox_startup(struct mbox_chan *chan)
> +{
> +       struct slimpro_mbox_chan *mb_chan = to_slimpro_mbox_chan(chan);
> +       int rc;
> +
> +       rc = devm_request_irq(mb_chan->dev, mb_chan->irq, slimpro_mbox_irq, 0,
> +                             MBOX_CON_NAME, mb_chan);
>
You may want to use IRQF_SHARED flag here and make slimpro_mbox_irq()
aware of that -- some platforms tie together irq lines of all
instances of a resource, like dma, mbox, so they may share the same
irq line.


> +static int __init slimpro_mbox_probe(struct platform_device *pdev)
> +{
> +       struct slimpro_mbox *ctx;
> +       struct resource *regs;
> +       void __iomem *mb_base;
> +       int rc;
> +       int i;
> +
> +       ctx = devm_kzalloc(&pdev->dev, sizeof(struct slimpro_mbox), GFP_KERNEL);
> +       if (IS_ERR(ctx))
> +               return PTR_ERR(ctx);
> +
> +       platform_set_drvdata(pdev, ctx);
> +
> +       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       mb_base = devm_ioremap_resource(&pdev->dev, regs);
> +       if (IS_ERR(mb_base))
> +               return PTR_ERR(mb_base);
> +
> +       /* Setup mailbox links */
> +       for (i = 0; i < MBOX_CNT; i++) {
> +               ctx->mc[i].irq = platform_get_irq(pdev, i);
> +               if (ctx->mc[i].irq < 0) {
> +                       dev_err(&pdev->dev, "no IRQ at index %d\n",
> +                               ctx->mc[i].irq);
> +                       return -ENODEV;
> +               }
> +
> +               ctx->mc[i].dev = &pdev->dev;
> +               ctx->mc[i].reg = mb_base + i * MBOX_REG_SET_OFFSET;
> +               ctx->mc[i].id = i;
> +               ctx->mc[i].chan = &ctx->chans[i];
> +               ctx->chans[i].con_priv = &ctx->mc[i];
>
Note to self: Maybe we should make it possible to populate a channel
during request/of_xlate.

> +
> +static int __init slimpro_mbox_init(void)
> +{
> +       return platform_driver_register(&slimpro_mbox_driver);
> +}
> +
> +static void __exit slimpro_mbox_exit(void)
> +{
> +}
> +
> +subsys_initcall(slimpro_mbox_init);
> +module_exit(slimpro_mbox_exit);
Why empty module_exit?

regards.
