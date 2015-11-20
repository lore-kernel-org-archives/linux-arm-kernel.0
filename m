From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 20 Nov 2015 17:17:16 +0530
Subject: [PATCH v3 1/3] mailbox: Add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <b6f12c4d5f45205c356a61acd26aecff70b54e68.1447091626.git.dhdang@apm.com>
References: <1429863912.2927.43.camel@x220>
 <cover.1447091625.git.dhdang@apm.com>
 <b6f12c4d5f45205c356a61acd26aecff70b54e68.1447091626.git.dhdang@apm.com>
Message-ID: <CABb+yY2zHycEmsVvp8OFwpJ1PZgrEPpV-oOe56wgFJ=EE0nTcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 11:35 PM, Duc Dang <dhdang@apm.com> wrote:
> X-Gene mailbox controller provides 8 mailbox channels, with
> each channel has a dedicated interrupt line.
>
> [dhdang: rebase over 4.3-rc5, some minor changes to
> address comment in v2 patch set]
>
Do you want this to go into git logs?

> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---
here is the right place for any history. And it is good practice to
specify whatever changes were made from last revision.


> +
> +struct slimpro_mbox_chan {
> +       struct device *dev;
> +       struct mbox_chan *chan;
> +       void __iomem *reg;
> +       int id;
>
You don't seem to really need 'id'.


> +
> +static void mb_chan_enable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
> +{
> +       u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
> +
> +       val &= ~mask;
> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
> +}
> +
> +static void mb_chan_disable_int(struct slimpro_mbox_chan *mb_chan, u32 mask)
> +{
> +       u32 val = readl(mb_chan->reg + REG_DB_STATMASK);
> +
> +       val |= mask;
> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
> +}
> +
These 2 functions are called just once. And do what other drivers
usually inline. Wouldn't it be better to directly set & clear the bit
when needed?

> +static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
> +{
> +       struct slimpro_mbox_chan *mb_chan =
> +                               (struct slimpro_mbox_chan *)chan->con_priv;
> +
You don't need to typecast a void pointer. Here and elsewhere.


> +
> +       /* Setup mailbox links */
> +       for (i = 0; i < MBOX_CNT; i++) {
> +               ctx->mc[i].irq = platform_get_irq(pdev, i);
>
You expect every platform to provide exactly 'MBOX_CNT' irqs and they
must be different (because you don't 'SHARE' when you request).
Usually developers relax either of the conditions.


> +static struct platform_driver slimpro_mbox_driver = {
> +       .probe  = slimpro_mbox_probe,
> +       .remove = slimpro_mbox_remove,
> +       .driver = {
> +               .name = "xgene-slimpro-mbox",
> +               .owner = THIS_MODULE,
>
No need to set .owner.

Cheers.
