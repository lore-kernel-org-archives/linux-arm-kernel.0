From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 27 Sep 2018 06:33:53 +0800
Subject: [PATCH] pinctrl: mediatek: mark dummy helpers as 'static inline'
In-Reply-To: <20180926193818.2481220-1-arnd@arndb.de>
References: <20180926193818.2481220-1-arnd@arndb.de>
Message-ID: <1538001233.30348.20.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-09-26 at 21:38 +0200, Arnd Bergmann wrote:
> mtk_eint_set_debounce and mtk_eint_find_irq are defined as stub functions
> in a header file, but without marking them as 'static inline', we get
> a copy for each file that includes the header:
> 
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_set_debounce':
> pinctrl-mtk-common-v2.c:(.text+0x134): multiple definition of `mtk_eint_set_debounce'
> drivers/pinctrl/mediatek/pinctrl-moore.o:pinctrl-moore.c:(.text+0x7d0): first defined here
> drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: In function `mtk_eint_find_irq':
> pinctrl-mtk-common-v2.c:(.text+0x13c): multiple definition of `mtk_eint_find_irq'
> 
> Fixes: e46df235b4e6 ("pinctrl: mediatek: refactor EINT related code for all MediaTek pinctrl can fit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Thank for the fixes for that I miss to mark the two functions as 'static
inline'. The other functions in the same header file seem fine.

Acked-by: Sean Wang <sean.wang@mediatek.com>

> ---
>  drivers/pinctrl/mediatek/mtk-eint.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> index c286a9b940f2..48468d0fae68 100644
> --- a/drivers/pinctrl/mediatek/mtk-eint.h
> +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> @@ -92,13 +92,13 @@ static inline int mtk_eint_do_resume(struct mtk_eint *eint)
>  	return -EOPNOTSUPP;
>  }
>  
> -int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
> +static inline int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
>  			  unsigned int debounce)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
> +static inline int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
>  {
>  	return -EOPNOTSUPP;
>  }
