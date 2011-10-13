From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Oct 2011 18:35:22 -0600
Subject: [PATCH v3 4/4] ARM: at91/dma: DMA controller registering with DT
	support
In-Reply-To: <8d71a02275bc252b3841bf9f0e2e17a16df6deda.1318438197.git.nicolas.ferre@atmel.com>
References: <f91f267b82ac0f0459c11a7bdf3ab0ea8758656a.1318438197.git.nicolas.ferre@atmel.com>
	<8d71a02275bc252b3841bf9f0e2e17a16df6deda.1318438197.git.nicolas.ferre@atmel.com>
Message-ID: <20111013003522.GG14042@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 06:57:14PM +0200, Nicolas Ferre wrote:
> Device tree support on at91sam9g45 family SoC. Only call
> platform_device_register() if no dma-controller node is
> found in device tree.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index c9b897f..b9888c5 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -64,7 +64,13 @@ static struct platform_device at_hdmac_device = {
>  
>  void __init at91_add_device_hdmac(void)
>  {
> -	platform_device_register(&at_hdmac_device);
> +	struct device_node *of_node =
> +		of_find_node_by_name(NULL, "dma-controller");
> +
> +	if (of_node)
> +		of_node_put(of_node);
> +	else
> +		platform_device_register(&at_hdmac_device);
>  }
>  #else
>  void __init at91_add_device_hdmac(void) {}
> -- 
> 1.7.5.4
> 
