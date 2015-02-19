From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 19 Feb 2015 21:40:53 +0530
Subject: [PATCH v6 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <54E46B77.4060803@arm.com>
References: <1423188007-17047-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1423188528-17134-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <54E46B77.4060803@arm.com>
Message-ID: <CAJe_ZhcejiQ-EJubbxJoPu8kOwB0CPpxmWJyHZcwGNRzXtbNzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2015 at 16:07, Sudeep Holla <sudeep.holla@arm.com> wrote:

>> +++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>> @@ -0,0 +1,35 @@
>> +ARM MHU Mailbox Driver
>> +======================
>> +
>> +The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
>> +3 independent channels/links to communicate with remote processor(s).
>> + MHU links are hardwired on a platform. A link raises interrupt for any
>> +received data. However, there is no specified way of knowing if the sent
>
>
> IIUC the IP as such doesn't have this restriction, it's just the way
> currently integrated in the SoCs. So we need to provide a way for future
> expansion.
>
>> +data has been read by the remote. This driver assumes the sender polls
>> +STAT register and the remote clears it after having read the data.
>
> I would rather drop any specifics about what driver does. Bindings should
> try to confine to the underlying hardware only if possible.
>
The behavior of local controller and remote firmware clubbed together
is what mailbox drivers have to deal with.

 For example, if the remote f/w doesn't clear the STAT register after
reading it, this driver won't have a way to know if the last tx has
been done or not, i.e, mhu_last_tx_done() won't work. And that
behavior is not decided by Linux/driver, so is in a way a h/w feature.
Does your remote f/w not clear the STAT?

>> +Mailbox Device Node:
>> +====================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:          Shall be "arm,mhu" & "arm,primecell"
>> +- reg:                 Contains the mailbox register address range (base
>> +                       address and length)
>> +- #mbox-cells          Shall be 1
>
> Need to explain what that one cell must represent.
>
>> +- interrupts:          Contains the interrupt information corresponding
>> to
>> +                       each of the 3 links of MHU.
>
> How do we handle if the middle link has no interrupt ?
>
The MHU chapter in my SoC manual suggests the specification requires
an RX-IRQ per channel. Does your platform omit the irq?

> Also please that the last channel is secure only and must not be used in
> non-secure execution.
>
I am aware and it is perfectly possible to not touch the secure
channel from NS mode.

>> +config ARM_MHU
>> +       tristate "ARM MHU Mailbox"
>> +       depends on ARM
>> +       help
>> +         Say Y here if you want to build the ARM MHU controller driver
>> +
>
>
> May be a brief one/2-liners on what IP does might be useful ?
>
OK.

>> +
>> +struct arm_mhu {
>> +       void __iomem *base;
>> +       struct mhu_link mlink[3];
>
>
> Replace "3" with some macro throughout the file.
>
Good point.

>> +
>> +static bool mhu_last_tx_done(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = chan->con_priv;
>> +       u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +
>> +       return (val == 0);
>
>
> [Nit] How about just
>         return readl_relaxed(mlink->tx_reg + INTR_STAT_OFS) == 0;
>
I think (val == 0) is less cluttered.

>> +static int mhu_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct mhu_link *mlink = chan->con_priv;
>> +       u32 *arg = data;
>> +
>> +       if (!mhu_last_tx_done(chan)) {
>> +               dev_err(chan->mbox->dev, "Last TX(%d) pending!\n",
>> mlink->irq);
>> +               return -EBUSY;
>> +       }
>
> Why do you need the above check when the core handles that already ?
>
Our bootloader also uses mhu so we could have failed/pending bits in
STAT when Linux first tries to use it. However since then the driver
clears the STAT register upon startup, so this could probably be
dropped. Will do.

>> +static int mhu_startup(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = chan->con_priv;
>> +       u32 val;
>> +       int ret;
>> +
>> +       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
>> +
>> +       ret = request_irq(mlink->irq, mhu_rx_interrupt, 0, "mhu_link",
>> chan);
>> +       if (ret) {
>> +               dev_err(chan->mbox->dev,
>> +                       "Unable to aquire IRQ %d\n", mlink->irq);
>> +               return ret;
>> +       }
>
> This proved costly(in terms of time) on Juno board in my testing,
> requesting and setting up irq for every small packets you need to send.
> I would prefer it to be moved to probe.
>
If your usage of mailbox is so frequent that request-release of irq
proves expensive, maybe you could fix your client to hold onto the
channel for the lifetime. I don't see why your scpi_protocol.c
shouldn't do that, even if request_irq was in probe.

>> +static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
>> +{
>> +       int i, err;
>> +       struct arm_mhu *mhu;
>> +       struct device *dev = &adev->dev;
>> +       int mhu_reg[3] = {0x0, 0x20, 0x200};
>> +
>> +       err = amba_request_regions(adev, NULL);
>> +       if (err)
>> +               return err;
>> +
>> +       /* Allocate memory for device */
>> +       mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
>> +       if (!mhu)
>> +               return -ENOMEM;
>> +
>> +       mhu->base = devm_ioremap_resource(dev, &adev->res);
>
> This will either explode or warn as you have already requested the
> regions. Have you run this code after converting to amba bus device ?
>
Hmm... this was supposed to be tested before sending out the patchset,
but probably overlooked because we have shim api for before mailbox
driver is probed. Yeah we need to drop the amba_request_regions.
Thanks.

>> +       for (i = 0; i < 3; i++) {
>> +               mhu->chan[i].con_priv = &mhu->mlink[i];
>> +               mhu->mlink[i].irq = adev->irq[i];
>> +               mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
>> +               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
>
>
> Again a macro for 0x100 ?
>
Sure :)

>> +
>> +       mhu->mbox.dev = dev;
>> +       mhu->mbox.chans = &mhu->chan[0];
>> +       mhu->mbox.num_chans = 3;
>> +       mhu->mbox.ops = &mhu_ops;
>> +       mhu->mbox.txdone_irq = false;
>> +       mhu->mbox.txdone_poll = true;
>> +       mhu->mbox.txpoll_period = 10;
>
> 10ms seems to high, but if that's a derived value then I am fine.
> On Juno, typically we get response within a millisecond, so we need not
> get blocked on Tx even after getting Rx for 10ms. I prefer it to be set
> to 1 ms.
>
Similar on my platform.  However 1 isn't much meaning in milliseconds
because mod_timer works in jiffiy which is usually atleast 5ms. If we
are polling we can't anyway expect latency critical stuff, so 10ms
seems like a safe bet.

>> +
>> +static struct amba_id mhu_ids[] = {
>> +       {
>> +               .id     = 0x1bb098,
>
>
> This is the problem. This IP has PID(0x98 0xB0 0x1B 0x00 0x04)
> it's 5 bytes[1] . Even I had thought of AMBA initially, it doesn't fit
> as is, may need changes to the amba core to consider this.
>
How is that a problem? AMBA chooses to compare 32bits of PID for the
class. The PID4 might change across versions of MHU, which we could
figure out in the mhu driver in future.

-Jassi
