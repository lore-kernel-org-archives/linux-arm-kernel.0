From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Tue, 11 Oct 2011 15:16:17 +0400
Subject: [PATCH V2 4/4] ARM: at91/dma: DMA controller registering with
	DT support
In-Reply-To: <1318265021-4562-1-git-send-email-nicolas.ferre@atmel.com>
References: <e292fbb24a98b7cfda8ea83364956a50e1cb120f.1318264339.git.nicolas.ferre@atmel.com>
	<1318265021-4562-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4E942581.2050903@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-10-2011 20:43, Nicolas Ferre wrote:

> Device tree support on at91sam9g45 family SoC. Only call
> platform_device_register() if no compatible dma-controller
> node is found in device tree.

> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
> ---
> V2: use compatible string to match device.

[...]

> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 9390ae6..2120055 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -64,7 +64,13 @@ static struct platform_device at_hdmac_device = {
>
>   void __init at91_add_device_hdmac(void)
>   {
> -	platform_device_register(&at_hdmac_device);
> +	struct device_node *np = of_find_node_by_name(NULL, "dma-controller");
> +
> +	if (np&&  of_device_is_compatible(np, "atmel,at91sam9g45-dma")) {
> +		of_node_put(np);
> +	} else {
> +		platform_device_register(&at_hdmac_device);
> +	}

    {} not needed here, and checkpatch.pl should have protested.

WBR, Sergei
