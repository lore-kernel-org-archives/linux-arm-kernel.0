From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 21 Jul 2015 20:59:34 +0530
Subject: [PATCH 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20150721150629.GJ3061@x1>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
 <1437134647-28298-4-git-send-email-lee.jones@linaro.org>
 <CABb+yY2nAT6V4Q8suAXRtPXrXkArGWVTAW28ts4Z3C_ybuJovA@mail.gmail.com>
 <20150721150629.GJ3061@x1>
Message-ID: <CABb+yY25DC_hmuUhbEVvdEqdUnM6bJxCjBcamZBL97o=jR83Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 8:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 21 Jul 2015, Jassi Brar wrote:
>
>> However, you need some mechanism to check if you succeeded 'owning'
>> the channel by reading back what you write to own the channel (not
>> sure which is that register here). Usually we need that action and
>> verification when we assign a channel to some user.
>
> I don't think there is a technical reason why it wouldn't succeed.  We
> don't normally read back every register change me make.  Why is this
> IP different?
>
Not the IP, but register access. SET and CLR type registers work on
individual bits because the processors don't share a lock that
protects register read->modify->write.

Usually there is also some flag that is set to some unique value to
claim ownership of the resource, and if two processors try to claim
simultaneously we need to check if the flag reads back the value we
set to assert claim. There should be some such flag/register but as I
said I don't know if/which. Is there?

>> > +static int sti_mbox_send_data(struct mbox_chan *chan, void *data)
>> > +{
>> > +       struct sti_channel *chan_info = chan->con_priv;
>> > +       struct sti_mbox_device *mdev = chan_info->mdev;
>> > +       struct sti_mbox_pdata *pdata = dev_get_platdata(mdev->dev);
>> > +       unsigned int instance = chan_info->instance;
>> > +       unsigned int channel = chan_info->channel;
>> > +       void __iomem *base;
>> > +
>> > +       if (!sti_mbox_tx_is_ready(chan))
>> > +               return -EBUSY;
>> This is the first thing I look out for in every new driver :)  this
>> check is unnecessary.
>
> In what way?  What if the channel is disabled or there is an IRQ
> already pending?
>
API calls send_data() only if last_tx_done() returned true.

>> > +static void sti_mbox_shutdown_chan(struct mbox_chan *chan)
>> > +{
>> > +       struct sti_channel *chan_info = chan->con_priv;
>> > +       struct mbox_controller *mbox = chan_info->mdev->mbox;
>> > +       int i;
>> > +
>> > +       for (i = 0; i < mbox->num_chans; i++)
>> > +               if (chan == &mbox->chans[i])
>> > +                       break;
>> > +
>> > +       if (mbox->num_chans == i) {
>> > +               dev_warn(mbox->dev, "Request to free non-existent channel\n");
>> > +               return;
>> > +       }
>> > +
>> > +       sti_mbox_disable_channel(chan);
>> > +       sti_mbox_clear_irq(chan);
>> > +
>> > +       /* Reset channel */
>> > +       memset(chan, 0, sizeof(*chan));
>> > +       chan->mbox = mbox;
>> > +       chan->txdone_method = TXDONE_BY_POLL;
>> >
>> No please. mbox_chan is owned by the API. At most you could clear con_priv.
>
> I will look for the API call to reset the channel then.
>
API internally does any needed reset.

>> > +static const struct sti_mbox_pdata mbox_stih407_pdata = {
>> > +       .num_inst       = 4,
>> > +       .num_chan       = 32,
>> > +       .irq_val        = 0x04,
>> > +       .irq_set        = 0x24,
>> > +       .irq_clr        = 0x44,
>> > +       .ena_val        = 0x64,
>> > +       .ena_set        = 0x84,
>> > +       .ena_clr        = 0xa4,
>> >
>> Register offsets are parameters of the controller
>
> And this is a controller driver?  Not sure I get the point.
>
Platform_data usually carries board/platform specific parameters.
Register offset "properties" are as fixed as the behavior of the
controller, so they should stay inside the code, not come via
platform_data.
