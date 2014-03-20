From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 20 Mar 2014 21:16:59 +0800
Subject: [PATCH 04/62] ARM: at91: fix broken "if () else" statement
In-Reply-To: <1395257399-359545-5-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-5-git-send-email-arnd@arndb.de>
Message-ID: <1446105B-3033-4799-A697-C70748DC90C5@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 20, 2014, at 3:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> 
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
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
> arch/arm/mach-at91/at91sam9260_devices.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 2ae7715..4222a7d 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -1263,13 +1263,13 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
> 	at91_set_A_periph(AT91_PIN_PC10, 0);    /* CFRNW */
> 	at91_set_A_periph(AT91_PIN_PC15, 1);    /* NWAIT */
> 
> -	if (data->flags & AT91_CF_TRUE_IDE)
> #if defined(CONFIG_PATA_AT91) || defined(CONFIG_PATA_AT91_MODULE)
> +	if (data->flags & AT91_CF_TRUE_IDE)
I prefer if (IS_ENABLED())
> 		pdev->name = "pata_at91";
> +	else
> #else
> #warning "board requires AT91_CF_TRUE_IDE: enable pata_at91?
but this means drop this warning
> #endif
> -	else
> 		pdev->name = "at91_cf";
> 
> 	platform_device_register(pdev);
> -- 
> 1.8.3.2
> 
