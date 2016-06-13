From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 13 Jun 2016 22:06:25 +0200
Subject: [PATCH -next] mtd: nand: sunxi: fix return value check in
 sunxi_nfc_dma_op_prepare()
In-Reply-To: <1465828038-16893-1-git-send-email-weiyj_lk@163.com>
References: <1465828038-16893-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160613220625.020d01bd@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2016 14:27:18 +0000
weiyj_lk at 163.com wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function dmaengine_prep_slave_sg() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/nand/sunxi_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index ef7f6df..653cb3a 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -390,8 +390,8 @@ static int sunxi_nfc_dma_op_prepare(struct mtd_info *mtd, const void *buf,
>  		return -ENOMEM;
>  
>  	dmad = dmaengine_prep_slave_sg(nfc->dmac, sg, 1, tdir, DMA_CTRL_ACK);
> -	if (IS_ERR(dmad)) {
> -		ret = PTR_ERR(dmad);
> +	if (!dmad) {
> +		ret = -EINVAL;
>  		goto err_unmap_buf;
>  	}
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
