From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 01:34:56 -0700
Subject: [PATCH 00/21] Support qcom's HSIC USB and rewrite USB2 HS phy
 support
In-Reply-To: <CALAqxLUHfsJBTQS=p5oThnOdiAZwu48puRhREx+2G9+KajDA9g@mail.gmail.com>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <CALAqxLUHfsJBTQS=p5oThnOdiAZwu48puRhREx+2G9+KajDA9g@mail.gmail.com>
Message-ID: <146710289677.3879.15364764209076318827@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting John Stultz (2016-06-27 20:09:30)
> 
> Just a heads up, trying to build with this branch gives me:
> 
> drivers/usb/Kconfig:39:error: recursive dependency detected!
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/input/Kconfig:8:        symbol INPUT is selected by VT
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected
> by DRM_KMS_CMA_HELPER
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on
> RESET_CONTROLLER
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by
> USB_CHIPIDEA
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB

Yeah, sorry I've updated the branch today with fixes reported by kbuild
robot. This problem starts to happen once I start selecting
RESET_CONTROLLER from the chipidea Kconfig symbol. I've layered another
patch on top to fix the build errors I'm seeing, although I'm not sure
it's a great solution.

> drivers/usb/chipidea/otg.c: In function ?hw_write_otgsc?:
> drivers/usb/chipidea/otg.c:120:2: warning: format ?%x? expects
> argument of type ?unsigned int?, but argument 3 has type ?long
> unsigned int? [-Wformat]
> drivers/usb/chipidea/otg.c:120:2: warning: format ?%x? expects
> argument of type ?unsigned int?, but argument 4 has type ?long
> unsigned int? [-Wformat]

These are debug print warnings. Nothing to see here...

> 
> I haven't yet been able to test with this, as I need some other fixes
> it seems too to deal with some of the iommu changes in my flo-WIP tree
> (it can't find of_dma_configure), but will let you know how things
> work once I have all that sorted.

Cool, thanks for testing.
