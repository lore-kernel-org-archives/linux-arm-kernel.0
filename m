From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jun 2015 12:10:47 +0100
Subject: [PATCH 2/2] arm/smmu: Make use of of_parse_phandle_with_var_args
In-Reply-To: <1435247548-32201-2-git-send-email-joro@8bytes.org>
References: <1435247548-32201-1-git-send-email-joro@8bytes.org>
 <1435247548-32201-2-git-send-email-joro@8bytes.org>
Message-ID: <20150626111047.GA9791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Thanks for looking at this! I'm fine with the general idea, but obviously
the first patch needs an Ack from a devicetree person.

One comment on the code below...

On Thu, Jun 25, 2015 at 04:52:28PM +0100, Joerg Roedel wrote:
> The function of_parse_phandle_with_args() can only handle 16
> args, but there are systems that require more (25 in my
> case). So use the newly introduced function
> of_parse_phandle_with_var_args() instead.

[...]

> +	masterspec = of_alloc_phandle_args(MAX_MASTER_STREAMIDS);
> +	if (!masterspec)
> +		return -ENOMEM;
> +
>  	i = 0;
>  	smmu->masters = RB_ROOT;
> -	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
> -					   "#stream-id-cells", i,
> -					   &masterspec)) {
> -		err = register_smmu_master(smmu, dev, &masterspec);
> +	while (!of_parse_phandle_with_var_args(dev->of_node, "mmu-masters",
> +					   "#stream-id-cells", i, masterspec,
> +					   MAX_MASTER_STREAMIDS)) {
> +		err = register_smmu_master(smmu, dev, masterspec);
>  		if (err) {
>  			dev_err(dev, "failed to add master %s\n",
> -				masterspec.np->name);
> +				masterspec->np->name);
>  			goto out_put_masters;
>  		}
>  
> @@ -1811,6 +1815,9 @@ out_free_irqs:
>  		free_irq(smmu->irqs[i], smmu);
>  
>  out_put_masters:
> +
> +	of_free_phandle_args(masterspec);

Shouldn't we also free the masterspec on success?

Will
