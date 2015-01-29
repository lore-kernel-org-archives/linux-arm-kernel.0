From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jan 2015 17:01:04 +0000
Subject: [PATCH] mmc: moxart: fix probe logic
In-Reply-To: <8340872.32GezMfzR1@wuerfel>
References: <8340872.32GezMfzR1@wuerfel>
Message-ID: <20150129170104.GD26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 05:15:31PM +0100, Arnd Bergmann wrote:
> @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> -	clk = of_clk_get(node, 0);
> -	if (IS_ERR(clk)) {
> +	host->clk = of_clk_get(node, 0);
> +	if (IS_ERR(host->clk)) {
>  		dev_err(dev, "of_clk_get failed\n");
> -		ret = PTR_ERR(clk);
> +		ret = PTR_ERR(host->clk);
>  		goto out;
>  	}
>  
...
> @@ -677,6 +679,8 @@ static int moxart_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out:
> +	if (host->clk)
> +		clk_put(host->clk);

Are you sure?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
