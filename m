From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 4 Mar 2015 15:22:54 +0800
Subject: [PATCH v2] mtd: atmel_nand: check NFC busy flag by HSMC_SR instead
 of NFC cmd regs
In-Reply-To: <1421922090-8803-1-git-send-email-josh.wu@atmel.com>
References: <1421922090-8803-1-git-send-email-josh.wu@atmel.com>
Message-ID: <54F6B2CE.9020604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Brain

Would you have any chance to take this patch as it's been a long time?

Best Regards,
Josh Wu

On 1/22/2015 6:21 PM, Josh Wu wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> Currently the driver read NFC command registers to get NFC busy flag.
> Actually this flag also can be get by reading HSMC_SR register.
>
> Use the read NFC command registers need mapping a huge memory region.
> To save the mapped memory region, we change to check NFC busy flag by
> reading HSMC_SR register.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>
> Changes in v2:
> - Change me to signed-off-by.
> - modify the error log.
>
>   drivers/mtd/nand/atmel_nand.c     | 5 ++---
>   drivers/mtd/nand/atmel_nand_nfc.h | 1 +
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index d93c849..336cc2d 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -1752,11 +1752,10 @@ static int nfc_send_command(struct atmel_nand_host *host,
>   		cmd, addr, cycle0);
>   
>   	timeout = jiffies + msecs_to_jiffies(NFC_TIME_OUT_MS);
> -	while (nfc_cmd_readl(NFCADDR_CMD_NFCBUSY, host->nfc->base_cmd_regs)
> -			& NFCADDR_CMD_NFCBUSY) {
> +	while (nfc_readl(host->nfc->hsmc_regs, SR) & NFC_SR_BUSY) {
>   		if (time_after(jiffies, timeout)) {
>   			dev_err(host->dev,
> -				"Time out to wait CMD_NFCBUSY ready!\n");
> +				"Time out to wait for NFC ready!\n");
>   			return -ETIMEDOUT;
>   		}
>   	}
> diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
> index 85b8ca6..4d5d262 100644
> --- a/drivers/mtd/nand/atmel_nand_nfc.h
> +++ b/drivers/mtd/nand/atmel_nand_nfc.h
> @@ -35,6 +35,7 @@
>   #define		NFC_CTRL_DISABLE	(1 << 1)
>   
>   #define ATMEL_HSMC_NFC_SR	0x08		/* NFC Status Register */
> +#define		NFC_SR_BUSY		(1 << 8)
>   #define		NFC_SR_XFR_DONE		(1 << 16)
>   #define		NFC_SR_CMD_DONE		(1 << 17)
>   #define		NFC_SR_DTOE		(1 << 20)
