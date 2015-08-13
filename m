From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 13 Aug 2015 21:10:59 +0530
Subject: [PATCH v2 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1437990272-23111-4-git-send-email-lee.jones@linaro.org>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CABb+yY3NTHLx2N-sUABjxQW=MUCntdUg1d8kjvjH0dkb4n9EgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 3:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> +
> +static bool sti_mbox_tx_is_ready(struct mbox_chan *chan)
> +{
> +       struct sti_channel *chan_info = chan->con_priv;
> +       struct sti_mbox_device *mdev = chan_info->mdev;
> +       unsigned int instance = chan_info->instance;
> +       unsigned int channel = chan_info->channel;
> +       void __iomem *base = MBOX_BASE(mdev, instance);
> +
> +       if (!(chan_info->direction & MBOX_TX))
> +               return false;
>
Here the 'direction' is gotten via DT node of the client i.e, you
expect consumer drivers to tell the provider what its limitations are?

IMO if some physical channel can't do TX then that should be either
hardcoded inside the controller driver or learnt via DT node of the
_controller_.


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
return ERR_PTR(-EINVAL)

> +       }
> +
> +       for (i = 0; i < mbox->num_chans; i++) {
> +               chan_info = mbox->chans[i].con_priv;
> +
> +               /* Is requested channel free? */
> +               if (direction != MBOX_LOOPBACK &&
>
Consider this example when 2 clients ask for same physical channel but
in different modes.
           mboxes = <&mboxA 0 1 MBOX_TX>;
           mboxes = <&mboxA 0 1 MBOX_LOOPBACK>;

You happily assign 2 virtual channels backed by one physical channel
{mboxA, 0, 1}. The 2 clients think they can freely do startup(),
shutdown() and send_data() on the channels. But obviously we are
screwed with races like
   client1.startup()
    -> client2.startup()
        -> client2.send_data()
            -> client2.shutdown()
                -> client1.send_data()  XXXX

 Now you can shove in some more checks to 'fix' the race OR you can
simply expose only physical channels. Practically no client would ever
ask it to do what it can't, and for the hypothetical possibility that
some does, just return error.

> +                   chan_info &&
> +                   mbox->dev == chan_info->mdev->dev &&
> +                   instance == chan_info->instance &&
> +                   channel == chan_info->channel) {
> +                       dev_err(mbox->dev, "Channel in use\n");
> +                       return NULL;
return ERR_PTR(-EBUSY)

> +               }
> +
> +               /*
> +                * Find the first free slot, then continue checking
> +                * to see if requested channel is in use
> +                */
> +               if (!chan && !chan_info)
> +                       chan = &mbox->chans[i];
> +       }
> +
> +       if (!chan) {
> +               dev_err(mbox->dev, "No free channels left\n");
> +               return NULL;
return ERR_PTR(-EBUSY)

> +       }
> +
> +       chan_info = devm_kzalloc(mbox->dev, sizeof(*chan_info), GFP_KERNEL);
> +       if (!chan_info)
> +               return NULL;
return ERR_PTR(-ENOMEM)

Thanks.
