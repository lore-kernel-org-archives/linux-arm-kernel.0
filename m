From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 12 Feb 2016 11:12:43 -0800
Subject: [PATCH] mtd: map: fix .set_vpp() documentation
In-Reply-To: <1454364168-1342-1-git-send-email-linus.walleij@linaro.org>
References: <1454364168-1342-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160212191243.GB21465@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 11:02:48PM +0100, Linus Walleij wrote:
> As of commit 876fe76d793d03077eb61ba3afab4a383f46c554
> "mtd: maps: physmap: Add reference counter to set_vpp()"
> the comment in the header file is incorrect and misleading.
> Fix it up.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Fixes: 876fe76d793d ("mtd: maps: physmap: Add reference counter to set_vpp()")

^^ Let's watch the non-gregkh stable maintainers pick up this patch just
because of this (undocumented in Documentation/stable_kernel_rules.txt)
tag :)

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/mtd/map.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index 58f3ba709ade..5e0eb7ccabd4 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -240,8 +240,11 @@ struct map_info {
>  	   If there is no cache to care about this can be set to NULL. */
>  	void (*inval_cache)(struct map_info *, unsigned long, ssize_t);
>  
> -	/* set_vpp() must handle being reentered -- enable, enable, disable
> -	   must leave it enabled. */
> +	/* This will be called with 1 as parameter when the first map user
> +	 * needs VPP, and called with 0 when the last user exits. The map
> +	 * core maintains a reference counter, and assumes that VPP is a
> +	 * global resource applying to all mapped flash chips on the system.
> +	 */
>  	void (*set_vpp)(struct map_info *, int);
>  
>  	unsigned long pfow_base;

Looks good, thanks. Applied to l2-mtd.git
