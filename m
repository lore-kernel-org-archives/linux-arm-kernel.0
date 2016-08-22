From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 10:53:15 -0600
Subject: [PATCH v3 02/12] mailbox: Add Tegra HSP driver
In-Reply-To: <20160819173233.13260-3-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-3-thierry.reding@gmail.com>
Message-ID: <c4e096fe-3f3c-b22a-75c0-9c8665ce896f@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This driver exposes a mailbox interface for interprocessor communication
> using the Hardware Synchronization Primitives (HSP) module's doorbell
> mechanism. There are multiple HSP instances and they provide additional
> features such as shared mailboxes, shared and arbitrated semaphores.
>
> A driver for a remote processor can use the mailbox client provided by
> the HSP driver and build an IPC protocol on top of this synchronization
> mechanism.

> +static int tegra_hsp_doorbell_startup(struct tegra_hsp_channel *channel)
...
> +	spin_lock_irqsave(&hsp->lock, flags);
> +
> +	value = tegra_hsp_channel_readl(&ccplex->channel, HSP_DB_ENABLE);
> +	value |= BIT(db->master);
> +	tegra_hsp_channel_writel(&ccplex->channel, value, HSP_DB_ENABLE);
> +
> +	spin_unlock_irqrestore(&hsp->lock, flags);
> +
> +	if (!tegra_hsp_doorbell_can_ring(db))
> +		return -ENODEV;

Should the error-check happen before enabling the RX path? Otherwise, 
presumably that HSP_DB_ENABLE bit should be cleared on failure.

> +static int tegra_hsp_probe(struct platform_device *pdev)

> +	dev_dbg(&pdev->dev, "regs: %pR (%p-%p)\n", res, hsp->regs, hsp->regs + resource_size(res) - 1);

Line width?
