From: plaes@plaes.org (Priit Laes)
Date: Sun, 13 Sep 2015 19:26:53 +0300
Subject: [linux-sunxi] [PATCH] mtd: nand: sunxi: fix
 sunxi_nand_chips_cleanup()
In-Reply-To: <1442160883-29011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442160883-29011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1442161613.2857.9.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-09-13 at 18:14 +0200, Boris Brezillon wrote:
> The sunxi_nand_chips_cleanup() function is missing a call to
> list_del()
> which generates a double free error.

Tested-by: Priit Laes <plaes@plaes.org>
> 
> Reported-by: Priit Laes <plaes@plaes.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: <stable@vger.kernel.org> # 3.19+
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller
> support")
> ---
>  drivers/mtd/nand/sunxi_nand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c
> b/drivers/mtd/nand/sunxi_nand.c
> index f9b5a4c..0467917 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -1388,6 +1388,7 @@ static void sunxi_nand_chips_cleanup(struct
> sunxi_nfc *nfc)
>  					node);
>  		nand_release(&chip->mtd);
>  		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
> +		list_del(&chip->node);
>  	}
>  }
>  
> -- 
> 1.9.1
> 
