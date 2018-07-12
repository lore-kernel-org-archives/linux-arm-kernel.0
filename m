From: liviu.dudau@arm.com (Liviu Dudau)
Date: Thu, 12 Jul 2018 10:18:15 +0100
Subject: [PATCH -next] misc: vexpress: Fix potential NULL dereference in
 vexpress_syscfg_probe()
In-Reply-To: <20180711154110.GB10578@e107155-lin>
References: <1531315058-183762-1-git-send-email-weiyongjun1@huawei.com>
 <20180711154110.GB10578@e107155-lin>
Message-ID: <20180712091815.GT15340@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 04:41:10PM +0100, Sudeep Holla wrote:
> On Wed, Jul 11, 2018 at 01:17:38PM +0000, Wei Yongjun wrote:
> > platform_get_resource() may fail and return NULL, so we should
> > better check it's return value to avoid a NULL pointer dereference
> > a bit later in the code.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > @@
> > expression pdev, res, n, t, e, e1, e2;
> > @@
> > 
> > res = platform_get_resource(pdev, t, n);
> > + if (!res)
> > +   return -EINVAL;
> > ... when != res == NULL
> > e = devm_ioremap(e1, res->start, e2);
> 
> Instead of adding unnecessary check here, I would go with replacing it
> with devm_ioremap_resource as it's designed to deal with that (patch inline)
> 
> Regards,
> Sudeep
> 
> -->8
> From a6de466984e657dad24dcbe87e5dde2d21cb8d35 Mon Sep 17 00:00:00 2001
> From: Sudeep Holla <sudeep.holla@arm.com>
> Date: Wed, 11 Jul 2018 16:17:39 +0100
> Subject: [PATCH] misc: vexpress/syscfg: Use devm_ioremap_resource() to map
>  memory
> 
> Instead of checking the return value of platform_get_resource(), we can
> use devm_ioremap_resource() which has the NULL pointer check and the
> memory region requesting. devm_ioremap_resource is designed to replace
> calls to devm_request_mem_region followed by devm_ioremap, so let's use
> the same.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/misc/vexpress-syscfg.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
> index 80a6f199077c..6c3591cdf855 100644
> --- a/drivers/misc/vexpress-syscfg.c
> +++ b/drivers/misc/vexpress-syscfg.c
> @@ -258,13 +258,9 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&syscfg->funcs);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -			resource_size(res), pdev->name))
> -		return -EBUSY;
> -
> -	syscfg->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -	if (!syscfg->base)
> -		return -EFAULT;
> +	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(syscfg->base))
> +		return PTR_ERR(syscfg->base);
>  
>  	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
>  	bridge = vexpress_config_bridge_register(pdev->dev.parent,
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
