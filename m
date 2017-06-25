From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 25 Jun 2017 13:15:45 -0700
Subject: [PATCH v3 2/3] remoteproc/keystone: Add a remoteproc driver for
 Keystone 2 DSPs
In-Reply-To: <20170613234513.7624-3-s-anna@ti.com>
References: <20170613234513.7624-1-s-anna@ti.com>
 <20170613234513.7624-3-s-anna@ti.com>
Message-ID: <20170625201545.GA26155@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 13 Jun 16:45 PDT 2017, Suman Anna wrote:

> +static int keystone_rproc_start(struct rproc *rproc)
> +{
> +	struct keystone_rproc *ksproc = rproc->priv;
> +	int ret;
> +
> +	INIT_WORK(&ksproc->workqueue, handle_event);
> +
> +	ret = request_irq(ksproc->irq_ring, keystone_rproc_vring_interrupt, 0,
> +			  dev_name(ksproc->dev), ksproc);
> +	if (ret) {
> +		dev_err(ksproc->dev, "failed to enable vring interrupt, ret = %d\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	ret = request_irq(ksproc->irq_fault, keystone_rproc_exception_interrupt,
> +			  0, dev_name(ksproc->dev), ksproc);
> +	if (ret) {
> +		dev_err(ksproc->dev, "failed to enable exception interrupt, ret = %d\n",
> +			ret);
> +		goto free_vring_irq;
> +	}

I do prefer that your request any resources during probe() and
potentially enable/disable them here. If below concern about using a
GPIO driver is cleared already I'll take it as is though.

[..]
> +static void keystone_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct keystone_rproc *ksproc = rproc->priv;
> +
> +	if (WARN_ON(ksproc->kick_gpio < 0))
> +		return;
> +
> +	gpio_set_value(ksproc->kick_gpio, 1);
> +}
> +

This doesn't sound like a gpio-controller and the GPIO maintainer did
reject an attempt by me to use the GPIO framework to abstract a similar
thing. Do you already have this driver upstream or have you clarified
with the maintainer that the GPIO framework is an acceptable abstraction
for this?

It looks equivalent to the "APCS IPC" register found in Qualcomm
platforms, previously implemented through a syscon but in v4.13 being
pushed to being a mailbox driver.


Apart from this I think the series looks good.

Regards,
Bjorn
