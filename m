From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 16:37:20 +0200
Subject: [PATCH 2/4] ARM: mvebu/orion: remove NO_IRQ check from device init
In-Reply-To: <20160906140623.2853066-2-arnd@arndb.de> (Arnd Bergmann's message
 of "Tue, 6 Sep 2016 16:06:21 +0200")
References: <20160906140623.2853066-1-arnd@arndb.de>
 <20160906140623.2853066-2-arnd@arndb.de>
Message-ID: <87oa3qbl9b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., sept. 06 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> For most devices, we know in advance whether they have an
> interrupt line or not, so we can avoid passing NO_IRQ and
> instead split fill_resources() into two interfaces, with
> only the new fill_resources_irq() function taking an irq
> argument, which it then can use unconditionally.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied on mvebu/soc

Thanks,

Gregory
> ---
>  arch/arm/plat-orion/common.c | 52 ++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index 7757f71fe709..7b9b70785a54 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -52,21 +52,27 @@ void __init orion_clkdev_init(struct clk *tclk)
>  static void fill_resources(struct platform_device *device,
>  			   struct resource *resources,
>  			   resource_size_t mapbase,
> -			   resource_size_t size,
> -			   unsigned int irq)
> +			   resource_size_t size)
>  {
>  	device->resource = resources;
>  	device->num_resources = 1;
>  	resources[0].flags = IORESOURCE_MEM;
>  	resources[0].start = mapbase;
>  	resources[0].end = mapbase + size;
> +}
>  
> -	if (irq != NO_IRQ) {
> -		device->num_resources++;
> -		resources[1].flags = IORESOURCE_IRQ;
> -		resources[1].start = irq;
> -		resources[1].end = irq;
> -	}
> +static void fill_resources_irq(struct platform_device *device,
> +			       struct resource *resources,
> +			       resource_size_t mapbase,
> +			       resource_size_t size,
> +			       unsigned int irq)
> +{
> +	fill_resources(device, resources, mapbase, size);
> +
> +	device->num_resources++;
> +	resources[1].flags = IORESOURCE_IRQ;
> +	resources[1].start = irq;
> +	resources[1].end = irq;
>  }
>  
>  /*****************************************************************************
> @@ -93,7 +99,7 @@ static void __init uart_complete(
>  	data->uartclk = uart_get_clk_rate(clk);
>  	orion_uart->dev.platform_data = data;
>  
> -	fill_resources(orion_uart, resources, mapbase, 0xff, irq);
> +	fill_resources_irq(orion_uart, resources, mapbase, 0xff, irq);
>  	platform_device_register(orion_uart);
>  }
>  
> @@ -305,8 +311,8 @@ void __init orion_ge00_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned int tx_csum_limit)
>  {
>  	fill_resources(&orion_ge00_shared, orion_ge00_shared_resources,
> -		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> -	fill_resources(&orion_ge_mvmdio, orion_ge_mvmdio_resources,
> +		       mapbase + 0x2000, SZ_16K - 1);
> +	fill_resources_irq(&orion_ge_mvmdio, orion_ge_mvmdio_resources,
>  			mapbase + 0x2004, 0x84 - 1, irq_err);
>  	orion_ge00_shared_data.tx_csum_limit = tx_csum_limit;
>  	ge_complete(&orion_ge00_shared_data,
> @@ -357,7 +363,7 @@ void __init orion_ge01_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned int tx_csum_limit)
>  {
>  	fill_resources(&orion_ge01_shared, orion_ge01_shared_resources,
> -		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> +		       mapbase + 0x2000, SZ_16K - 1);
>  	orion_ge01_shared_data.tx_csum_limit = tx_csum_limit;
>  	ge_complete(&orion_ge01_shared_data,
>  		    orion_ge01_resources, irq, &orion_ge01_shared,
> @@ -406,7 +412,7 @@ void __init orion_ge10_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long irq)
>  {
>  	fill_resources(&orion_ge10_shared, orion_ge10_shared_resources,
> -		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> +		       mapbase + 0x2000, SZ_16K - 1);
>  	ge_complete(&orion_ge10_shared_data,
>  		    orion_ge10_resources, irq, &orion_ge10_shared,
>  		    NULL,
> @@ -454,7 +460,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
>  			    unsigned long irq)
>  {
>  	fill_resources(&orion_ge11_shared, orion_ge11_shared_resources,
> -		       mapbase + 0x2000, SZ_16K - 1, NO_IRQ);
> +		       mapbase + 0x2000, SZ_16K - 1);
>  	ge_complete(&orion_ge11_shared_data,
>  		    orion_ge11_resources, irq, &orion_ge11_shared,
>  		    NULL,
> @@ -535,7 +541,7 @@ void __init orion_i2c_init(unsigned long mapbase,
>  			   unsigned long freq_m)
>  {
>  	orion_i2c_pdata.freq_m = freq_m;
> -	fill_resources(&orion_i2c, orion_i2c_resources, mapbase,
> +	fill_resources_irq(&orion_i2c, orion_i2c_resources, mapbase,
>  		       SZ_32 - 1, irq);
>  	platform_device_register(&orion_i2c);
>  }
> @@ -545,7 +551,7 @@ void __init orion_i2c_1_init(unsigned long mapbase,
>  			     unsigned long freq_m)
>  {
>  	orion_i2c_1_pdata.freq_m = freq_m;
> -	fill_resources(&orion_i2c_1, orion_i2c_1_resources, mapbase,
> +	fill_resources_irq(&orion_i2c_1, orion_i2c_1_resources, mapbase,
>  		       SZ_32 - 1, irq);
>  	platform_device_register(&orion_i2c_1);
>  }
> @@ -573,14 +579,14 @@ static struct platform_device orion_spi_1 = {
>  void __init orion_spi_init(unsigned long mapbase)
>  {
>  	fill_resources(&orion_spi, &orion_spi_resources,
> -		       mapbase, SZ_512 - 1, NO_IRQ);
> +		       mapbase, SZ_512 - 1);
>  	platform_device_register(&orion_spi);
>  }
>  
>  void __init orion_spi_1_init(unsigned long mapbase)
>  {
>  	fill_resources(&orion_spi_1, &orion_spi_1_resources,
> -		       mapbase, SZ_512 - 1, NO_IRQ);
> +		       mapbase, SZ_512 - 1);
>  	platform_device_register(&orion_spi_1);
>  }
>  
> @@ -738,7 +744,7 @@ void __init orion_ehci_init(unsigned long mapbase,
>  			    enum orion_ehci_phy_ver phy_version)
>  {
>  	orion_ehci_data.phy_version = phy_version;
> -	fill_resources(&orion_ehci, orion_ehci_resources, mapbase, SZ_4K - 1,
> +	fill_resources_irq(&orion_ehci, orion_ehci_resources, mapbase, SZ_4K - 1,
>  		       irq);
>  
>  	platform_device_register(&orion_ehci);
> @@ -762,7 +768,7 @@ static struct platform_device orion_ehci_1 = {
>  void __init orion_ehci_1_init(unsigned long mapbase,
>  			      unsigned long irq)
>  {
> -	fill_resources(&orion_ehci_1, orion_ehci_1_resources,
> +	fill_resources_irq(&orion_ehci_1, orion_ehci_1_resources,
>  		       mapbase, SZ_4K - 1, irq);
>  
>  	platform_device_register(&orion_ehci_1);
> @@ -786,7 +792,7 @@ static struct platform_device orion_ehci_2 = {
>  void __init orion_ehci_2_init(unsigned long mapbase,
>  			      unsigned long irq)
>  {
> -	fill_resources(&orion_ehci_2, orion_ehci_2_resources,
> +	fill_resources_irq(&orion_ehci_2, orion_ehci_2_resources,
>  		       mapbase, SZ_4K - 1, irq);
>  
>  	platform_device_register(&orion_ehci_2);
> @@ -816,7 +822,7 @@ void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
>  			    unsigned long irq)
>  {
>  	orion_sata.dev.platform_data = sata_data;
> -	fill_resources(&orion_sata, orion_sata_resources,
> +	fill_resources_irq(&orion_sata, orion_sata_resources,
>  		       mapbase, 0x5000 - 1, irq);
>  
>  	platform_device_register(&orion_sata);
> @@ -846,7 +852,7 @@ void __init orion_crypto_init(unsigned long mapbase,
>  			      unsigned long sram_size,
>  			      unsigned long irq)
>  {
> -	fill_resources(&orion_crypto, orion_crypto_resources,
> +	fill_resources_irq(&orion_crypto, orion_crypto_resources,
>  		       mapbase, 0xffff, irq);
>  	orion_crypto.num_resources = 3;
>  	orion_crypto_resources[2].start = srambase;
> -- 
> 2.9.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
