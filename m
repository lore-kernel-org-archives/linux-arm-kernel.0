From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 11 Jan 2017 11:31:45 +0100
Subject: [PATCH v6 04/14] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_prepare()
In-Reply-To: <1483363905-2806-5-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <3e4a817f-c67f-fd1c-08a6-dafd688badc7@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/17 14:31, Hanjun Guo wrote:
> Adding ACPI support for platform MSI, we need to retrieve the
> dev id in ACPI way instead of device tree, we already have
> a well formed function its_pmsi_prepare() to get the dev id
> but it's OF dependent, so collect OF related code and put them
> into a single function to make its_pmsi_prepare() more friendly
> to ACPI later.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index 470b4aa..3c94278 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -24,15 +24,11 @@
>  	.name			= "ITS-pMSI",
>  };
>
> -static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> -			    int nvec, msi_alloc_info_t *info)
> +static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
> +				  u32 *dev_id)
>  {
> -	struct msi_domain_info *msi_info;
> -	u32 dev_id;
>  	int ret, index = 0;
>
> -	msi_info = msi_get_domain_info(domain->parent);
> -
>  	/* Suck the DeviceID out of the msi-parent property */
>  	do {
>  		struct of_phandle_args args;
> @@ -43,11 +39,24 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  		if (args.np == irq_domain_get_of_node(domain)) {
>  			if (WARN_ON(args.args_count != 1))
>  				return -EINVAL;
> -			dev_id = args.args[0];
> +			*dev_id = args.args[0];
>  			break;
>  		}
>  	} while (!ret);
>
> +	return ret;
> +}
> +
> +static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> +			    int nvec, msi_alloc_info_t *info)
> +{
> +	struct msi_domain_info *msi_info;
> +	u32 dev_id;
> +	int ret;
> +
> +	msi_info = msi_get_domain_info(domain->parent);
> +
> +	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
>  	if (ret)
>  		return ret;
>
>
