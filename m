From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 18:03:33 +0200
Subject: [PATCH v2 1/4] drm: Add support for Amlogic Meson Graphic
 Controller
In-Reply-To: <1480520625-13269-2-git-send-email-narmstrong@baylibre.com>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
 <1480520625-13269-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <3713265.h5djxipShb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Thank you for the patch.

I'm afraid I don't have time for a complete review, but could you please get 
rid of the of_machine_is_compatible() calls and match on the VPU compatible 
string instead ?

On Wednesday 30 Nov 2016 16:43:42 Neil Armstrong wrote:
> The Amlogic Meson Display controller is composed of several components :
> 
> DMC|---------------VPU (Video Processing
> Unit)----------------|------HHI------| |
> vd1   _______     _____________    _________________     |               |
> D  |-------|      |----|            |   |                |    |   HDMI
> PLL    | D  | vd2   | VIU  |    | Video Post |   | Video Encoders
> |<---|-----VCLK      | R  |-------|      |----| Processing
> |   |                |    |               | |
> osd2  |      |    |            |---| Enci ----------|----|-----VDAC------|
> R  |-------| CSC  |----| Scalers    |   | Encp
> ----------|----|----HDMI-TX----| A  | osd1  |      |    | Blenders   |   |
> Encl ----------|----|---------------|
> M  |-------|______|----|____________|   |________________|    |            
>    |
> ___|__________________________________________________________|____________
> ___|
> 
> VIU: Video Input Unit
> ---------------------
> 
> The Video Input Unit is in charge of the pixel scanout from the DDR memory.
> It fetches the frames addresses, stride and parameters from the "Canvas"
> memory. This part is also in charge of the CSC (Colorspace Conversion).
> It can handle 2 OSD Planes and 2 Video Planes.
> 
> VPP: Video Post Processing
> --------------------------
> 
> The Video Post Processing is in charge of the scaling and blending of the
> various planes into a single pixel stream.
> There is a special "pre-blending" used by the video planes with a dedicated
> scaler and a "post-blending" to merge with the OSD Planes.
> The OSD planes also have a dedicated scaler for one of the OSD.
> 
> VENC: Video Encoders
> --------------------
> 
> The VENC is composed of the multiple pixel encoders :
>  - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
>  - ENCP : Progressive Video Encoder for HDMI
>  - ENCL : LCD LVDS Encoder
> The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and clock
> tree and provides the scanout clock to the VPP and VIU.
> The ENCI is connected to a single VDAC for Composite Output.
> The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
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
> The Device Tree bindings makes use of the endpoints video interface
> definitions to connect to the optional CVBS and in the future the HDMI
> Connector nodes.
> 
> HDMI Support is planned for a next release.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/Kconfig                 |    2 +
>  drivers/gpu/drm/Makefile                |    1 +
>  drivers/gpu/drm/meson/Kconfig           |    9 +
>  drivers/gpu/drm/meson/Makefile          |    4 +
>  drivers/gpu/drm/meson/meson_canvas.c    |   68 ++
>  drivers/gpu/drm/meson/meson_canvas.h    |   42 +
>  drivers/gpu/drm/meson/meson_crtc.c      |  208 +++++
>  drivers/gpu/drm/meson/meson_crtc.h      |   32 +
>  drivers/gpu/drm/meson/meson_drv.c       |  343 ++++++++
>  drivers/gpu/drm/meson/meson_drv.h       |   60 ++
>  drivers/gpu/drm/meson/meson_plane.c     |  230 +++++
>  drivers/gpu/drm/meson/meson_plane.h     |   30 +
>  drivers/gpu/drm/meson/meson_registers.h | 1395 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_vclk.c      |  167 ++++
>  drivers/gpu/drm/meson/meson_vclk.h      |   34 +
>  drivers/gpu/drm/meson/meson_venc.c      |  254 ++++++
>  drivers/gpu/drm/meson/meson_venc.h      |   72 ++
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  293 +++++++
>  drivers/gpu/drm/meson/meson_venc_cvbs.h |   41 +
>  drivers/gpu/drm/meson/meson_viu.c       |  331 ++++++++
>  drivers/gpu/drm/meson/meson_viu.h       |   64 ++
>  drivers/gpu/drm/meson/meson_vpp.c       |  162 ++++
>  drivers/gpu/drm/meson/meson_vpp.h       |   35 +
>  23 files changed, 3877 insertions(+)
>  create mode 100644 drivers/gpu/drm/meson/Kconfig
>  create mode 100644 drivers/gpu/drm/meson/Makefile
>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>  create mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.c
>  create mode 100644 drivers/gpu/drm/meson/meson_crtc.h
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

-- 
Regards,

Laurent Pinchart
