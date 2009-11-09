From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Nov 2009 13:05:58 -0800
Subject: [PATCH] arm: omap: Use resource_size
In-Reply-To: <1257788658-19824-1-git-send-email-tklauser@distanz.ch>
References: <1257788658-19824-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20091109210558.GD23952@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tobias Klauser <tklauser@distanz.ch> [091109 09:44]:
> Use the resource_size function instead of manually calculating the
> resource size. This reduces the chance of introducing off-by-one errors
> and actually fixes one in mailbox.c.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/gpmc.c    |    2 +-
>  arch/arm/mach-omap2/mailbox.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 004da69..67af370 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -366,7 +366,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>  	if (r < 0)
>  		goto out;
>  
> -	gpmc_cs_enable_mem(cs, res->start, res->end - res->start + 1);
> +	gpmc_cs_enable_mem(cs, res->start, resource_size(res));
>  	*base = res->start;
>  	gpmc_cs_set_reserved(cs, 1);
>  out:
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 46e1f2e..5ba3aa6 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -300,7 +300,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "invalid mem resource\n");
>  		return -ENODEV;
>  	}
> -	mbox_base = ioremap(res->start, res->end - res->start);
> +	mbox_base = ioremap(res->start, resource_size(res));
>  	if (!mbox_base)
>  		return -ENOMEM;
>  
> -- 
> 1.6.3.3
> 
