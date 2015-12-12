From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 11 Dec 2015 17:10:56 -0800
Subject: [PATCH] mtd: omap_elm: print interrupt resource using %pr
In-Reply-To: <2101351.RbJOfbsbGX@wuerfel>
References: <2101351.RbJOfbsbGX@wuerfel>
Message-ID: <20151212011056.GA144873@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Dec 08, 2015 at 04:39:45PM +0100, Arnd Bergmann wrote:
> When CONFIG_LPAE is set on ARM, resource_size_t is 64-bit wide
> and we get a warning about an incorrect format string for printing
> the interrupt number in elm_probe:
> 
> drivers/mtd/nand/omap_elm.c: In function 'elm_probe':
> drivers/mtd/nand/omap_elm.c:417:23: warning: format '%i' expects argument of type 'int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> 
> This patch avoids the type mismatch by printing the interrupt as
> a resource using the %pr format string.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/nand/omap_elm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
> index 235ec7992b4c..11f174b07217 100644
> --- a/drivers/mtd/nand/omap_elm.c
> +++ b/drivers/mtd/nand/omap_elm.c
> @@ -414,7 +414,7 @@ static int elm_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
>  			pdev->name, info);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failure requesting irq %i\n", irq->start);
> +		dev_err(&pdev->dev, "failure requesting %pr\n", &irq);

drivers/mtd/nand/omap_elm.c:417 elm_probe() error: '%pr' expects argument of type struct resource *, but argument 3 has type 'struct resource**' [smatch]

>  		return ret;
>  	}
>  

Brian
