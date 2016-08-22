From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Aug 2016 13:56:05 -0600
Subject: [PATCH v3 12/12] reset: Add Tegra BPMP reset driver
In-Reply-To: <20160819173233.13260-13-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-13-thierry.reding@gmail.com>
Message-ID: <a4fff648-fc4a-af2e-1a17-6aac757b4435@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 11:32 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This driver uses the services provided by the BPMP firmware driver to
> implement a reset driver based on the MRQ_RESET request.

> diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c

> +static struct tegra_bpmp *to_tegra_bpmp(struct reset_controller_dev *rstc)
> +{
> +	return container_of(rstc, struct tegra_bpmp, rstc);
> +}

It seems rather odd for the BPMP to include a struct 
reset_controller_dev inside it. Rather, I'd expect a separate reset 
controller struct to be defined here, which contains a pointer to the 
BPMP. Otherwise, the BPMP structure is going to get all kinds of stuff 
added to it.

Put another way, I'd expect the BPMP driver to be nothing more than an 
IPC provider, with all the clock/reset/power-domain/I2C/... logic 
contained in drivers that simply use that IPC service and nothing more, 
rather than clock/reset/power-domain/I2C/... being entirely in-bed with 
the core BPMP driver.

(I haven't reviewed patch 5/12, the BPMP driver yet BTW).

> +int tegra_bpmp_init_resets(struct tegra_bpmp *bpmp)
...
> +	bpmp->rstc.nr_resets = bpmp->soc->num_resets;

Presumably the BPMP already validates reset IDs. Can we leave all the 
validation to the BPMP? That way, we wouldn't need the SoC data to 
include a num_resets field, and hence wouldn't need to update the Linux 
driver in order to support a FW that supported more resets.
