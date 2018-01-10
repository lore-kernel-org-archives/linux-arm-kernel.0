From: stefan@agner.ch (Stefan Agner)
Date: Wed, 10 Jan 2018 21:49:47 +0100
Subject: [PATCH 2/2] soc: imx: gpc: Do not pass static memory as platform
 data
In-Reply-To: <20180110161608.13015-2-andrew.smirnov@gmail.com>
References: <20180110161608.13015-1-andrew.smirnov@gmail.com>
 <20180110161608.13015-2-andrew.smirnov@gmail.com>
Message-ID: <1f914ea33fef8ede0c81085bedf46ed5@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-10 17:16, Andrey Smirnov wrote:
> Platform device core assumes the ownership of dev.platform_data as
> well as that it is dynamically allocated and it will try to kfree it
> as a part of platform_device_release(). Change the code to pass
> kzalloc'ed chunk of memory instead of a pointer to a static memory to
> avoid causing a BUG() when calling platform_device_put().

I tried to get around that by setting platform_data to null before
unregistring the device, see:
https://marc.info/?l=linux-arm-kernel&m=151553216030129&w=2


This solutions still seems to miss unregistering the platform devices,
which shows when binding the driver again:

root at colibri-imx6:~# echo 20dc000.gpc >
/sys/bus/platform/drivers/imx-gpc/unbind 
[   80.702627] imx-pgc-pd imx-pgc-power-domain.0: Dropping the link to
20dc000.gpc
[   80.710808] genpd_remove: unable to remove PU
[   80.716408] imx-pgc-pd imx-pgc-power-domain.1: Dropping the link to
20dc000.gpc
root at colibri-imx6:~# find /sys -name *pgc-power*
/sys/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.0
/sys/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.1
/sys/bus/platform/devices/imx-pgc-power-domain.0
/sys/bus/platform/devices/imx-pgc-power-domain.1
root at colibri-imx6:~# echo 20dc000.gpc >
/sys/bus/platform/drivers/imx-gpc/bind 
[   89.002754] ------------[ cut here ]------------
[   89.007411] WARNING: CPU: 0 PID: 516 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x64/0x74
[   89.015057] sysfs: cannot create duplicate filename
'/devices/soc0/soc/2000000.aips-bus/20dc000.gpc/imx-pgc-power-domain.0'


> 
> The problem can be reproduced by artificially enabling the error path
> of platform_device_add() call (around line 452).
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> This patch is a follow up to fix one of the bugs discussed in
> lkml.kernel.org/r/3f836677c6e98aaf01bc1ac8c3410083 at agner.ch
> 
>  drivers/soc/imx/gpc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 47e7aa963dbb..ec8b79abebac 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
>  
>  #define GPC_CNTR		0x000
>  
> @@ -428,13 +429,19 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			if (domain_index >= of_id_data->num_domains)
>  				continue;
>  
> -			domain = &imx_gpc_domains[domain_index];
> +			domain = kzalloc(sizeof(*domain), GFP_KERNEL);

I guess you could use just kalloc here since you memcpy below.

--
Stefan

> +			if (!domain) {
> +				of_node_put(np);
> +				return -ENOMEM;
> +			}
> +			memcpy(domain, &imx_gpc_domains[domain_index], sizeof(*domain));
>  			domain->regmap = regmap;
>  			domain->ipg_rate_mhz = ipg_rate_mhz;
>  
>  			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
>  							domain_index);
>  			if (!pd_pdev) {
> +				kfree(domain);
>  				of_node_put(np);
>  				return -ENOMEM;
>  			}
