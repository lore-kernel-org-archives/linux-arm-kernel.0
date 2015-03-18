From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 18 Mar 2015 18:49:48 +0530
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <55095297.5060605@arm.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
 <55095297.5060605@arm.com>
Message-ID: <CABb+yY0qRSocL-ePosUzszAh4X6161ve8_qUq4VizbLWMAmMCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 3:55 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>> +static int mhu_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct mhu_link *mlink = chan->con_priv;
>> +       u32 *arg = data;
>
> Arnd doesn't like this and had suggestions in some other thread.
>
No, Arnd suggested doing it this way. And another platform's driver
was made to do this way.

>> +       writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
>> +
>> +       return 0;
>> +}
>> +
>> +static int mhu_startup(struct mbox_chan *chan)
>> +{
>> +       struct mhu_link *mlink = chan->con_priv;
>> +       u32 val;
>> +       int ret;
>> +
>> +       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>> +       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
>> +
>> +       ret = request_irq(mlink->irq, mhu_rx_interrupt,
>> +                         IRQF_SHARED, "mhu_link", chan);
>
>
> Any reason we can't move this to probe and have {en,dis}able_irq here if
> needed. I has seen it was too heavy to have these especially when
> sending small packets.
>
I see you used to do memcpy in irq-handler
https://git.linaro.org/landing-teams/working/arm/kernel.git/blob/HEAD:/drivers/mailbox/arm_mhu.c
perhaps you were using your old driver?

If you use this new driver, and send packets so often that
request-release irq has effect, maybe should hold the mailbox
reference for lifetime. I remember suggesting you that already and I
remember you said that's how it was.

-Jassi
