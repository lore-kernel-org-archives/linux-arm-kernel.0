From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 30 Apr 2014 09:20:47 +0530
Subject: [PATCH 04/15] ASoC: samsung-idma: avoid 64-bit division
In-Reply-To: <1398770316-19715-5-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-5-git-send-email-kaixu.xia@linaro.org>
Message-ID: <53607317.4040206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 04:48 PM, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dma_addr_t may be 64 bit wide, which causes a build failure
> when doing a division on it. Here it is safe to cast to an
> u32 type, which avoids the problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: alsa-devel at alsa-project.org
> ---

Tested with ARM_LPAE enabled. Without this patch, getting following error.

sound/built-in.o: In function `iis_irq':
sound/soc/samsung/idma.c:277: undefined reference to `__aeabi_uldivmod'

Tested-by: Tushar Behera <tushar.behera@linaro.org>

>  sound/soc/samsung/idma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
> index 3d5cf15..e9891b4 100644
> --- a/sound/soc/samsung/idma.c
> +++ b/sound/soc/samsung/idma.c
> @@ -274,7 +274,7 @@ static irqreturn_t iis_irq(int irqno, void *dev_id)
>  
>  		addr = readl(idma.regs + I2SLVL0ADDR) - idma.lp_tx_addr;
>  		addr += prtd->periodsz;
> -		addr %= (prtd->end - prtd->start);
> +		addr %= (u32)(prtd->end - prtd->start);
>  		addr += idma.lp_tx_addr;
>  
>  		writel(addr, idma.regs + I2SLVL0ADDR);
> 


-- 
Tushar Behera
