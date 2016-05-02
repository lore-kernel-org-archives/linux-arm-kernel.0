From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 May 2016 14:22:04 -0700
Subject: [PATCH] drm/fsl-dcu: add COMMON_CLK dependency
In-Reply-To: <1462186839-2224021-1-git-send-email-arnd@arndb.de>
References: <1462186839-2224021-1-git-send-email-arnd@arndb.de>
Message-ID: <96882621acf64dca8d6c1d2f25307385@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-05-02 04:00, Arnd Bergmann wrote:
> The fsl dcu now uses the clk-provider interfaces, which are not available
> when CONFIG_COMMON_CLK is disabled:
> 
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c: In function 'fsl_dcu_drm_probe':
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:362:20: error: implicit
> declaration of function '__clk_get_name'
> [-Werror=implicit-function-declaration]
>   pix_clk_in_name = __clk_get_name(pix_clk_in);
> 
> This adds a Kconfig dependency to prevent the driver from being enabled
> in this case.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2d701449bce1 ("drm/fsl-dcu: use common clock framework for
> pixel clock divider")

Oh right, thx!

Acked-by: Stefan Agner <stefan@agner.ch>

@Dave, can you pick that up directly or do you prefer a pull request?

--
Stefan

> ---
>  drivers/gpu/drm/fsl-dcu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index c78cf3f605d0..b9c714de6e40 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_FSL_DCU
>  	tristate "DRM Support for Freescale DCU"
> -	depends on DRM && OF && ARM
> +	depends on DRM && OF && ARM && COMMON_CLK
>  	select BACKLIGHT_CLASS_DEVICE
>  	select BACKLIGHT_LCD_SUPPORT
>  	select DRM_KMS_HELPER
