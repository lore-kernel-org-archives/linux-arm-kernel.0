From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Nov 2011 11:59:09 +0800
Subject: [RFC 3/8] of: create of_phandle_args to simplify return of
 phandle parsing data
In-Reply-To: <1320801583-12774-4-git-send-email-grant.likely@secretlab.ca>
References: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
 <1320801583-12774-4-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20111114035908.GA10236@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Tue, Nov 08, 2011 at 06:19:38PM -0700, Grant Likely wrote:
[...]
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4948552..566deab 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -222,6 +222,13 @@ extern const void *of_get_property(const struct device_node *node,
>  #define for_each_property(pp, properties) \
>  	for (pp = properties; pp != NULL; pp = pp->next)
>  
> +#define MAX_PHANDLE_ARGS 8
> +struct of_phandle_args {
> +	struct device_node *np;
> +	int args_count;
> +	uint32_t args[MAX_PHANDLE_ARGS];
> +};
> +

I'm seeing a bunch of warnings like the one below when compiling imx
with the series.  And moving the definition to somewhere before
'#include <asm/prom.h>' in linux/of.h removes the warnings for me.

  CC      arch/arm/kernel/devtree.o
In file included from arch/arm/plat-mxc/include/mach/irqs.h:14:0,
                 from arch/arm/include/asm/irq.h:4,
                 from arch/arm/include/asm/prom.h:17,
                 from include/linux/of.h:133,
                 from arch/arm/kernel/devtree.c:17:
include/asm-generic/gpio.h:133:24: warning: ?struct of_phandle_args? declared inside parameter list
include/asm-generic/gpio.h:133:24: warning: its scope is only this definition or declaration, which is probably not what you want

-- 
Regards,
Shawn
