From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 21 Jul 2015 20:11:38 +0530
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 5:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
> ST's platforms currently support a maximum of 5 Mailboxes, one for
> each of the supported co-processors situated on the platform.  Each
> Mailbox is divided up into 4 instances which consist of 32 channels.
> Messages are passed between the application and co-processors using
> shared memory areas.  It is the Client's responsibility to manage
> these areas.
>
Thanks. It's a lot better than the old driver. However a few nits as usual :)

> +
> +#define STI_MBOX_INST_MAX      4      /* RAM saving: Max supported instances */
>
Above you say 5 instances. Another u32 doesn't cost much.

> +#define STI_MBOX_CHAN_MAX      20     /* RAM saving: Max supported channels  */
> +
This assumption is reasonable.

> +
> +static void sti_mbox_enable_channel(struct mbox_chan *chan)
> +{
> +       struct sti_channel *chan_info = chan->con_priv;
> +       struct sti_mbox_device *mdev = chan_info->mdev;
> +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> +       unsigned int instance = chan_info->instance;
> +       unsigned int channel = chan_info->channel;
> +       unsigned long flags;
> +       void __iomem *base;
> +
> +       base = mdev->base + (instance * sizeof(u32));
> +
Maybe have something simpler like MBOX_BASE(instance)? Or some inline
function to avoid this 5-lines ritual?

> +       spin_lock_irqsave(&sti_mbox_chan_lock, flags);
> +       mdev->enabled[instance] |= BIT(channel);
> +       writel_relaxed(BIT(channel), base + pdata->ena_set);
> +       spin_unlock_irqrestore(&sti_mbox_chan_lock, flags);
>
You don't need locking for SET/CLR type registers which are meant for
when they could be accessed by processors that can not share a lock.
So maybe drop the lock here and elsewhere.

However, you need some mechanism to check if you succeeded 'owning'
the channel by reading back what you write to own the channel (not
sure which is that register here). Usually we need that action and
verification when we assign a channel to some user.

> +
> +static int sti_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct sti_channel *chan_info = chan->con_priv;
> +       struct sti_mbox_device *mdev = chan_info->mdev;
> +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> +       unsigned int instance = chan_info->instance;
> +       unsigned int channel = chan_info->channel;
> +       void __iomem *base;
> +
> +       if (!sti_mbox_tx_is_ready(chan))
> +               return -EBUSY;
This is the first thing I look out for in every new driver :)  this
check is unnecessary.

> +
> +static void sti_mbox_shutdown_chan(struct mbox_chan *chan)
> +{
> +       struct sti_channel *chan_info = chan->con_priv;
> +       struct mbox_controller *mbox = chan_info->mdev->mbox;
> +       int i;
> +
> +       for (i = 0; i < mbox->num_chans; i++)
> +               if (chan == &mbox->chans[i])
> +                       break;
> +
> +       if (mbox->num_chans == i) {
> +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> +               return;
> +       }
> +
> +       sti_mbox_disable_channel(chan);
> +       sti_mbox_clear_irq(chan);
> +
> +       /* Reset channel */
> +       memset(chan, 0, sizeof(*chan));
> +       chan->mbox = mbox;
> +       chan->txdone_method = TXDONE_BY_POLL;
>
No please. mbox_chan is owned by the API. At most you could clear con_priv.

> +static struct mbox_chan *sti_mbox_xlate(struct mbox_controller *mbox,
> +                                       const struct of_phandle_args *spec)
> +{
> +       struct sti_mbox_device *mdev = dev_get_drvdata(mbox->dev);
> +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> +       struct sti_channel *chan_info;
> +       struct mbox_chan *chan = NULL;
> +       unsigned int instance  = spec->args[0];
> +       unsigned int channel   = spec->args[1];
> +       unsigned int direction = spec->args[2];
> +       int i;
> +
> +       /* Bounds checking */
> +       if (instance >= pdata->num_inst || channel  >= pdata->num_chan) {
> +               dev_err(mbox->dev,
> +                       "Invalid channel requested instance: %d channel: %d\n",
> +                       instance, channel);
> +               return NULL;
> +       }
> +
> +       for (i = 0; i < mbox->num_chans; i++) {
> +               chan_info = mbox->chans[i].con_priv;
> +
> +               /* Is requested channel free? */
> +               if (direction != MBOX_LOOPBACK &&
> +                   chan_info &&
> +                   mbox->dev == chan_info->mdev->dev &&
> +                   instance == chan_info->instance &&
> +                   channel == chan_info->channel) {
> +                       dev_err(mbox->dev, "Channel in use\n");
> +                       return NULL;
> +               }
> +
> +               /* Find the first free slot */
> +               if (!chan && !chan_info)
> +                       chan = &mbox->chans[i];
        shouldn't it break out of loop here?

> +       }
> +
Doesn't mbox->chans[i].con_priv need some locking here?

> +
> +static const struct sti_mbox_pdata mbox_stih407_pdata = {
> +       .num_inst       = 4,
> +       .num_chan       = 32,
> +       .irq_val        = 0x04,
> +       .irq_set        = 0x24,
> +       .irq_clr        = 0x44,
> +       .ena_val        = 0x64,
> +       .ena_set        = 0x84,
> +       .ena_clr        = 0xa4,
>
Register offsets are parameters of the controller, and also these look
ugly. Please make these #define's

> +
> +static int __init sti_mbox_init(void)
> +{
> +       return platform_driver_register(&sti_mbox_driver);
> +}
> +
> +static void __exit sti_mbox_exit(void)
> +{
> +       platform_driver_unregister(&sti_mbox_driver);
> +}
> +
> +postcore_initcall(sti_mbox_init);
>
This seems fragile. Shouldn't the users defer probe if they don't get a channel?

cheers!
