From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 21 Jul 2011 14:02:12 +0530
Subject: [PATCH 03/17] ARM: gic: Use cpu pm notifiers to save gic state
In-Reply-To: <1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E27E40C.6020006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo, Colin,

On 7/7/2011 9:20 PM, Lorenzo Pieralisi wrote:
> From: Colin Cross<ccross@android.com>
>
> When the cpu is powered down in a low power mode, the gic cpu
> interface may be reset, and when the cpu complex is powered
> down, the gic distributor may also be reset.
>
> This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
> and restore the gic cpu interface registers, and the
> CPU_COMPLEX_PM_ENTER and CPU_COMPLEX_PM_EXIT notifiers to save
> and restore the gic distributor registers.
>
> Signed-off-by: Colin Cross<ccross@android.com>
> ---
>   arch/arm/common/gic.c |  212 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 212 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 4ddd0a6..8d62e07 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c

[...]

I missed one more comment in the last review.

> +static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
> +{
> +	int i;
> +
> +	for (i = 0; i<  MAX_GIC_NR; i++) {
> +		switch (cmd) {
> +		case CPU_PM_ENTER:
> +			gic_cpu_save(i);
On OMAP, GIC cpu interface context is lost only when CPU cluster
is powered down.
> +			break;
> +		case CPU_PM_ENTER_FAILED:
> +		case CPU_PM_EXIT:
> +			gic_cpu_restore(i);
> +			break;
> +		case CPU_COMPLEX_PM_ENTER:
> +			gic_dist_save(i);
> +			break;
> +		case CPU_COMPLEX_PM_ENTER_FAILED:
> +		case CPU_COMPLEX_PM_EXIT:
> +			gic_dist_restore(i);
> +			break;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
Entire GIC is kept in CPU cluster power domain and
hence GIC CPU interface context won't be lost whenever
CPU alone enters in the deepest power state.

If it is different on other SOC's then the common
notifiers won't match to all the SOC designs.

Looks like exporting these functions directly or
adding them to gen irq and then invoking them
from platform code based on power sequence need
might be better.

Regards
Santosh
