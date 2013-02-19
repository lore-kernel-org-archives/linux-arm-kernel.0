From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 16:00:05 -0700
Subject: [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
In-Reply-To: <1361187031-3679-4-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-4-git-send-email-wni@nvidia.com>
Message-ID: <512403F5.5010005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Add support to handle irq. When the temperature touch the limit value, the
> driver can handle the interrupt.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> +static void lm90_irq_work(struct work_struct *work)
...
> +	enable_irq(client->irq);
> +}
> +
> +static irqreturn_t lm90_irq(int irq, void *dev_id)
> +{
> +	struct lm90_data *data = dev_id;
> +
> +	disable_irq_nosync(irq);

I think IRQF_ONESHOT would enable you to remove the manual
enable/disable_irq calls.
