From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 29 Nov 2016 15:16:41 +0100
Subject: [PATCH 0/4] drm: Add support for the Amlogic Video Processing Unit
In-Reply-To: <1480416469-9655-1-git-send-email-narmstrong@baylibre.com>
References: <1480416469-9655-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161129141641.brmghi5dufk4hhcc@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:47:45AM +0100, Neil Armstrong wrote:
> This a repost of the previous RFC at [1] with fixes, the following patches will
> be sent via a PULL Request once the Amlogic maintainer acks and takes the DT
> patches to avoid merges conflicts.
> 
> The Amlogic Meson SoCs embeds a Video Processing Unit able to output at least
> a Composite/CVBS Video with embedded VDAC and an HDMI Link with Embedded HDMI
> Transceiver.
> 
> Thus, the current driver does not support HDMI yet.
> 
> The Video Processig Unit is composed of multiple modules like the Video
> Input Unit and the Video Post Processing that can be associated to a
> CRTC with Planes management.
> The last Unit is the Venc that embeds at least 3 Encoders, ENCI for Interlace
> Video used by CVBS or HDMI, ENCP for Progressive Video used by the HDMI
> Transceiver and ENCL for LCD Display.
> 
> The LCD Display is not planned to be supported on the Meson GX Family.
> 
> This driver is a DRM/KMS driver using the following DRM components :
>  - GEM-CMA
>  - PRIME-CMA
>  - Atomic Modesetting
>  - FBDev-CMA
> 
> For the following SoCs :
>  - GXBB Family (S905)
>  - GXL Family (S905X, S905D)
>  - GXM Family (S912)
> 
> The current driver only supports the CVBS PAL/NTSC output modes, but the
> CRTC/Planes management should support bigger modes.
> But Advanced Colorspace Conversion, Scaling and HDMI Modes will be added in
> a second time.
> 
> The Device Tree bindings makes use of the endpoints video interface definitions
> to connect to the optional CVBS and in the future the HDMI Connector nodes.
> 
> The driver has been tested with Xorg modesetting driver and Weston DRM backend.
> 
> Changes since RFC at [1] :
>  - Add maintainers entry
>  - Move all Plane and CRTC code from backend to corresponding DRM code
>  - Keep only init and common code in backend source files
>  - Move the CVBS encoder out of the CVBS DT node, only keep the connector
>  - Various cleanups using DRM helpers
>  - Cleanup of copyright headers
>  - Fixup of bindings documentation
> 
> [1] http://lkml.kernel.org/r/1480089791-12517-1-git-send-email-narmstrong at baylibre.com
> 
> Neil Armstrong (4):
>   drm: Add support for Amlogic Meson Graphic Controller
>   ARM64: dts: meson-gx: Add Graphic Controller nodes
>   dt-bindings: display: add Amlogic Meson DRM Bindings
>   MAINTAINERS: add entry for Amlogic DRM drivers

I think this is all reasonable, once you have an ack from DT maintainers
pls send the pull request to Dave.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>  .../bindings/display/meson/meson-drm.txt           |  134 ++
>  MAINTAINERS                                        |    9 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   46 +
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |    4 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |    4 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |    8 +
>  .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |    4 +
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    8 +
>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |    4 +
>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |    8 +
>  drivers/gpu/drm/Kconfig                            |    2 +
>  drivers/gpu/drm/Makefile                           |    1 +
>  drivers/gpu/drm/meson/Kconfig                      |    9 +
>  drivers/gpu/drm/meson/Makefile                     |    5 +
>  drivers/gpu/drm/meson/meson_canvas.c               |   68 +
>  drivers/gpu/drm/meson/meson_canvas.h               |   42 +
>  drivers/gpu/drm/meson/meson_crtc.c                 |  208 +++
>  drivers/gpu/drm/meson/meson_crtc.h                 |   32 +
>  drivers/gpu/drm/meson/meson_cvbs.c                 |  177 +++
>  drivers/gpu/drm/meson/meson_drv.c                  |  385 ++++++
>  drivers/gpu/drm/meson/meson_drv.h                  |   61 +
>  drivers/gpu/drm/meson/meson_plane.c                |  230 ++++
>  drivers/gpu/drm/meson/meson_plane.h                |   30 +
>  drivers/gpu/drm/meson/meson_registers.h            | 1395 ++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_vclk.c                 |  167 +++
>  drivers/gpu/drm/meson/meson_vclk.h                 |   34 +
>  drivers/gpu/drm/meson/meson_venc.c                 |  254 ++++
>  drivers/gpu/drm/meson/meson_venc.h                 |   72 +
>  drivers/gpu/drm/meson/meson_venc_cvbs.c            |  187 +++
>  drivers/gpu/drm/meson/meson_venc_cvbs.h            |   41 +
>  drivers/gpu/drm/meson/meson_viu.c                  |  331 +++++
>  drivers/gpu/drm/meson/meson_viu.h                  |   64 +
>  drivers/gpu/drm/meson/meson_vpp.c                  |  162 +++
>  drivers/gpu/drm/meson/meson_vpp.h                  |   35 +
>  34 files changed, 4221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/meson/meson-drm.txt
>  create mode 100644 drivers/gpu/drm/meson/Kconfig
>  create mode 100644 drivers/gpu/drm/meson/Makefile
>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.c
>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.h
>  create mode 100644 drivers/gpu/drm/meson/meson_cvbs.c
>  create mode 100644 drivers/gpu/drm/meson/meson_drv.c
>  create mode 100644 drivers/gpu/drm/meson/meson_drv.h
>  create mode 100644 drivers/gpu/drm/meson/meson_plane.c
>  create mode 100644 drivers/gpu/drm/meson/meson_plane.h
>  create mode 100644 drivers/gpu/drm/meson/meson_registers.h
>  create mode 100644 drivers/gpu/drm/meson/meson_vclk.c
>  create mode 100644 drivers/gpu/drm/meson/meson_vclk.h
>  create mode 100644 drivers/gpu/drm/meson/meson_venc.c
>  create mode 100644 drivers/gpu/drm/meson/meson_venc.h
>  create mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.c
>  create mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.h
>  create mode 100644 drivers/gpu/drm/meson/meson_viu.c
>  create mode 100644 drivers/gpu/drm/meson/meson_viu.h
>  create mode 100644 drivers/gpu/drm/meson/meson_vpp.c
>  create mode 100644 drivers/gpu/drm/meson/meson_vpp.h
> 
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
