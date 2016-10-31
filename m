From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 16:20:27 +0000
Subject: [PATCH] ARM: zx: Fix error handling
In-Reply-To: <20161030081010.14735-1-christophe.jaillet@wanadoo.fr>
References: <20161030081010.14735-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161031162027.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Same as the other fix...

On Sun, Oct 30, 2016 at 09:10:10AM +0100, Christophe JAILLET wrote:
> 'devm_ioremap_resource()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> 'return -EIO;' could also be turned into 'return PTR_ERR(pcubase);' in
> order to propagate the error value.
> ---
>  arch/arm/mach-zx/zx296702-pm-domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
> index e08574d4e2ca..79dcf2549267 100644
> --- a/arch/arm/mach-zx/zx296702-pm-domain.c
> +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> @@ -169,7 +169,7 @@ static int zx296702_pd_probe(struct platform_device *pdev)
>  	}
>  
>  	pcubase = devm_ioremap_resource(&pdev->dev, res);
> -	if (!pcubase) {
> +	if (IS_ERR(pcubase)) {
>  		dev_err(&pdev->dev, "ioremap fail.\n");
>  		return -EIO;
>  	}
> -- 
> 2.9.3
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
