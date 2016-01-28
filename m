From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Jan 2016 11:15:53 +0000
Subject: [PATCH] mfd: db8500: avoid uninitialized variable reference
In-Reply-To: <1453737752-1960326-1-git-send-email-arnd@arndb.de>
References: <1453737752-1960326-1-git-send-email-arnd@arndb.de>
Message-ID: <20160128111553.GN3368@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2016, Arnd Bergmann wrote:

> The prcmu_config_clkout() function ensures that the 'clkout' argument
> can only be '0' or '1' using an appropriate BUG_ON(), so the compiler
> should know that the div_mask, mask, and bits variables are always
> initialized later on. However, it doesn't understand this in gcc-5.2
> and produces a false positive warning instead:
> 
> drivers/mfd/db8500-prcmu.c: In function 'prcmu_config_clkout':
> drivers/mfd/db8500-prcmu.c:762:10: error: 'div_mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   if (val & div_mask) {
>           ^
> drivers/mfd/db8500-prcmu.c:769:13: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     if ((val & mask & ~div_mask) != bits) {
>              ^
> drivers/mfd/db8500-prcmu.c:757:7: error: 'bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Replacing the switch() statement with an equivalent if() lets
> gcc figure this out reliably and avoids the warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/db8500-prcmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 12099b09a9a7..c0a86aeb1733 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -739,20 +739,17 @@ int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
>  	if (!div && !requests[clkout])
>  		return -EINVAL;
>  
> -	switch (clkout) {
> -	case 0:
> +	if (clkout == 0) {
>  		div_mask = PRCM_CLKOCR_CLKODIV0_MASK;
>  		mask = (PRCM_CLKOCR_CLKODIV0_MASK | PRCM_CLKOCR_CLKOSEL0_MASK);
>  		bits = ((source << PRCM_CLKOCR_CLKOSEL0_SHIFT) |
>  			(div << PRCM_CLKOCR_CLKODIV0_SHIFT));
> -		break;
> -	case 1:
> +	} else {
>  		div_mask = PRCM_CLKOCR_CLKODIV1_MASK;
>  		mask = (PRCM_CLKOCR_CLKODIV1_MASK | PRCM_CLKOCR_CLKOSEL1_MASK |
>  			PRCM_CLKOCR_CLK1TYPE);
>  		bits = ((source << PRCM_CLKOCR_CLKOSEL1_SHIFT) |
>  			(div << PRCM_CLKOCR_CLKODIV1_SHIFT));
> -		break;
>  	}
>  	bits &= mask;
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
