From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Tue, 28 Aug 2012 15:14:58 +0200
Subject: [PATCH 2/2] mmc: atmel-mci: AP700x PDC is not connected to MCI
In-Reply-To: <503A856A.9020303@yahoo.es>
References: <503A856A.9020303@yahoo.es>
Message-ID: <503CC452.7090607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hein,

Le 08/26/2012 10:22 PM, Hein Tibosch a ?crit :
> Earlier, atmel-mci was adapter to make use of the peripheral DMA
> controller (PDC), in case normal DMA wouldn't work.
> ( http://comments.gmane.org/gmane.linux.kernel.mmc/9403 )
> This works OK on ARM platforms (AT91), but it broke the driver
> for AVR32, the AP700x.
> This patch makes the use of PDC depend on CONFIG_AVR32

I think you should explain explicitly that even if the MCI has PDC 
support, the connection is not done for AVR chips.

Otherwise you can add

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks for the patch.

Regards

Ludovic

>
> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
>
> ---
>   drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
>   drivers/mmc/host/atmel-mci.c      |    2 +-
>   2 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index ab56f7d..c97001e 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -140,6 +140,13 @@
>   #define atmci_writel(port,reg,value)			\
>   	__raw_writel((value), (port)->regs + reg)
>
> +/* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
> +#ifdef CONFIG_AVR32
> +#	define ATMCI_PDC_CONNECTED	0
> +#else
> +#	define ATMCI_PDC_CONNECTED	1
> +#endif
> +
>   /*
>    * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
>    * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 66e9fdc..702ab5c 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2205,7 +2205,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>   			"version: 0x%x\n", version);
>
>   	host->caps.has_dma_conf_reg = 0;
> -	host->caps.has_pdc = 1;
> +	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
>   	host->caps.has_cfg_reg = 0;
>   	host->caps.has_cstor_reg = 0;
>   	host->caps.has_highspeed = 0;
>
