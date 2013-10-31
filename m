From: nm@ti.com (Nishanth Menon)
Date: Thu, 31 Oct 2013 09:03:46 -0500
Subject: [PATCHv9 01/43] clk: Add support for regmap register read/write
In-Reply-To: <1382716658-6964-2-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-2-git-send-email-t-kristo@ti.com>
Message-ID: <52726342.6030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 10:56 AM, Tero Kristo wrote:
[...]
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 7e59253..63ff78c 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h

[...]
> -static inline u32 clk_readl(u32 __iomem *reg)
> +static inline u32 clk_readl(u32 __iomem *reg, struct regmap *regmap)
>  {
> -	return readl(reg);
> +	u32 val;
> +
> +	if (regmap)
> +		regmap_read(regmap, (u32)reg, &val);
> +	else
> +		val = readl(reg);
> +	return val;
>  }
>  
> -static inline void clk_writel(u32 val, u32 __iomem *reg)
> +static inline void clk_writel(u32 val, u32 __iomem *reg, struct regmap *regmap)
>  {
> -	writel(val, reg);
> +	if (regmap)
> +		regmap_write(regmap, (u32)reg, val);
> +	else
> +		writel(val, reg);
>  }
>  
>  #endif /* CONFIG_COMMON_CLK */
> 

Might it not be better to introduce regmap variants?
static inline void clk_regmap_writel(u32 val, u32 reg, struct regmap
*regmap)
and corresponding readl? that allows cleaner readability for clk
drivers that use regmap and those that dont.

regmap can also return error value that could also be handled as a result.

-- 
Regards,
Nishanth Menon
