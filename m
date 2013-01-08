From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 19:23:44 +0530
Subject: [RFC v2 01/18] mailbox: OMAP2+: Add support for AM33XX
In-Reply-To: <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC24E8.8010804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:36 PM, Vaibhav Bedia wrote:
> Mailbox IP on AM33XX is the same as that present in OMAP4.
> The single instance of Mailbox IP on AM33XX contains
> 8 sub-modules and facilitates communication between MPU,
> PRUs and WKUP_M3.
>
PRUS?

> The first mailbox sub-module is assigned for communication
> between MPU and WKUP-M3.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Russ Dill <russ.dill@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> v1->v2:
> 	Address the comment on operator usage from Russ Dill
>
>   drivers/mailbox/mailbox-omap2.c |   35 ++++++++++++++++++++++++++++++++++-
>   1 files changed, 34 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
> index 7c26bed..6d61159 100644
> --- a/drivers/mailbox/mailbox-omap2.c
> +++ b/drivers/mailbox/mailbox-omap2.c
> @@ -151,7 +151,7 @@ static void omap2_mbox_disable_irq(struct mailbox *mbox,
>   	struct omap_mbox2_priv *p = mbox->priv;
>   	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>
> -	if (!cpu_is_omap44xx())
> +	if (!cpu_is_omap44xx() && !soc_is_am33xx())
>   		bit = mbox_read_reg(p->irqdisable) & ~bit;
>
>   	mbox_write_reg(bit, p->irqdisable);
> @@ -352,6 +352,32 @@ struct mailbox mbox_2_info = {
>   struct mailbox *omap4_mboxes[] = { &mbox_1_info, &mbox_2_info, NULL };
>   #endif
>
> +#if defined(CONFIG_SOC_AM33XX)
> +static struct omap_mbox2_priv omap2_mbox_wkup_m3_priv = {
> +	.tx_fifo = {
> +		.msg		= MAILBOX_MESSAGE(0),
> +		.fifo_stat	= MAILBOX_FIFOSTATUS(0),
> +		.msg_stat	= MAILBOX_MSGSTATUS(0),
> +	},
> +	.rx_fifo = {
> +		.msg		= MAILBOX_MESSAGE(1),
> +		.msg_stat	= MAILBOX_MSGSTATUS(1),
> +	},
> +	.irqenable	= OMAP4_MAILBOX_IRQENABLE(3),
> +	.irqstatus	= OMAP4_MAILBOX_IRQSTATUS(3),
> +	.irqdisable	= OMAP4_MAILBOX_IRQENABLE_CLR(3),
> +	.notfull_bit	= MAILBOX_IRQ_NOTFULL(0),
> +	.newmsg_bit	= MAILBOX_IRQ_NEWMSG(0),
> +};
> +
> +struct mailbox mbox_wkup_m3_info = {
> +	.name	= "wkup_m3",
> +	.ops	= &omap2_mbox_ops,
> +	.priv	= &omap2_mbox_wkup_m3_priv,
> +};
> +struct mailbox *am33xx_mboxes[] = { &mbox_wkup_m3_info, NULL };
> +#endif
> +
>   static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>   {
>   	struct resource *mem;
> @@ -386,6 +412,13 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>   		list[0]->irq = list[1]->irq = platform_get_irq(pdev, 0);
>   	}
>   #endif
> +#if defined(CONFIG_SOC_AM33XX)
ifdef in middle of the code. I know you are just
following what is already there.
> +	else if (soc_is_am33xx()) {
> +		list = am33xx_mboxes;
> +
UN-necessary extra line here.
> +		list[0]->irq = platform_get_irq(pdev, 0);
> +	}
> +#endif

Hopefully mailbox clean-up will kill that #ifdeffery.
Apart from those comments, patch looks fine to me.

Regards
Santosh
