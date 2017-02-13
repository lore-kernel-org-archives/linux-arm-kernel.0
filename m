From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:37:03 +0100 (CET)
Subject: [RFC PATCH 17/33] irqchip/gic-v3-its: Add VLPI configuration hook
In-Reply-To: <1484648454-21216-18-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-18-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131135220.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> +{
> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +	struct its_cmd_info *info = vcpu_info;
> +	u32 event = its_get_event_id(d);
> +
> +	/* Need a v4 ITS */
> +	if (!its_dev->its->is_v4 || !info)
> +		return -EINVAL;
> +
> +	switch (info->cmd_type) {
> +	case MAP_VLPI:
> +	{

Looking at the later patches which add functionality here, I'd rather avoid
these massive case { } blocks and stick the functionality into seperate
helper functions.

Thanks,

	tglx
