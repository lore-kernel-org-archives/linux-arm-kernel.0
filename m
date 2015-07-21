From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Jul 2015 16:52:53 +0100
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <CABb+yY25DC_hmuUhbEVvdEqdUnM6bJxCjBcamZBL97o=jR83Ug@mail.gmail.com>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150721150629.GJ3061@x1>
 <CABb+yY25DC_hmuUhbEVvdEqdUnM6bJxCjBcamZBL97o=jR83Ug@mail.gmail.com>
Message-ID: <20150721155253.GN3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jul 2015, Jassi Brar wrote:

> On Tue, Jul 21, 2015 at 8:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 21 Jul 2015, Jassi Brar wrote:
> >
> >> However, you need some mechanism to check if you succeeded 'owning'
> >> the channel by reading back what you write to own the channel (not
> >> sure which is that register here). Usually we need that action and
> >> verification when we assign a channel to some user.
> >
> > I don't think there is a technical reason why it wouldn't succeed.  We
> > don't normally read back every register change me make.  Why is this
> > IP different?
> >
> Not the IP, but register access. SET and CLR type registers work on
> individual bits because the processors don't share a lock that
> protects register read->modify->write.
> 
> Usually there is also some flag that is set to some unique value to
> claim ownership of the resource, and if two processors try to claim
> simultaneously we need to check if the flag reads back the value we
> set to assert claim. There should be some such flag/register but as I
> said I don't know if/which. Is there?

The only registers we have available are; read_irq_value,
set_irq_value, clear_irq_value, read_enable_value, set_enable_value
and clear_enable_values.

This controller doesn't claim ownership of anything.  It essentially
just turns IRQs on and off.

> >> > +static int sti_mbox_send_data(struct mbox_chan *chan, void *data)
> >> > +{
> >> > +       struct sti_channel *chan_info = chan->con_priv;
> >> > +       struct sti_mbox_device *mdev = chan_info->mdev;
> >> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
> >> > +       unsigned int instance = chan_info->instance;
> >> > +       unsigned int channel = chan_info->channel;
> >> > +       void __iomem *base;
> >> > +
> >> > +       if (!sti_mbox_tx_is_ready(chan))
> >> > +               return -EBUSY;
> >> This is the first thing I look out for in every new driver :)  this
> >> check is unnecessary.
> >
> > In what way?  What if the channel is disabled or there is an IRQ
> > already pending?
> >
> API calls send_data() only if last_tx_done() returned true.

I know for a fact that the 'catchers' in sti_mbox_tx_is_ready() to
fire, because I have triggered them.  I'd really rather keep this
harmless check in.

> >> > +static void sti_mbox_shutdown_chan(struct mbox_chan *chan)
> >> > +{
> >> > +       struct sti_channel *chan_info = chan->con_priv;
> >> > +       struct mbox_controller *mbox = chan_info->mdev->mbox;
> >> > +       int i;
> >> > +
> >> > +       for (i = 0; i < mbox->num_chans; i++)
> >> > +               if (chan == &mbox->chans[i])
> >> > +                       break;
> >> > +
> >> > +       if (mbox->num_chans == i) {
> >> > +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
> >> > +               return;
> >> > +       }
> >> > +
> >> > +       sti_mbox_disable_channel(chan);
> >> > +       sti_mbox_clear_irq(chan);
> >> > +
> >> > +       /* Reset channel */
> >> > +       memset(chan, 0, sizeof(*chan));
> >> > +       chan->mbox = mbox;
> >> > +       chan->txdone_method = TXDONE_BY_POLL;
> >> >
> >> No please. mbox_chan is owned by the API. At most you could clear con_priv.
> >
> > I will look for the API call to reset the channel then.
> >
> API internally does any needed reset.

Okay, thanks for the clarification, I will remove these lines.

> >> > +static const struct sti_mbox_pdata mbox_stih407_pdata = {
> >> > +       .num_inst       = 4,
> >> > +       .num_chan       = 32,
> >> > +       .irq_val        = 0x04,
> >> > +       .irq_set        = 0x24,
> >> > +       .irq_clr        = 0x44,
> >> > +       .ena_val        = 0x64,
> >> > +       .ena_set        = 0x84,
> >> > +       .ena_clr        = 0xa4,
> >> >
> >> Register offsets are parameters of the controller
> >
> > And this is a controller driver?  Not sure I get the point.
> >
> Platform_data usually carries board/platform specific parameters.
> Register offset "properties" are as fixed as the behavior of the
> controller, so they should stay inside the code, not come via
> platform_data.

That's not the case for this controller.  There is nothing preventing
these values from changing on a new board revisions.  After all, this
isn't really a Controller IP per-say.

AFAIK, all current platforms do use this mapping, so I can change it
with a view to changing it back if a different set of offsets appear
in subsequent incarnations.  But again, I think it's pretty harmless.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
