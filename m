From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 Mar 2014 09:56:50 +0100
Subject: [PATCH 04/62] ARM: at91: fix broken "if () else" statement
In-Reply-To: <1395257399-359545-5-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-5-git-send-email-arnd@arndb.de>
Message-ID: <532AAD52.9050400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2014 20:29, Arnd Bergmann :
> If CONFIG_PATA_AT91 is disabled, the code in at91_add_device_cf
> is turned into invalid C statements due to the lack of an
> expression before the 'else' clause.
> 
> This moves the first half of the condition inside of the #ifdef,
> which seems to be what the author intended.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/at91sam9260_devices.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 2ae7715..4222a7d 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -1263,13 +1263,13 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
>  	at91_set_A_periph(AT91_PIN_PC10, 0);    /* CFRNW */
>  	at91_set_A_periph(AT91_PIN_PC15, 1);    /* NWAIT */
>  
> -	if (data->flags & AT91_CF_TRUE_IDE)
>  #if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
> +	if (data->flags & AT91_CF_TRUE_IDE)
>  		pdev->name = "pata_at91";
> +	else
>  #else
>  #warning "board requires AT91_CF_TRUE_IDE: enable pata_at91"
>  #endif
> -	else
>  		pdev->name = "at91_cf";
>  
>  	platform_device_register(pdev);
> 


-- 
Nicolas Ferre
