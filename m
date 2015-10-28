From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 27 Oct 2015 17:34:42 -0700
Subject: [PATCH] clk: iproc: Make clocks visible options
In-Reply-To: <1445541913-25066-1-git-send-email-jonmason@broadcom.com>
References: <1445541913-25066-1-git-send-email-jonmason@broadcom.com>
Message-ID: <20151028003442.GU19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thread didn't seem to finish, so here's some review.

On 10/22, Jon Mason wrote:
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 46ee475..0352ccf 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -9,8 +9,41 @@ config CLK_BCM_KONA
>  	  in the BCM281xx and BCM21664 families.
>  
>  config COMMON_CLK_IPROC
> -	bool
> +	bool "Broadcom iProc clock support"
> +	depends on ARCH_BCM_IPROC

Plus || COMPILE_TEST?

>  	depends on COMMON_CLK
> +	default ARCH_BCM_IPROC
>  	help
>  	  Enable common clock framework support for Broadcom SoCs
>  	  based on the iProc architecture

It's nice that we're grouping the different platforms under one
umbrella config for the iProc architecture. That way we don't
have to see it unless we're targeting the platform. We should
probably do something similar for kona too in case anyone cares
about code bloat there.

> +
> +if COMMON_CLK_IPROC
> +
> +comment "Broadcom iProc clocks"

Please remove this comment block and drop the depends on
COMMON_CLK_IPROC in the configs below. The if section will keep
things properly indented and avoid duplicating that depends on
statement. Plus the comment pretty much duplicates what is
already in the help for COMMON_CLK_IPROC.

We can make COMMON_CLK_IPROC into a hidden option and introduce a
new grouping config if we really care about that case where the
base support is built but there aren't any users. I'd rather not
care though to simplify things.

> +
> +config CLK_BCM_CYGNUS
> +	bool "Broadcom Cygnus clock support"
> +	depends on COMMON_CLK_IPROC
> +	depends on ARCH_BCM_CYGNUS

Plus || COMPILE_TEST?

> +	default ARCH_BCM_CYGNUS
> +	help
> +	  Enable common clock framework support for the Broadcom Cygnus SoC
> +
> +config CLK_BCM_NSP
> +	bool "Broadcom Northstar/Northstar Plus clock support"
> +	depends on COMMON_CLK_IPROC
> +	depends on ARCH_BCM_5301X || ARCH_BCM_NSP

Plus || COMPILE_TEST?

> +	default ARCH_BCM_5301X || ARCH_BCM_NSP
> +	help
> +	  Enable common clock framework support for the Broadcom Northstar and
> +	  Northstar Plus SoCs
> +
> +config CLK_BCM_NS2
> +	bool "Broadcom Northstar 2 clock support"
> +	depends on ARM64

Plus || COMPILE_TEST?

> +	depends on COMMON_CLK_IPROC
> +	default ARCH_BCM_IPROC
> +	help
> +	  Enable common clock framework support for the Broadcom Northstar 2 SoC
> +
> +endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
