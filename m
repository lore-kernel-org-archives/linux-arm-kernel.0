From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 24 May 2010 18:14:28 +0300 (EEST)
Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
In-Reply-To: <1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-14-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20100524.181428.176650885.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 13/14] omap: mailbox: simplify omap_mbox_register()
Date: Sat, 22 May 2010 19:14:24 +0200

> No need to dynamically register mailboxes one by one.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/mach-omap1/mailbox.c             |   25 ++------
>  arch/arm/mach-omap2/mailbox.c             |   22 ++-----
>  arch/arm/plat-omap/include/plat/mailbox.h |    5 +-
>  arch/arm/plat-omap/mailbox.c              |   95 +++++++++++------------------
>  4 files changed, 50 insertions(+), 97 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index 4210896..e50b3c2 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -29,8 +29,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox1_fifo {
>  	unsigned long cmd;
>  	unsigned long data;
> @@ -151,38 +149,29 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
>  	list = omap1_mboxes;
> -
>  	list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>  
>  	mbox_base = ioremap(res[0].start, resource_size(&res[0]));
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
> -	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
> -	return ret;
> +	return 0;
>  }
>  
>  static int __devexit omap1_mbox_remove(struct platform_device *pdev)
>  {
> -	int i;
> -
> -	for (i = 0; list[i]; i++)
> -		omap_mbox_unregister(list[i]);
> -
> +	omap_mbox_unregister();
>  	iounmap(mbox_base);
>  	return 0;
>  }
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index a433ca7..66d366d 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -54,8 +54,6 @@
>  
>  static void __iomem *mbox_base;
>  
> -static struct omap_mbox **list;
> -
>  struct omap_mbox2_fifo {
>  	unsigned long msg;
>  	unsigned long fifo_stat;
> @@ -393,7 +391,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	int ret;
> -	int i;
> +	struct omap_mbox **list;
>  
>  	res = pdev->resource;
>  
> @@ -430,27 +428,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; list[i]; i++) {
> -		ret = omap_mbox_register(&pdev->dev, list[i]);
> -		if (ret)
> -			goto err_out;
> +	ret = omap_mbox_register(&pdev->dev, list);
> +	if (ret) {
> +		iounmap(mbox_base);
> +		return ret;
>  	}
>  	return 0;
>  
> -err_out:
> -	while (i--)
> -		omap_mbox_unregister(list[i]);
> -	iounmap(mbox_base);
>  	return ret;
>  }

The above result in:

    ....
	ret = omap_mbox_register(&pdev->dev, list);
	if (ret) {
		iounmap(mbox_base);
		return ret;
	}
	return 0;

	return ret;
}
