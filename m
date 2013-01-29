From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Jan 2013 15:01:33 -0600
Subject: [PATCH v3 15/15] ARM: vexpress/dcscb: probe via device tree
In-Reply-To: <1359445870-18925-16-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-16-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510838AD.6040700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 01:51 AM, Nicolas Pitre wrote:
> This allows for the DCSCB support to be compiled in and selected
> at run time.

Shouldn't this just be rolled into the commit creating dcscb.c?

> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/dcscb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index 58051ffafb..a724507cbc 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -14,6 +14,7 @@
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <linux/errno.h>
> +#include <linux/of_address.h>
>  #include <linux/vexpress.h>
>  #include <linux/arm-cci.h>
>  
> @@ -24,8 +25,6 @@
>  #include <asm/cp15.h>
>  
>  
> -#define DCSCB_PHYS_BASE	0x60000000
> -
>  #define RST_HOLD0	0x0
>  #define RST_HOLD1	0x4
>  #define SYS_SWRESET	0x8
> @@ -215,10 +214,14 @@ extern void dcscb_power_up_setup(unsigned int affinity_level);
>  
>  static int __init dcscb_init(void)
>  {
> +	struct device_node *node;
>  	unsigned int cfg;
>  	int ret;
>  
> -	dcscb_base = ioremap(DCSCB_PHYS_BASE, 0x1000);
> +	node = of_find_compatible_node(NULL, NULL, "arm,dcscb");

This needs binding documentation and should be a more specific name. Not
knowing what dcscb is, I don't have a suggestion. Perhaps should include
vexpress or specific core tile name it is part of.

Rob

> +	if (!node)
> +		return -ENODEV;
> +	dcscb_base= of_iomap(node, 0);
>  	if (!dcscb_base)
>  		return -EADDRNOTAVAIL;
>  	cfg = readl_relaxed(dcscb_base + DCS_CFG_R);
> 
