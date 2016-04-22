From: dennis@ausil.us (Dennis Gilmore)
Date: Fri, 22 Apr 2016 08:11:24 -0500
Subject: bug in autoloading of imx-ipuv3-crtc
In-Reply-To: <20160420230317.GT29108@pengutronix.de>
References: <6926808.b0joqYQPQE@anubis.ausil.us>
 <1513165.9WxCa41tI1@anubis.ausil.us> <20160420230317.GT29108@pengutronix.de>
Message-ID: <13533046.1iFyOjiAs0@anubis.ausil.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 21, 2016 1:03:17 AM CDT Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Apr 19, 2016 at 03:16:01PM -0500, Dennis Gilmore wrote:
> > On Tuesday, April 19, 2016 2:27:17 PM CDT Dennis Gilmore wrote:
> > > On Tuesday, April 19, 2016 7:50:49 PM CDT Russell King - ARM Linux 
wrote:
> > > > On Tue, Apr 19, 2016 at 01:34:23PM -0500, Dennis Gilmore wrote:
> > > > > on all of my i.MX6 systems imx-ipuv3-crtc ius not getting
> > > > > automatically
> > > > > loaded.  Everything is built as a module
> > > > > 
> > > > > CONFIG_DRM_IMX=m
> > > > > CONFIG_DRM_IMX_FB_HELPER=m
> > > > > CONFIG_DRM_IMX_HDMI=m
> > > > > CONFIG_DRM_IMX_IPUV3=m
> > > > > CONFIG_DRM_IMX_LDB=m
> > > > > CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
> > > > > CONFIG_DRM_IMX_TVE=m
> > > > > CONFIG_IMX_IPUV3_CORE=m
> > > > > 
> > > > > The result is that until I log in via serial or ssh and modprobe the
> > > > > module there is no display.  I suspect that there is some devicetree
> > > > > glue missing 4.4 and 4.5 seem to both be effected.
> > > > 
> > > > DT doesn't come into it for imx-ipuv3-crtc - these platform devices
> > > > are
> > > > created by drivers/gpu/ipu-v3/ipu-common.c itself.
> > > > 
> > > > drivers/gpu/drm/imx/ipuv3-crtc.c contains the proper module alias
> > > > which
> > > > should result in the module loaded at boot time when the
> > > > imx-ipuv3-crtc
> > > > devices are created.
> > > > 
> > > > Could the problem be that imx-ipu-v3 isn't being loaded?  However,
> > > > again,
> > > > it looks to me like everything is correct there.
> > > > 
> > > > Are you saying that this used to work in older kernel versions like
> > > > 4.3,
> > > > but stopped in 4.4?
> > > 
> > > yers it used to work and stopped working. I would need to go back and
> > > test
> > > old kernels to figure out where it broke.
> > 
> > after installing some old kernels it broke with 4.4-rc4 which included a
> > patch with teh subject of "drm/imx: Remove of_node assignment from
> > ipuv3-crtc driver probe"
> 
> Just to be sure: 4.4-rc4 with 407c9eba7897 ("drm/imx: Remove of_node
> assignment from ipuv3-crtc driver probe") reverted works fine for you?
> 
> Best regards
> Uwe

I reverted the 4 patches in that series

407c9eba drm/imx: Remove of_node assignment from ipuv3-crtc driver probe
304e6be6 gpu: ipu-v3: Assign of_node of child platform devices to 
corresponding ports
99ae78c3 gpu: ipu-v3: Remove reg_offset field
c3ede03c gpu: ipu-v3: drop unused dmfc field from client platform data

and it then worked again.

Dennis
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/c24659a7/attachment.sig>
