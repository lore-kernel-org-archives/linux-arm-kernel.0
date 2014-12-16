From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 16 Dec 2014 10:57:10 +0100
Subject: [PATCH 3/4] mmc: sunxi: Reset behavior fix
In-Reply-To: <20141216003756.15488.34861.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
 <20141216003756.15488.34861.stgit@dizzy-6.o2s.ch>
Message-ID: <549001F6.5080202@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-12-14 01:37, David Lanzend?rfer wrote:
> When there is only one DES available the DMA performs a FIFO reset and waits until the reinitialization has been completed.
> Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from sending an interrupt after it has finished this reinitialization.
>
> The flags SDXC_IDMAC_DES0_FD and SDXC_IDMAC_DES0_LD are both required in order to use the controller with more than one DES.
>
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Reported-by: ?? <lixiang@allwinnertech.com>
> ---
>   drivers/mmc/host/sunxi-mmc.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 50bd3d2..5331c88 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -310,7 +310,17 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>   	}
>
>   	pdes[0].config |= SDXC_IDMAC_DES0_FD;
> -	pdes[i - 1].config = SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
> +
> +	/*
> +	 * When there is only one DES available the DMA performs a FIFO reset and waits
> +	 * until the reinitialization has been completed.
> +	 * Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from sending an interrupt
> +	 * after it has finished this reinitialization.
> +	 */
> +	pdes[i - 1].config = SDXC_IDMAC_DES0_OWN;
> +	pdes[i - 1].config |= SDXC_IDMAC_DES0_FD;
> +	pdes[i - 1].config |= SDXC_IDMAC_DES0_LD;
> +	pdes[i - 1].config &= ~SDXC_IDMAC_DES0_DIC;
>
>   	/*
>   	 * Avoid the io-store starting the idmac hitting io-mem before the

This is wrong. For one you are starting with an assignment, so you could just as well
set all the flags you want with a single line / assignment. Besides that you're setting
the FD flag, which should only be set for the first descriptor of a transfer, so for
multi descriptor transfers this is wrong.

Please see the patch which I send you which gets this right.

Regards,

Hans
