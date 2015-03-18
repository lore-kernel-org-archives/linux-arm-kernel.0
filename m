From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 18 Mar 2015 10:25:27 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <55095297.5060605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

Forgot couple of things earlier:

On 04/03/15 11:01, Vincent Yang wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>
> Add driver for the ARM Primecell Message-Handling-Unit(MHU) controller.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
> ---
>   .../devicetree/bindings/mailbox/arm-mhu.txt        |  43 +++++
>   drivers/mailbox/Kconfig                            |   9 +
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/arm_mhu.c                          | 195 +++++++++++++++++++++
>   4 files changed, 249 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
>   create mode 100644 drivers/mailbox/arm_mhu.c
>

[...]

> +static int mhu_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 *arg = data;
> +

Arnd doesn't like this and had suggestions in some other thread.

> +	writel_relaxed(*arg, mlink->tx_reg + INTR_SET_OFS);
> +
> +	return 0;
> +}
> +
> +static int mhu_startup(struct mbox_chan *chan)
> +{
> +	struct mhu_link *mlink = chan->con_priv;
> +	u32 val;
> +	int ret;
> +
> +	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
> +	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
> +
> +	ret = request_irq(mlink->irq, mhu_rx_interrupt,
> +			  IRQF_SHARED, "mhu_link", chan);

Any reason we can't move this to probe and have {en,dis}able_irq here if
needed. I has seen it was too heavy to have these especially when
sending small packets.

Regards,
Sudeep
