From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 30 Mar 2017 12:00:27 +0200
Subject: [PATCH V1 1/1] mtd: mtk-nor: set controller to 4B mode with large
 capacity flash
In-Reply-To: <1490862222-723-2-git-send-email-guochun.mao@mediatek.com>
References: <1490862222-723-1-git-send-email-guochun.mao@mediatek.com>
 <1490862222-723-2-git-send-email-guochun.mao@mediatek.com>
Message-ID: <9d3a292b-8298-81ec-a049-b021616f1ddf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2017 10:23 AM, Guochun Mao wrote:
> when nor's size larger than 16MByte, nor and controller should
> enter 4Byte mode simultaneously.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> ---
>  drivers/mtd/spi-nor/mtk-quadspi.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> index e661877..05cd8a8 100644
> --- a/drivers/mtd/spi-nor/mtk-quadspi.c
> +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> @@ -369,6 +369,13 @@ static int mt8173_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
>  		/* We only handle 1 byte */
>  		ret = mt8173_nor_wr_sr(mt8173_nor, *buf);
>  		break;
> +	case SPINOR_OP_EN4B:
> +		/* Set nor controller to 4-byte address mode,
> +		 * and simultaneously set nor flash.
> +		 * This case should cooperate with default operation.
> +		 */
> +		writeb(readb(mt8173_nor->base + MTK_NOR_DUAL_REG) | 0x10,
> +				mt8173_nor->base + MTK_NOR_DUAL_REG);

And what happens on READ then ? Who clears that bit when protocol
changes ? You probably want something like cqspi_set_protocol()
instead, which is invoked from {read,write}{,_reg}() and erase().

>  	default:
>  		ret = mt8173_nor_do_tx_rx(mt8173_nor, opcode, buf, len, NULL, 0);
>  		if (ret)
> 


-- 
Best regards,
Marek Vasut
