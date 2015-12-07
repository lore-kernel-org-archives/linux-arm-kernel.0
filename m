From: dhdang@apm.com (Duc Dang)
Date: Mon, 7 Dec 2015 01:29:24 -0800
Subject: [PATCH v3 1/3] mailbox: Add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <CABb+yY2zHycEmsVvp8OFwpJ1PZgrEPpV-oOe56wgFJ=EE0nTcg@mail.gmail.com>
References: <1429863912.2927.43.camel@x220>
 <cover.1447091625.git.dhdang@apm.com>
 <b6f12c4d5f45205c356a61acd26aecff70b54e68.1447091626.git.dhdang@apm.com>
 <CABb+yY2zHycEmsVvp8OFwpJ1PZgrEPpV-oOe56wgFJ=EE0nTcg@mail.gmail.com>
Message-ID: <CADaLNDmSN3yGSKjLbZiyXgwdEVw0RDjvT7PFaZiv2ByfsrhdzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 3:47 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Mon, Nov 9, 2015 at 11:35 PM, Duc Dang <dhdang@apm.com> wrote:
>> X-Gene mailbox controller provides 8 mailbox channels, with
>> each channel has a dedicated interrupt line.
>>
>> [dhdang: rebase over 4.3-rc5, some minor changes to
>> address comment in v2 patch set]
>>
> Do you want this to go into git logs?

Yes.

I will also rebase the patch set to v4.4-rc1.

>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
> here is the right place for any history. And it is good practice to
> specify whatever changes were made from last revision.

I will add change log into this section in next version of the patch.

>
>
>> +
>> +struct slimpro_mbox_chan {
>> +       struct device *dev;
>> +       struct mbox_chan *chan;
>> +       void __iomem *reg;
>> +       int id;
>>
> You don't seem to really need 'id'.

I will remove 'id'.

>
>
>> +
>> +static void mb_chan_enable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
>> +{
>> +       u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
>> +
>> +       val &= ~mask;
>> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
>> +}
>> +
>> +static void mb_chan_disable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
>> +{
>> +       u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
>> +
>> +       val |= mask;
>> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
>> +}
>> +
> These 2 functions are called just once. And do what other drivers
> usually inline. Wouldn't it be better to directly set & clear the bit
> when needed?

I will fold these 2 functions into their callers and then get rid of them.

>
>> +static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
>> +{
>> +       struct slimpro_mbox_chan *mb_chan =
>> +                               (struct slimpro_mbox_chan *)chan->con_priv;
>> +
> You don't need to typecast a void pointer. Here and elsewhere.

I will remove all the typecast of a void pointer in the driver.

>
>
>> +
>> +       /* Setup mailbox links */
>> +       for (i = 0; i < MBOX_CNT; i++) {
>> +               ctx->mc[i].irq = platform_get_irq(pdev, i);
>>
> You expect every platform to provide exactly 'MBOX_CNT' irqs and they
> must be different (because you don't 'SHARE' when you request).
> Usually developers relax either of the conditions.

I will relax the MBOX_CNT irqs restriction: Platform can provide less
than MBOX_CNT irqs, which also means less than MBOX_CNT mailbox
channels.

>
>
>> +static struct platform_driver slimpro_mbox_driver = {
>> +       .probe  = slimpro_mbox_probe,
>> +       .remove = slimpro_mbox_remove,
>> +       .driver = {
>> +               .name = "xgene-slimpro-mbox",
>> +               .owner = THIS_MODULE,
>>
> No need to set .owner.

I will remove it.

>
> Cheers.

Regards,
Duc Dang.
