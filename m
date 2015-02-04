From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 4 Feb 2015 11:10:28 +0100
Subject: [PATCH v2 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150204111028.2f0bd376@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 26 Jan 2015 15:56:03 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> The NDDB register holds the data that are needed by the read and write
> commands.
> 
> However, during a read PIO access, the datasheet specifies that after each 32
> bits read in that register, when BCH is enabled, we have to make sure that the
> RDDREQ bit is set in the NDSR register.
> 
> This fixes an issue that was seen on the Armada 385, and presumably other mvebu
> SoCs, when a read on a newly erased page would end up in the driver reporting a
> timeout from the NAND.
> 
> Cc: <stable@vger.kernel.org> # v3.14
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 45 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 96b0b1d27df1..e6918befb951 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -23,6 +23,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/jiffies.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -480,6 +481,38 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
>  	nand_writel(info, NDCR, ndcr | int_mask);
>  }
>  
> +static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
> +{
> +	u32 *dst = (u32 *)data;
> +
> +	if (info->ecc_bch) {
> +		while (len--) {
> +			u32 timeout;
> +
> +			*dst++ = nand_readl(info, NDDB);
> +
> +			/*
> +			 * According to the datasheet, when reading
> +			 * from NDDB with BCH enabled, after each 32
> +			 * bits reads, we have to make sure that the
> +			 * NDSR.RDDREQ bit is set
> +			 */

I know the datasheet says this bit should be checked after each
transfer, but I wonder if we shouldn't check it before reading the data.
What happens if you drain all the data available in the FIFO ? Is the
controller still setting the RDDREQ bit ?

Moreover, the datasheet says this RDDREQ bit should be checked after
each 32 bytes (not 32 bits) transfer.
Testing it after each readl call shouldn't hurt though.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
