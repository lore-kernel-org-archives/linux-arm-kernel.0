From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 3 Aug 2016 15:16:58 -0700
Subject: [PATCH v4 2/6] power: add power sequence library
In-Reply-To: <1470108652-16812-3-git-send-email-peter.chen@nxp.com>
References: <1470108652-16812-1-git-send-email-peter.chen@nxp.com>
 <1470108652-16812-3-git-send-email-peter.chen@nxp.com>
Message-ID: <20160803221658.GD1405@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Tue, Aug 02, 2016 at 11:30:48AM +0800 Peter Chen ha dit:

> diff --git a/drivers/power/pwrseq/core.c b/drivers/power/pwrseq/core.c
>
> ...
>
> +static DEFINE_MUTEX(pwrseq_list_mutex);
> +static LIST_HEAD(pwrseq_list);
> +
> +int pwrseq_get(struct device_node *np, struct pwrseq *p)
> +{
> +	if (p && p->get)
> +		return p->get(np, p);
> +
> +	return -ENOTSUPP;
> +}
> +
> +int pwrseq_on(struct device_node *np, struct pwrseq *p)
> +{
> +	if (p && p->on)
> +		return p->on(np, p);
> +
> +	return -ENOTSUPP;
> +}
> +
> +void pwrseq_off(struct pwrseq *p)
> +{
> +	if (p && p->off)
> +		p->off(p);
> +}
> +
> +void pwrseq_put(struct pwrseq *p)
> +{
> +	if (p && p->put)
> +		p->put(p);
> +}
> +
> +void pwrseq_free(struct pwrseq *p)
> +{
> +	if (p && p->free)
> +		p->free(p);
> +}
> +
> +void pwrseq_register(struct pwrseq *pwrseq)
> +{
> +	mutex_lock(&pwrseq_list_mutex);
> +	list_add(&pwrseq->node, &pwrseq_list);
> +	mutex_unlock(&pwrseq_list_mutex);
> +}
> +
> +void pwrseq_unregister(struct pwrseq *pwrseq)
> +{
> +	mutex_lock(&pwrseq_list_mutex);
> +	list_del(&pwrseq->node);
> +	mutex_unlock(&pwrseq_list_mutex);
> +}

What is the purpose of pwrseq_register/unregister()? The pwrseq
structs are added and removed from pwrseq_list, but besides that
pwrseq_list is not used.

Looks like this is a remainder from the ancestor of this code
(drivers/mmc/core/pwrseq.c) which uses the list to avoid having
multiple pwrseq instances for the same device.

Matthias
