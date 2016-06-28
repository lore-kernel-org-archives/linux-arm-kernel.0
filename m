From: john.stultz@linaro.org (John Stultz)
Date: Mon, 27 Jun 2016 20:09:30 -0700
Subject: [PATCH 00/21] Support qcom's HSIC USB and rewrite USB2 HS phy
 support
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <CALAqxLUHfsJBTQS=p5oThnOdiAZwu48puRhREx+2G9+KajDA9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The state of USB ChipIdea support on Qualcomm's platforms is not great.
> The DT description of these devices requires up to three different nodes
> for what amounts to be the same hardware block, when there should really
> only be one. Furthermore, the "phy" driver that is in mainline (phy-msm-usb.c)
> duplicates the OTG state machine and touches the ci controller wrapper
> registers when it should really be focused on the phy and the ULPI accesses
> needed to get the phy working. There's also a slimmed down phy driver for
> the msm8916 platform, but really the phy hardware is the same as other MSMs,
> so we have two drivers doing pretty much the same thing. This leads to a
> situtaion where we have the chipidea core driver, the "phy" driver, and
> sometimes the ehci-msm.c driver operating the same device all at the same
> time with very little coordination. This just isn't very safe and is
> confusing from a driver perspective when trying to figure out who does what.
> Finally, there isn't any HSIC support on platforms like apq8074 so we
> should add that.
>
> This patch series updates the ChipIdea driver and the MSM wrapper
> (ci_hdrc_msm.c) to properly handle the PHY and wrapper bits at the right
> times in the right places. To get there, we update the ChipIdea core to
> have support for the ULPI phy bus introduced by Heikki. Along the way
> we fix bugs with the extcon handling for peripheral and OTG mode controllers
> and move the parts of phy-usb-msm.c that are touching the CI controller
> wrapper into the wrapper driver (ci_hdrc_msm.c). Finally we add support
> for the HSIC phy based on the ULPI bus and rewrite the HS phy driver
> (phy-usb-msm.c) as a standard ULPI phy driver.
>
> Once this series is accepted, we should be able to delete the phy-usb-msm.c
> phy-qcom-8x16-usb.c, and ehci-msm.c drivers from the tree and use the ULPI
> based phy driver (which also lives in drivers/phy/ instead of drivers/usb/phy/)
> and the chipidea host core instead.
>
> I've also sent seperate patches for other minor pieces to make this
> all work. The full tree can be found here[3], hacks and all to get
> things working. I've tested this on the db410c, apq8074 dragonboard,
> and ifc6410 with configfs gadgets and otg cables.
...
> [3] https://git.linaro.org/people/stephen.boyd/linux.git/shortlog/refs/heads/usb-hsic-8074

Very excited to see this moving upstream!

Just a heads up, trying to build with this branch gives me:

drivers/usb/Kconfig:39:error: recursive dependency detected!
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/input/Kconfig:8:        symbol INPUT is selected by VT
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected
by DRM_KMS_CMA_HELPER
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on
RESET_CONTROLLER
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by
USB_CHIPIDEA
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"
drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB
drivers/usb/chipidea/otg.c: In function ?hw_write_otgsc?:
drivers/usb/chipidea/otg.c:120:2: warning: format ?%x? expects
argument of type ?unsigned int?, but argument 3 has type ?long
unsigned int? [-Wformat]
drivers/usb/chipidea/otg.c:120:2: warning: format ?%x? expects
argument of type ?unsigned int?, but argument 4 has type ?long
unsigned int? [-Wformat]

I haven't yet been able to test with this, as I need some other fixes
it seems too to deal with some of the iommu changes in my flo-WIP tree
(it can't find of_dma_configure), but will let you know how things
work once I have all that sorted.

thanks
-john
