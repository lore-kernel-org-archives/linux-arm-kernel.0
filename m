From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 27 Jun 2016 18:27:43 -0700
Subject: [PATCH 18/21] usb: chipidea: msm: Add reset controller for PHY
 POR bit
In-Reply-To: <201606271550.0OITViln%fengguang.wu@intel.com>
References: <201606271550.0OITViln%fengguang.wu@intel.com>
Message-ID: <146707726312.30684.13104198453139307038@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting kbuild test robot (2016-06-27 00:50:24)
> Hi,
> 
> [auto build test ERROR on peter.chen-usb/ci-for-usb-next]
> [also build test ERROR on v4.7-rc5 next-20160624]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/Support-qcom-s-HSIC-USB-and-rewrite-USB2-HS-phy-support/20160627-102637
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb ci-for-usb-next
> config: x86_64-randconfig-s5-06271251 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "reset_controller_unregister" [drivers/usb/chipidea/ci_hdrc_msm.ko] undefined!

Hmm. If I try to fix this by selecting RESET_CONTROLLER from the
chipidea Kconfig I get the following recursive Kconfig warning

drivers/usb/Kconfig:39:error: recursive dependency detected!
drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
drivers/input/Kconfig:8:        symbol INPUT is selected by VT
drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected by DRM_KMS_CMA_HELPER
drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on RESET_CONTROLLER
drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by USB_CHIPIDEA
drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB

Is the proper fix here to have IMX_IPUV3 select RESET_CONTROLLER instead
of depend on it? Doing that leads to another case where rockchip needs
to be changed from a depends on to a select, and then tegra is the same
way. Arnd, any ideas?
