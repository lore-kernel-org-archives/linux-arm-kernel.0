From: psidhu@gateworks.com (Pushpal Sidhu)
Date: Thu, 8 Oct 2015 13:54:57 -0700
Subject: i.mx6 video out in mainline
In-Reply-To: <CAOMZO5CXRaR-dd4XT28qiZkCxd9iUdZr0RzwHixjeQ2L4RG2kQ@mail.gmail.com>
References: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
 <CAOMZO5CwjC2dq3fWugAJsqThxAZ6o4wv0gV7ues28a51z0fXLg@mail.gmail.com>
 <CAD1M061RTNOCuE5vwrTsR3mgOaWcuwt5mc-L+K3kdLCDQ=JfLQ@mail.gmail.com>
 <CAOMZO5CXRaR-dd4XT28qiZkCxd9iUdZr0RzwHixjeQ2L4RG2kQ@mail.gmail.com>
Message-ID: <CAD1M062KB_A5_kCDwqif0fSPjZPEYrEZX9J54PUr3=baTbgrZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 8:07 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Oct 6, 2015 at 8:02 PM, Pushpal Sidhu <psidhu@gateworks.com> wrote:
>
>> When I took your patch and adapted it for imx6qdl-gw54xx.dtsi, I found
>> that HDMI video out was slightly shifted to the left and resolution
>> remained at 1024x768p.
>>
>> I also found that when I disabled DRM_IMX_LDB, HDMI out stopped
>> working altogether, though if I stripped out the ldb section in device
>> tree, the resolution comes back at 1080p (regardless of setting
>> DRM_IMX_LDB or not). There is definitely some strange interdependency
>> between lvds and hdmi here. Do you have an idea of where I should
>> start looking for this problem?
>
> I thought we have already fixed that. Does this issue still happen with 4.3-rc4?
>
> I would suggest turning on debug in drivers/gpu/ipu-v3/ipu-di.c and
> see the DI frequencies you are getting for the HDMI and LDB ports.

I moved to 4.3-rc4, and found that HDMI and LVDS DI freq's are
different (with your patch to move LVDS's parent clock to OTG.

HDMI: imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI 65000000Hz
Needed 65000000Hz
LVDS: imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI 68571429Hz
Needed 65000000Hz

However, if I have both HDMI and LVDS hooked into the system at the
same time, the HDMI's EDID block 0 is always invalid.

$ cat /proc/cmdline
console=ttymxc1,115200 root=ubi0:rootfs ubi.mtd=2 rootfstype=ubifs
debug video=HDMI-A-1,1920x1080M at 60

$ dmesg | grep "ipu\|drm\|hdmi\|lvds"
[    1.983369] [drm] Initialized drm 1.1.0 20060810
[    1.990533] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.996823] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.004000] [drm] No driver support for vblank timestamp query.
[    2.010539] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops
ipu_crtc_ops)
[    2.018549] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops
ipu_crtc_ops)
[    2.026575] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops
ipu_crtc_ops)
[    2.034608] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops
ipu_crtc_ops)
[    2.043253] dwhdmi-imx 120000.hdmi: Detected HDMI controller
0x13:0xa:0xa0:0xc1
[    2.057862] imx-drm display-subsystem: bound 120000.hdmi (ops
dw_hdmi_imx_ops)
[    2.072465] imx-drm display-subsystem: bound
2000000.aips-bus:ldb at 020e0008 (ops imx_ldb_ops)
[    2.097335] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
invalid, remainder is 81
[    2.169323] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
invalid, remainder is 81
[    2.241300] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
invalid, remainder is 81
[    2.313291] [drm:drm_edid_block_valid] *ERROR* EDID checksum is
invalid, remainder is 81
[    2.369763] imx-drm display-subsystem: HDMI-A-1: EDID block 0 invalid.
[    2.416797] imx-drm display-subsystem: fb0:  frame buffer device
[    2.460575] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
[    2.466766] imx-ipuv3 2800000.ipu: IPUv3H probed
[   28.270558] imx-ipuv3 2400000.ipu: Timeout waiting for DMFC FIFOs to clear

This causes the HDMI monitor to get a signal, and within a second,
think that a signal no longer exists. Also, it seems that LVDS (even
connected by itself), appears to work. The backlight comes on, but
nothing gets drawn to the display. I then tried the following:

$ cat /proc/cmdline
console=ttymxc1,115200 root=ubi0:rootfs ubi.mtd=2 rootfstype=ubifs
debug video=HDMI-A-1:d video=LVDS-1:e

That is, forcing HDMI off and LVDS on. I verified that the kernel saw
this (e.g. [drm] forcing HDMI-A-1 connector OFF) and found an
interesting result. The LVDS backlight still turns on, but the HDMI
had the image painted onto it while being colorspace converted for the
LVDS monitor (white showed up as a light blue, green was blue, red was
green etc). It looks like when only LVDS is connected, signals still
get sent to the HDMI monitor, which would explain why it appears that
LVDS doesn't work.

Comparing the imx6qdl-gw54xx.dtsi and imx6qdl-sabersd.dtsi, I couldn't
see too many differences between HDMI and LVDS, so I'm a little
surprised you don't see this exact same behavior there. Note that I've
tried this with the patch for changing the LVDS's parent clock in the
imx6qdl-gw54xx.dtsi file.

- Pushpal
