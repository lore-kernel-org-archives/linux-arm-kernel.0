From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 18 Dec 2015 14:17:58 -0800
Subject: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
In-Reply-To: <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151218221758.GQ10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, Dec 10, 2015 at 09:00:39AM +0100, Boris Brezillon wrote:
> Add two helpers to access the field reserved for private controller data.
> This makes it clearer what this field is reserved for and ease future
> refactoring.

I agree with the refactoring part, but I'm not sure about the name. Is
it really "controller" data? That sounds like something that has 1
instance per controller. But the way this is sometimes used, we get 1
instance per NAND chip, and there may be more than one NAND chip per
controller.

So at the moment, this is more like opaque "driver data", like
dev_{get,set}_drvdata(), which doesn't really have a prescribed use --
it's up to the driver.

Notably, we already have a (sort of) 1-per-controler-instance field:
struct nand_hw_control (I notice we have both the 'controller' and
'hwcontrol' fields in nand_chip; that's pretty ugly too...). Those don't
have private data fields, but we could of course extend that if we
really want "controller" data.

Anyway, I don't feel like this question is resolved well enough to say
that we should go change all drivers to use these accessors. I know you
have bigger plans for putting more "controller" infrastructure into the
core drivers/mtd/nand/ code, so I'd like to see how that fits in here.

(If we're going to discuss this much more, I'd suggest a smaller CC
list. I'm mostly putting this here to show why I'm not taking the last
4 patches right now.)

Regards,
Brian

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/mtd/nand.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 2bee2e4..4aed4b2 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -739,6 +739,16 @@ static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
>  	return &chip->mtd;
>  }
>  
> +static inline void *nand_get_controller_data(struct nand_chip *chip)
> +{
> +	return chip->priv;
> +}
> +
> +static inline void nand_set_controller_data(struct nand_chip *chip, void *priv)
> +{
> +	chip->priv = priv;
> +}
> +
>  /*
>   * NAND Flash Manufacturer ID Codes
>   */
> -- 
> 2.1.4
> 
