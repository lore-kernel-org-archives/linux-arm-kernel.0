From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 10 Jul 2018 09:53:24 +1000
Subject: [PATCH] gpio: aspeed: fix compile testing warning
In-Reply-To: <20180709145612.4166409-1-arnd@arndb.de>
References: <20180709145612.4166409-1-arnd@arndb.de>
Message-ID: <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-09 at 16:56 +0200, Arnd Bergmann wrote:
> Gcc cannot always see that BUG_ON(1) is guaranteed to not
> return, so we get a warning message in some configurations:
> 
> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> Using a plain BUG() is easier here and avoids the problem.
> 
> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Linus, can you plonk that on top of the patches in that topic branch
you created ?

> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 1e00f4045f9d..2342e154029b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
>  	case reg_cmdsrc1:
>  		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
>  	}
> -	BUG_ON(1);
> +	BUG();
>  }
>  
>  #define GPIO_BANK(x)	((x) >> 5)
