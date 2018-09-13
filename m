From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Sep 2018 14:30:17 +0200
Subject: [PATCH v3 5/5] drm/bridge: add preliminary driver for cadence
 dpi/dp bridge
In-Reply-To: <1535451894-2518-6-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <1535451894-2518-6-git-send-email-dkos@cadence.com>
Message-ID: <1794131.JE1BxD2NGT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. August 2018, 12:24:48 CEST schrieb Damian Kos:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> This patch finally adds the preliminary driver for Cadence MHDP DPI/DP bridge.
> 
> Changes made in the low level driver (cdn-dp-reg.*):
> - moved it to from drivers/gpu/drm/rockchip to
>   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> - functions for sending/receiving commands are now public
> - added functions for reading registers and link training
>   adjustment
> 
> Changes made in RK's driver (cdn-dp-core.*):
> - Moved audio_info and audio_pdev fields from cdn_dp_device to
>   cdns_mhdp_device structure.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                |    9 +
>  drivers/gpu/drm/bridge/Makefile               |    3 +
>  .../cdns-mhdp-common.c}                       |  137 +-
>  .../cdns-mhdp-common.h}                       |   21 +-
>  drivers/gpu/drm/bridge/cdns-mhdp.c            | 1308 +++++++++++++++++
>  drivers/gpu/drm/rockchip/Kconfig              |    1 +
>  drivers/gpu/drm/rockchip/Makefile             |    4 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        |   16 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.h        |    4 +-
>  9 files changed, 1484 insertions(+), 19 deletions(-)
>  rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (87%)
>  rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (95%)
>  create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 9eeb8ef0b174..90a4810a8c96 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -35,6 +35,15 @@ config DRM_CDNS_DSI
>  	  Support Cadence DPI to DSI bridge. This is an internal
>  	  bridge and is meant to be directly embedded in a SoC.
>  
> +config DRM_CDNS_MHDP
> +	tristate "Cadence DPI/DP bridge"
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL_BRIDGE
> +	depends on OF
> +	help
> +	  Support Cadence DPI to DP bridge. This is an internal
> +	  bridge and is meant to be directly embedded in a SoC.
> +

This ends up with a Kconfig error on my kernel, with:

scripts/kconfig/conf  --oldconfig Kconfig
drivers/i2c/Kconfig:7:error: recursive dependency detected!
drivers/i2c/Kconfig:7:  symbol I2C is selected by FB_DDC
drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
drivers/gpu/drm/Kconfig:68:     symbol DRM_KMS_HELPER is selected by DRM_CDNS_MHDP
drivers/gpu/drm/bridge/Kconfig:38:      symbol DRM_CDNS_MHDP is selected by ROCKCHIP_CDN_DP
drivers/gpu/drm/rockchip/Kconfig:29:    symbol ROCKCHIP_CDN_DP depends on EXTCON
drivers/extcon/Kconfig:1:       symbol EXTCON is selected by CHARGER_MANAGER
drivers/power/supply/Kconfig:467:       symbol CHARGER_MANAGER depends on POWER_SUPPLY
drivers/power/supply/Kconfig:1: symbol POWER_SUPPLY is selected by HID_BATTERY_STRENGTH
drivers/hid/Kconfig:28: symbol HID_BATTERY_STRENGTH depends on HID
drivers/hid/Kconfig:7:  symbol HID is selected by I2C_HID
drivers/hid/i2c-hid/Kconfig:4:  symbol I2C_HID depends on I2C
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"


The culprit being the dependency on EXTCON in the Rockchip cdn-dp driver.
Moving to "select EXTCON" seems to fix the issue, but I'm not sure yet if that
is the correct solution.


Heiko
