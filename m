From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 18:25:26 -0800
Subject: [PATCH v3 33/36] mtd: st_spi_fsm: Supply the MX25xxx chip
 specific configuration call-back
In-Reply-To: <1385727565-25794-34-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-34-git-send-email-lee.jones@linaro.org>
Message-ID: <20131211022526.GO27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:19:22PM +0000, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 84 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/devices/st_spi_fsm.h |  4 +-
>  2 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index f1276e5..be66a49 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -620,6 +645,65 @@ static int stfsm_prepare_rwe_seqs_default(struct stfsm *fsm)
>  	return 0;
>  }
>  
> +static int stfsm_mx25_config(struct stfsm *fsm)
> +{
> +	uint32_t flags = fsm->info->flags;
> +	uint32_t data_pads;
> +	uint8_t sta;
> +	int ret;
> +	bool soc_reset;
> +
> +	/* Disable support for 'WRITE_1_4_4' (limited to 20MHz which is of
> +	 * marginal benefit on our hardware and doesn't justify implementing
> +	 * different READ/WRITE frequencies).
> +	 */
> +	flags &= ~FLASH_FLAG_WRITE_1_4_4;

Huh? flags is a local variable, and you only use it for checking 32-bit
addressing mode in this function. So this flags modification is
effectively thrown away. Perhaps you meant

	fsm->info->flags &= ~FLASH_FLAG_WRITE_1_4_4;

? But then you're back to modifying static data (the device table)
through a per-instance reference. That's not good behavior. Rather,
couldn't you just remove this flag from the table entry in the first
place?

Brian
