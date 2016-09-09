From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 9 Sep 2016 08:45:51 +0800
Subject: [PATCH v4 00/22] Support qcom's HSIC USB and rewrite USB2 HS
 support
In-Reply-To: <147336920894.5149.4788295408306540134@sboyd-linaro>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <CAL411-ocwAAQ_cn2a+NS08hbFVUMNBvh_QRbPf-fd9=2YMK8kA@mail.gmail.com>
 <147336920894.5149.4788295408306540134@sboyd-linaro>
Message-ID: <20160909004551.GA15637@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 02:13:28PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-09-07 19:06:45)
> > On Thu, Sep 8, 2016 at 5:34 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> > > The state of USB ChipIdea support on Qualcomm's platforms is not great.
> > > The DT description of these devices requires up to three different nodes
> > > for what amounts to be the same hardware block, when there should really
> > > only be one. Furthermore, the "phy" driver that is in mainline (phy-msm-usb.c)
> > > duplicates the OTG state machine and touches the ci controller wrapper
> > > registers when it should really be focused on the phy and the ULPI accesses
> > > needed to get the phy working. There's also a slimmed down phy driver for
> > > the msm8916 platform, but really the phy hardware is the same as other MSMs,
> > > so we have two drivers doing pretty much the same thing. This leads to a
> > > situtaion where we have the chipidea core driver, the "phy" driver, and
> > > sometimes the ehci-msm.c driver operating the same device all at the same
> > > time with very little coordination. This just isn't very safe and is
> > > confusing from a driver perspective when trying to figure out who does what.
> > > Finally, there isn't any HSIC support on platforms like apq8074 so we
> > > should add that.
> > >
> > > This patch series updates the ChipIdea driver and the MSM wrapper
> > > (ci_hdrc_msm.c) to properly handle the PHY and wrapper bits at the right
> > > times in the right places. To get there, we update the ChipIdea core to
> > > have support for the ULPI phy bus introduced by Heikki. Along the way
> > > we fix bugs with the extcon handling for peripheral and OTG mode controllers
> > > and move the parts of phy-usb-msm.c that are touching the CI controller
> > > wrapper into the wrapper driver (ci_hdrc_msm.c). Finally we add support
> > > for the HSIC phy based on the ULPI bus and rewrite the HS phy driver
> > > (phy-usb-msm.c) as a standard ULPI phy driver.
> > >
> > > Once this series is accepted, we should be able to delete the phy-usb-msm.c,
> > > phy-qcom-8x16-usb.c, and ehci-msm.c drivers from the tree and use the ULPI
> > > based phy driver (which also lives in drivers/phy/ instead of drivers/usb/phy/)
> > > and the chipidea host core instead.
> > >
> > > I've also sent separate patches for other minor pieces to make this
> > > all work. The full tree can be found here[3], hacks and all to get
> > > things working. I've tested this on the db410c, apq8074 dragonboard,
> > > and ifc6410 with configfs gadgets and otg cables.
> > >
> > > Patches based on v4.8-rc1
> > >
> > > Changes from v3:
> > >
> > >  * Picked up Acks from Peter
> > >
> > >  * Updated extcon consolidation patch per Peter's comments
> > >
> > >  * Folded in simplification from Heikki for ULPI DT matching
> > >
> > 
> > I find the kbuild dependency error when compile your series, I remembered
> > someone met it before, would you have a solution:
> 
> Yes. Should I send it through the drm maintainers?
> 

Yes, please add me at cc list, thanks.

Peter
> ---8<---
> From: Stephen Boyd <stephen.boyd@linaro.org>
> Subject: [PATCH] gpu: Remove depends on RESET_CONTROLLER when not a provider
> 
> These GPU drivers only depend on the RESET_CONTROLLER config
> option to fix build issues that existed when there weren't stub
> reset APIs for reset controller consumers. Given that these
> drivers aren't providing any reset controllers themselves, they
> don't actually depend on the API to build (just to function) so
> they don't need to depend on it. Remove the dependency to fix
> recursive build errors like the following:
> 
> drivers/usb/Kconfig:39:error: recursive dependency detected!
> drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
> drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
> drivers/input/Kconfig:8:        symbol INPUT is selected by VT
> drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
> drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected by DRM_KMS_CMA_HELPER
> drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
> drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
> drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on RESET_CONTROLLER
> drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by USB_CHIPIDEA
> drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
> drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/gpu/drm/rockchip/Kconfig | 1 -
>  drivers/gpu/drm/tegra/Kconfig    | 1 -
>  drivers/gpu/ipu-v3/Kconfig       | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 3c58669a06ce..6f7f9c59f05b 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -1,7 +1,6 @@
>  config DRM_ROCKCHIP
>  	tristate "DRM Support for Rockchip"
>  	depends on DRM && ROCKCHIP_IOMMU
> -	depends on RESET_CONTROLLER
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 63ebb154b9b5..bbf5a4b7e0b6 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -3,7 +3,6 @@ config DRM_TEGRA
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	depends on COMMON_CLK
>  	depends on DRM
> -	depends on RESET_CONTROLLER
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
> diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
> index aefdff95356d..08766c6e7856 100644
> --- a/drivers/gpu/ipu-v3/Kconfig
> +++ b/drivers/gpu/ipu-v3/Kconfig
> @@ -1,7 +1,6 @@
>  config IMX_IPUV3_CORE
>  	tristate "IPUv3 core support"
>  	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM
> -	depends on RESET_CONTROLLER
>  	select GENERIC_IRQ_CHIP
>  	help
>  	  Choose this if you have a i.MX5/6 system and want to use the Image
> -- 
> 2.9.0.rc2.8.ga28705d

-- 

Best Regards,
Peter Chen
