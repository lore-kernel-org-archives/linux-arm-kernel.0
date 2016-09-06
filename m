From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 15:14:32 +0100
Subject: [PATCH 1/4] ARM: common/sa1111: remove NO_IRQ check
In-Reply-To: <20160906135637.2622666-1-arnd@arndb.de>
References: <20160906135637.2622666-1-arnd@arndb.de>
Message-ID: <20160906141432.GW1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please check other patches previously sent - these conflict with the
patch series I sent last week.  This use is already gone.

On Tue, Sep 06, 2016 at 03:53:27PM +0200, Arnd Bergmann wrote:
> Since commit 489447380a29 ("[PATCH] handle errors returned by
> platform_get_irq*()") ten years ago, the sa1111 driver refuses to
> work without an interrupt line passed in its resources, so the
> check for NO_IRQ is unnecessary.
> 
> I have also checked that all four machines files that register
> an sa1111 device (lubbock, badge4, journada720, and neponset)
> do set an interrupt line.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/common/sa1111.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index fb0a0a4dfea4..64d8cf08b7d0 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -751,11 +751,9 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
>  	 * The interrupt controller must be initialised before any
>  	 * other device to ensure that the interrupts are available.
>  	 */
> -	if (sachip->irq != NO_IRQ) {
> -		ret = sa1111_setup_irq(sachip, pd->irq_base);
> -		if (ret)
> -			goto err_unmap;
> -	}
> +	ret = sa1111_setup_irq(sachip, pd->irq_base);
> +	if (ret)
> +		goto err_unmap;
>  
>  #ifdef CONFIG_ARCH_SA1100
>  	{
> @@ -834,12 +832,10 @@ static void __sa1111_remove(struct sa1111 *sachip)
>  	clk_disable(sachip->clk);
>  	clk_unprepare(sachip->clk);
>  
> -	if (sachip->irq != NO_IRQ) {
> -		irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
> -		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
> +	irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
> +	irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
>  
> -		release_mem_region(sachip->phys + SA1111_INTC, 512);
> -	}
> +	release_mem_region(sachip->phys + SA1111_INTC, 512);
>  
>  	iounmap(sachip->base);
>  	clk_put(sachip->clk);
> -- 
> 2.9.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
