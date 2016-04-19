From: dennis@ausil.us (Dennis Gilmore)
Date: Tue, 19 Apr 2016 14:27:17 -0500
Subject: bug in autoloading of imx-ipuv3-crtc
In-Reply-To: <20160419185049.GC19428@n2100.arm.linux.org.uk>
References: <6926808.b0joqYQPQE@anubis.ausil.us>
 <20160419185049.GC19428@n2100.arm.linux.org.uk>
Message-ID: <2530051.TK07cZHuGk@anubis.ausil.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2016 7:50:49 PM CDT Russell King - ARM Linux wrote:
> On Tue, Apr 19, 2016 at 01:34:23PM -0500, Dennis Gilmore wrote:
> > Hi All,
> > 
> > on all of my i.MX6 systems imx-ipuv3-crtc ius not getting automatically
> > loaded.  Everything is built as a module
> > 
> > CONFIG_DRM_IMX=m
> > CONFIG_DRM_IMX_FB_HELPER=m
> > CONFIG_DRM_IMX_HDMI=m
> > CONFIG_DRM_IMX_IPUV3=m
> > CONFIG_DRM_IMX_LDB=m
> > CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > CONFIG_DRM_IMX_TVE=m
> > CONFIG_IMX_IPUV3_CORE=m
> > 
> > The result is that until I log in via serial or ssh and modprobe the
> > module there is no display.  I suspect that there is some devicetree
> > glue missing 4.4 and 4.5 seem to both be effected.
> 
> DT doesn't come into it for imx-ipuv3-crtc - these platform devices are
> created by drivers/gpu/ipu-v3/ipu-common.c itself.
> 
> drivers/gpu/drm/imx/ipuv3-crtc.c contains the proper module alias which
> should result in the module loaded at boot time when the imx-ipuv3-crtc
> devices are created.
> 
> Could the problem be that imx-ipu-v3 isn't being loaded?  However, again,
> it looks to me like everything is correct there.
> 
> Are you saying that this used to work in older kernel versions like 4.3,
> but stopped in 4.4?

yers it used to work and stopped working. I would need to go back and test old 
kernels to figure out where it broke. 

[root at localhost ~]# lsmod |grep imx
imx_pcm_dma             1455  1 snd_soc_fsl_spdif
snd_soc_imx_spdif       2168  1
snd_soc_core          162930  4 
imx_pcm_dma,snd_soc_fsl_asrc,snd_soc_imx_spdif,snd_soc_fsl_spdif
imx_ipu_v3             71290  0
imx_sdma               15739  2
ci_hdrc_imx             7191  0
usbmisc_imx             6460  1 ci_hdrc_imx
dw_hdmi_imx             3631  0
ci_hdrc                34482  1 ci_hdrc_imx
imx2_wdt                4245  0
dw_hdmi                14561  1 dw_hdmi_imx
imx_thermal             7056  0
sdhci_esdhc_imx        12018  0
sdhci_pltfm             4706  1 sdhci_esdhc_imx
ahci_imx                6468  0
sdhci                  38284  2 sdhci_pltfm,sdhci_esdhc_imx
mmc_core              120546  5 
mmc_block,sdhci,brcmfmac,btsdio,sdhci_esdhc_imx
libahci_platform        7526  1 ahci_imx
i2c_imx                16259  0
imxdrm                  7776  1 dw_hdmi_imx
drm_kms_helper        116603  2 dw_hdmi,imxdrm
pwm_imx                 3786  1
drm                   309675  6 
dw_hdmi,drm_kms_helper,dw_hdmi_imx,etnaviv,imxdrm

on a freshly booted system

imx-ipu-v3 is loaded however something is missing.

Dennis
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/66533ecd/attachment.sig>
