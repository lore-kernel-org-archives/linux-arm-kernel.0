From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Mar 2014 05:42:11 -0300
Subject: [PATCHv2] net: mvneta: use devm_ioremap_resource() instead of
 of_iomap()
In-Reply-To: <1395822600-30469-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395822600-30469-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140326084211.GA941@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mar 26, Thomas Petazzoni wrote:
> @@ -2838,9 +2840,10 @@ static int mvneta_probe(struct platform_device *pdev)
>  
>  	clk_prepare_enable(pp->clk);
>  
> -	pp->base = of_iomap(dn, 0);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pp->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (pp->base == NULL) {

As per the comment above devm_ioremap_resource() definition, the usage is:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	base = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(base))
		return PTR_ERR(base);

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
