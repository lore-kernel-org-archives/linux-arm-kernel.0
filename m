From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 29 May 2015 19:33:33 +0200
Subject: [PATCH v3] ARM: l2c: add options to overwrite prefetching behavior
In-Reply-To: <1431726751-9169-1-git-send-email-hauke@hauke-m.de>
References: <1431726751-9169-1-git-send-email-hauke@hauke-m.de>
Message-ID: <5568A2ED.4000502@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will this make it into kernel 4.2 or do I have to do something so that
this will make it into 4.2?

Hauke

On 05/15/2015 11:52 PM, Hauke Mehrtens wrote:
> These options make it possible to overwrites the data and instruction
> prefetching behavior of the arm pl310 cache controller.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> v2: only set prefetch
> v1: set prefetch and aux
> 
>  Documentation/devicetree/bindings/arm/l2cc.txt |  4 ++++
>  arch/arm/mm/cache-l2x0.c                       | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index 0dbabe9..528821a 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -67,6 +67,10 @@ Optional properties:
>    disable if zero.
>  - arm,prefetch-offset : Override prefetch offset value. Valid values are
>    0-7, 15, 23, and 31.
> +- arm,prefetch-data : Enable data prefetch. Enabling prefetching
> +  can improve performance.
> +- arm,prefetch-instr : Enable instruction prefetch. Enabling prefetching
> +  can improve performance.
>  
>  Example:
>  
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index e309c8f..1aa970a 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1199,6 +1199,26 @@ static void __init l2c310_of_parse(const struct device_node *np,
>  		pr_err("L2C-310 OF arm,prefetch-offset property value is missing\n");
>  	}
>  
> +	ret = of_property_read_u32(np, "arm,prefetch-data", &val);
> +	if (ret == 0) {
> +		if (val)
> +			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
> +		else
> +			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
> +	} else if (ret != -EINVAL) {
> +		pr_err("L2C-310 OF arm,prefetch-data property value is missing\n");
> +	}
> +
> +	ret = of_property_read_u32(np, "arm,prefetch-instr", &val);
> +	if (ret == 0) {
> +		if (val)
> +			prefetch |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
> +		else
> +			prefetch &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
> +	} else if (ret != -EINVAL) {
> +		pr_err("L2C-310 OF arm,prefetch-instr property value is missing\n");
> +	}
> +
>  	l2x0_saved_regs.prefetch_ctrl = prefetch;
>  }
>  
> 
