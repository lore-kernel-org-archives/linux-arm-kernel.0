From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 14 Nov 2016 13:53:36 +0530
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <20161114145459.63c23391@xhacker>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-2-git-send-email-pankaj.dubey@samsung.com>
 <20161114141251.7ea86e7a@xhacker>
 <CGME20161114070338epcas1p1d88b5303c60ee5fd2b51fc68ce182b35@epcas1p1.samsung.com>
 <20161114145459.63c23391@xhacker>
Message-ID: <a1b322bf-b31b-5a30-aa1a-14bcbd265f6b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Monday 14 November 2016 12:24 PM, Jisheng Zhang wrote:
> 
> On Mon, 14 Nov 2016 14:12:51 +0800 Jisheng Zhang wrote:
> 
>> Hi Pankaj,
>>

<snip>

>>> + * Helper API to get SCU base address
>>> + * In case platform DT do not have SCU node, or iomap fails
>>> + * this call will fallback and will try to map via call to
>>> + * scu_a9_get_base.
>>> + * This will return ownership of scu_base to the caller
>>> + */
>>> +void __iomem *of_scu_get_base(void)
>>> +{
>>> +	unsigned long base = 0;
>>> +	struct device_node *np;
>>> +	void __iomem *scu_base;
>>> +
>>> +	np = of_find_matching_node(NULL, scu_match);  
>>
>> could we check np before calling of_iomap()?
>>
>>> +	scu_base = of_iomap(np, 0);
>>> +	of_node_put(np);
>>> +	if (!scu_base) {
>>> +		pr_err("%s failed to map scu_base via DT\n", __func__);  
>>
>> For non-ca5, non-ca9 based SoCs, we'll see this error msg. We understand
>> what does it mean, but it may confuse normal users. In current version,
>> berlin doesn't complain like this for non-ca9 SoCs
> 
> oops, I just realized that the non-ca9 berlin arm SoC version isn't upstreamed.
> Below is the draft version I planed. Basically speaking, the code tries to
> find "arm,cortex-a9-scu" node from DT, if can't, we think we don't need to
> worry about SCU. Is there any elegant solution for my situation?
> 

To adopt new generic API I have submitted a patch for Berlin (along with
other various platforms) here:

https://patchwork.kernel.org/patch/9426457/

Please review and if possible test and let me know feedback.

Thanks,
Pankaj Dubey

> Thanks,
> Jisheng
> 
> 
> ------------8<-------------------
> --- a/arch/arm/mach-berlin/platsmp.c
> +++ b/arch/arm/mach-berlin/platsmp.c
> @@ -56,22 +56,25 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
>  	void __iomem *vectors_base;
>  
>  	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
> -	scu_base = of_iomap(np, 0);
> -	of_node_put(np);
> -	if (!scu_base)
> -		return;
> +	if (np) {
> +		scu_base = of_iomap(np, 0);
> +		of_node_put(np);
> +		if (!scu_base)
> +			return;
> +		scu_enable(scu_base);
> +		iounmap(scu_base);
> +	}
>  
>  	np = of_find_compatible_node(NULL, NULL, "marvell,berlin-cpu-ctrl");
>  	cpu_ctrl = of_iomap(np, 0);
>  	of_node_put(np);
>  	if (!cpu_ctrl)
> -		goto unmap_scu;
> +		return;
>  
>  	vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);
>  	if (!vectors_base)
> -		goto unmap_scu;
> +		return;
>  
> -	scu_enable(scu_base);
>  	flush_cache_all();
>  
>  	/*
> @@ -87,8 +90,6 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
>  	writel(virt_to_phys(secondary_startup), vectors_base + SW_RESET_ADDR);
>  
>  	iounmap(vectors_base);
> -unmap_scu:
> -	iounmap(scu_base);
>  }
>  
>  static struct smp_operations berlin_smp_ops __initdata = {
> 
> 
>>
>>> +		if (scu_a9_has_base()) {
>>> +			base = scu_a9_get_base();
>>> +			scu_base = ioremap(base, SZ_4K);
>>> +		}
>>> +		if (!scu_base) {
>>> +			pr_err("%s failed to map scu_base\n", __func__);  
>>
>> ditto
>>
>>> +			return IOMEM_ERR_PTR(-ENOMEM);
>>> +		}
>>> +	}
>>> +	return scu_base;
>>> +}
>>> +
>>> +/*
>>> + * Enable SCU via mapping scu_base DT
>>> + * If scu_base mapped successfully scu will be enabled and in case of
>>> + * failure if will return non-zero error code
>>> + */
>>> +int of_scu_enable(void)
>>> +{
>>> +	void __iomem *scu_base;
>>> +
>>> +	scu_base = of_scu_get_base();
>>> +	if (!IS_ERR(scu_base)) {
>>> +		scu_enable(scu_base);
>>> +		iounmap(scu_base);
>>> +		return 0;
>>> +	}
>>> +	return PTR_ERR(scu_base);
>>> +}
>>> +
>>>  #endif
>>>  
>>>  /*  
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> 
