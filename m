From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 25 Mar 2014 20:34:24 -0300
Subject: [PATCH] net: mvneta: use devm_ioremap_resource() instead of
 of_iomap()
In-Reply-To: <1395790015-20929-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395790015-20929-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140325233424.GA14158@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 26, Thomas Petazzoni wrote:
[..]
> @@ -2774,6 +2775,7 @@ static void mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
>  static int mvneta_probe(struct platform_device *pdev)
>  {
>  	const struct mbus_dram_target_info *dram_target_info;
> +	struct resource *res;
>  	struct device_node *dn = pdev->dev.of_node;
>  	struct device_node *phy_node;
>  	u32 phy_addr;
> @@ -2838,9 +2840,15 @@ static int mvneta_probe(struct platform_device *pdev)
>  
>  	clk_prepare_enable(pp->clk);
>  
> -	pp->base = of_iomap(dn, 0);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -ENODEV;
> +		goto err_clk;
> +	}
> +
> +	pp->base = devm_ioremap_resource(&pdev->dev, res);

When you use devm_ioremap_resource, you don't need to have error handling
in platform_get_resource. Take a look at the comment at lib/devres.c.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
