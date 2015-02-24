From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 24 Feb 2015 14:53:34 -0400
Subject: [PATCH 1/2] thermal: exynos: Fix wrong control of power down
 detection mode for Exynos7
In-Reply-To: <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
 <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20150224185333.GF3448@developer.amazonguestwifi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 01:56:54PM +0900, Chanwoo Choi wrote:
> This patch fixes the wrong control of PD_DET_EN (power down detection mode)
> for Exynos7 because exynos7_tmu_control() always enables the power down detection
> mode regardless 'on' parameter.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Lukasz,

Any objections to this code?

BR,

Eduardo Valentin

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 933cd80..a60f527 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>  
>  	if (on) {
>  		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
>  		interrupt_en =
>  			(of_thermal_is_trip_valid(tz, 7)
>  			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
> @@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>  			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>  	} else {
>  		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
>  		interrupt_en = 0; /* Disable all interrupts */
>  	}
> -	con |= 1 << EXYNOS7_PD_DET_EN_SHIFT;
>  
>  	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
>  	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> -- 
> 1.8.5.5
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/bb0c2606/attachment.sig>
