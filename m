From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 19 Nov 2015 11:19:24 -0800
Subject: [PATCH 02/27] mtd: nand: add an mtd_to_nand() helper
In-Reply-To: <1447681080-31232-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151119191924.GF64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 02:37:35PM +0100, Boris Brezillon wrote:
> Some drivers are retrieving the nand_chip pointer using the container_of
> macro on a struct wrapping both the nand_chip and the mtd_info struct while
> the standard way of retrieving this pointer is through mtd->priv.
> Provide an helper to do that.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/mtd/nand.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 4f7c9b9..056d165 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -730,6 +730,11 @@ static inline struct device_node *nand_get_flash_node(struct nand_chip *chip)
>  	return chip->flash_node;
>  }
>  
> +static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
> +{
> +	return mtd->priv;
> +}
> +

Pushed this patch to l2-mtd.git, though I rebased it directly onto
4.4-rc1 and then merged it in. That way, if any other subsystems want to
start using this in the 4.5 -next cycle (e.g., for patches 4-8), they
can pull it in without taking the rest of MTD.

I can push this to a separate branch or signed tag, if anyone wants.

Or, I can take the arch/ patches via MTD, if that's a better option.

Brian
