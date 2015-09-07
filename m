From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 07 Sep 2015 12:55:54 +0200
Subject: I.MX6 HDMI support in v4.2
Message-ID: <m3bnde5whx.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to ask if the HDMI output on I.MX6-based boards is possible.
I'm unable to get it to work. What I'm trying to do is getting
a) DRM HDMI output, b) X.org output using etnaviv, libdrm-armada and
xf86-video-armada, c) GLX and Xvideo. Basically, latest versions.

I'm working with Gateworks Ventana GW54xx boards and with Sabre-lite,
using newly built imx6q-gw54xx.dtb and imx6q-sabrelite.dtb. In both
cases, required kernel modules are inserted and (somehow) initialized,
but the HDMI device isn't created.

The first problem seems to be this:
- dw_hdmi_imx_probe() is called (and does component_add()), but
- dw_hdmi_imx_bind() is never called.

Now if I enable LVDS (CONFIG_DRM_IMX_LDB - I don't have any LVDS
hardware connected), the HDMI device is created (as well as LVDS).

This used to detect the monitor as "unknown" but now it's "connected"
most of the time - not sure what have changed. EDID is empty and I get
the following entries in /sys/devices/soc0/display-subsystem/drm/card0:

dev                                            226:0
card0-HDMI-A-1/edid                            (empty)
card0-HDMI-A-1/dpms                            On
card0-HDMI-A-1/modes
card0-HDMI-A-1/power/control                   auto
card0-HDMI-A-1/power/runtime_active_time       0
card0-HDMI-A-1/power/autosuspend_delay_ms      (Input/output error)
card0-HDMI-A-1/power/runtime_status            unsupported
card0-HDMI-A-1/power/runtime_suspended_time    0
card0-HDMI-A-1/enabled                         enabled
card0-HDMI-A-1/status                          used to be "unknown", now: "connected"
card0-HDMI-A-1/uevent                          power/control auto
power/runtime_active_time                      0
power/autosuspend_delay_ms                     (Input/output error)
power/runtime_status                           unsupported
power/runtime_suspended_time                   0
card0-LVDS-1/edid
card0-LVDS-1/dpms                              On
card0-LVDS-1/modes
card0-LVDS-1/power/control                     auto
card0-LVDS-1/power/runtime_active_time         0
card0-LVDS-1/power/autosuspend_delay_ms        (Input/output error)
card0-LVDS-1/power/runtime_status              unsupported
card0-LVDS-1/power/runtime_suspended_time      0
card0-LVDS-1/enabled                           disabled
card0-LVDS-1/status                            unknown
card0-LVDS-1/uevent
uevent                                         MAJOR=226
                                               MINOR=0
                                               DEVNAME=dri/card0
                                               DEVTYPE=drm_minor

Have to "touch /etc/xorg.conf" (otherwise the X server segfaults).

Now, somehow the X.org server sets the resolution to 1024x768, though
nothing is displayed on the monitor (it's in stand-by). Files in
/sys/.../card0-HDMI-A/ now have the actual EDID, mode list etc.

# xrandr
Screen 0: minimum 320 x 200, current 1024 x 768, maximum 4096 x 4096
HDMI-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 531mm x 299mm
   1920x1080     60.00 +
   1680x1050     59.88
   1280x1024     75.02    60.02
   1440x900      74.98    59.90
   1280x720      60.00
   1024x768      75.08    60.00*
   800x600       75.00    60.32
   640x480       75.00    72.81    66.67    60.00
   720x400       70.08
LVDS-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 0mm x 0mm
   1024x768      60.00*+

This also causes:
imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
imx-ipuv3 2400000.ipu: Timeout waiting for DMFC FIFOs to clear

What am I doing wrong?
- kernel command line? video=mxcfb0:dev=hdmi,1920x1080M at 60,if=RGB24
- wrong SDMA firmware? MD5 is:
  5d4584134cc4cba62e1be2f382cd6f3a  /lib/firmware/imx/sdma/sdma-imx6q.bin
- wrong X.org stuff?

CPU identified as i.MX6Q, silicon rev 1.2

imx_ipuv3_crtc         20480  0
ahci_imx               16384  0
libahci_platform       16384  1 ahci_imx
libahci                28672  2 ahci_imx,libahci_platform
imx_ipu_v3             49152  1 imx_ipuv3_crtc
fec                    45056  0
dw_hdmi_imx            16384  0
dw_hdmi                20480  1 dw_hdmi_imx
imx_ldb                16384  0
imxdrm                 16384  3 dw_hdmi_imx,imx_ipuv3_crtc,imx_ldb
drm_kms_helper         90112  4 dw_hdmi,imxdrm,imx_ipuv3_crtc,imx_ldb
syscopyarea            16384  1 drm_kms_helper
sysfillrect            16384  1 drm_kms_helper
coda                   45056  0
videobuf2_vmalloc      16384  1 coda
videobuf2_dma_contig   20480  1 coda
flexcan                20480  0
videobuf2_memops       16384  2 videobuf2_vmalloc,videobuf2_dma_contig
v4l2_mem2mem           16384  1 coda
videobuf2_core         40960  2 coda,v4l2_mem2mem
sysimgblt              16384  1 drm_kms_helper
sky2                   57344  0
gpmi_nand              28672  0
drm                   249856  7 dw_hdmi,drm_kms_helper,dw_hdmi_imx,imxdrm,imx_ipuv3_crtc,imx_ldb

CONFIG_SOC_IMX6=y
CONFIG_SOC_IMX6Q=y
CONFIG_I2C_IMX=y
CONFIG_SPI_IMX=y
CONFIG_PINCTRL_IMX=y
CONFIG_PINCTRL_IMX6Q=y
CONFIG_GPIO_MXC=y
CONFIG_DRM_IMX=m
# CONFIG_DRM_IMX_FB_HELPER is not set
# CONFIG_DRM_IMX_PARALLEL_DISPLAY is not set
# CONFIG_DRM_IMX_TVE is not set
# CONFIG_DRM_IMX_LDB is not set
CONFIG_DRM_IMX_IPUV3=m
CONFIG_DRM_IMX_HDMI=m
CONFIG_MX3_IPU=y
CONFIG_MX3_IPU_IRQS=4
CONFIG_IMX_SDMA=y
# CONFIG_IMX_DMA is not set
CONFIG_MXS_DMA=y
CONFIG_CLKSRC_IMX_GPT=y

Machine model: Gateworks Ventana i.MX6 Dual/Quad GW54XX
Kernel command line: console=ttymxc1,115200 video=mxcfb0:dev=hdmi,1920x1080M at 60,if=RGB24 earlyprintk
--
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
