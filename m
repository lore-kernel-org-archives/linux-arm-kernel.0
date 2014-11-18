From: ajaynumb@gmail.com (Ajay kumar)
Date: Tue, 18 Nov 2014 11:50:47 +0530
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15, 2014 at 3:24 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> This series is based on master branch of Linus tree at:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> Changes since V2:
>         -- Address comments from Jingoo Han for ps8622 driver
>         -- Address comments from Daniel, Rob and Thierry regarding
>            bridge chaining
>         -- Address comments from Thierry regarding the names for
>            new drm_panel functions
>
> Changes since V3:
>         -- Remove hotplug based initialization of exynos_dp
>         -- Make exynos_dp work directly with drm_panel, remove
>            dependency on panel_binder
>         -- Minor cleanups in panel_binder and panel_lvds driver
>
> Changes since V4:
>         -- Use gpiod interface for panel-lvds and ps8622 drivers.
>         -- Address comments from Javier.
>         -- Fix compilation issues when PANEL_BINDER is selected as module.
>         -- Split Documentation patches from driver patches.
>         -- Rebase on top of the tree.
>
> Changes since V5:
>         -- Modify bridge drivers to support driver model.
>         -- Drop the concept of bridge chain(sincle there are no 2 real bridges)
>            Hence drop bridge-panel_binder layer.
>         -- Drop panel-lvds driver and accomodate the required changes in
>            panel-simple driver.
>         -- Use gpiod interface in ptn3460 driver.
>         -- Address all comments by Thierry Reding for V5 series.
>         -- Address comments from Sean Paul for exynos_dp_commit issue.
>
> Changes since V6:
>         -- Panel patches were seperated and they are merged already.
>         -- Fix few issues with ptn3460, before modifying the bridge core.
>         -- Modify drm_bridge as per Thierry's comments for V6 series.
>         -- Add drm_bridge changes minimally without breaking existing code.
>         -- Add new features for ptn3460, step-by-step.
>         -- Address comments from Thierry and Andreas for ptn3460 and ps8622.
>         -- Split documentation patches from driver patches.
>
> Changes since V7:
>         -- Address comments from Tomi and Laurent:
>                 -- Use videoports and endpoints to represent the connection between
>                    encoder, bridge and the panel, instead of using phandles.
>         -- Address comments from Daniel:
>                 -- Make the patch description more descriptive.
>                 -- remove device pointer from drm_bridge, and just use
>                    device_node instead.
>                 -- don't pass encoder pointer to bridge_attach.
>         -- Address comments from Sean Paul:
>                 -- Remove bridge from mode_config, and pull out drm_bridge
>                    functions from drm_crtc.c to drm_bridge.c
>
> Note: This patchset creates the following Kconfig ambiguity.
>       Any pointers to fix the same are welcome.
>
> drivers/video/fbdev/Kconfig:5:error: recursive dependency detected!
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:34:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> drivers/gpu/drm/Kconfig:28:     symbol DRM_KMS_HELPER is selected by DRM_PTN3460
> drivers/gpu/drm/bridge/Kconfig:1:       symbol DRM_PTN3460 depends on I2C
> drivers/i2c/Kconfig:7:  symbol I2C is selected by FB_DDC
> drivers/video/fbdev/Kconfig:59: symbol FB_DDC is selected by FB_CYBER2000_DDC
> drivers/video/fbdev/Kconfig:374:        symbol FB_CYBER2000_DDC depends on FB_CYBER2000
> drivers/video/fbdev/Kconfig:362:        symbol FB_CYBER2000 depends on FB
>
> Ajay Kumar (13):
>   [PATCH V8 1/14] drm/bridge: ptn3460: Few trivial cleanups
>   [PATCH V8 2/14] drm/bridge: do not pass drm_bridge_funcs to drm_bridge_init
>   [PATCH V8 3/14] drm/bridge: make bridge registration independent of drm flow
>   [PATCH V8 4/14] drm/bridge: ptn3460: Convert to i2c driver model
>   [PATCH V8 5/14] drm/exynos: dp: support drm_bridge
>   [PATCH V8 6/14] drm/bridge: ptn3460: support drm_panel
>   [PATCH V8 7/14] drm/bridge: ptn3460: probe connector at the end of bridge attach
>   [PATCH V8 8/14] drm/bridge: ptn3460: use gpiod interface
>   [PATCH V8 9/14] Documentation: drm: bridge: move to video/bridge
>   [PATCH V8 10/14] Documentation: devicetree: Add vendor prefix for parade
>   [PATCH V8 11/14] Documentation: bridge: Add documentation for ps8622 DT properties
>   [PATCH V8 13/14] ARM: dts: snow: represent the connection between bridge and panel
>     using videoport and endpoints
>   [PATCH V8 14/14] ARM: dts: peach-pit: represent the connection between bridge and
>     panel using videoport and endpoints
>
> Vincent Palatin (1):
>   [PATCH V8 12/14] drm/bridge: Add i2c based driver for ps8622/ps8625 bridge
>
>  .../devicetree/bindings/drm/bridge/ptn3460.txt     |   27 -
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  .../devicetree/bindings/video/bridge/ps8622.txt    |   31 +
>  .../devicetree/bindings/video/bridge/ptn3460.txt   |   39 ++
>  .../devicetree/bindings/video/exynos_dp.txt        |   12 +
>  arch/arm/boot/dts/exynos5250-snow.dts              |   30 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   31 +-
>  drivers/gpu/drm/Makefile                           |    2 +-
>  drivers/gpu/drm/bridge/Kconfig                     |   12 +
>  drivers/gpu/drm/bridge/Makefile                    |    1 +
>  drivers/gpu/drm/bridge/ps8622.c                    |  684 ++++++++++++++++++++
>  drivers/gpu/drm/bridge/ptn3460.c                   |  310 +++++----
>  drivers/gpu/drm/drm_bridge.c                       |   91 +++
>  drivers/gpu/drm/drm_crtc.c                         |   68 --
>  drivers/gpu/drm/exynos/exynos_dp_core.c            |   53 +-
>  drivers/gpu/drm/exynos/exynos_dp_core.h            |    1 +
>  drivers/gpu/drm/msm/hdmi/hdmi.c                    |    7 +-
>  drivers/gpu/drm/msm/hdmi/hdmi.h                    |    1 +
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |    8 +-
>  drivers/gpu/drm/sti/sti_hda.c                      |   11 +-
>  drivers/gpu/drm/sti/sti_hdmi.c                     |   11 +-
>  include/drm/bridge/ptn3460.h                       |    8 +
>  include/drm/drm_crtc.h                             |   27 +-
>  23 files changed, 1184 insertions(+), 282 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
>  create mode 100644 Documentation/devicetree/bindings/video/bridge/ps8622.txt
>  create mode 100644 Documentation/devicetree/bindings/video/bridge/ptn3460.txt
>  create mode 100644 drivers/gpu/drm/bridge/ps8622.c
>  create mode 100644 drivers/gpu/drm/drm_bridge.c
>
> --
> 1.7.9.5
>
