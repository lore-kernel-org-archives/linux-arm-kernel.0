From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jan 2018 15:05:06 +0100
Subject: [linux-sunxi] [PATCH v4 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <20171225111526.4663f997f5d6bfc6cf157f10@magewell.com>
References: <1513935138-35223-1-git-send-email-yong.deng@magewell.com>
 <1513950408.841.81.camel@megous.com>
 <20171225111526.4663f997f5d6bfc6cf157f10@magewell.com>
Message-ID: <20180104140506.6owumj2pujux6sga@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 11:15:26AM +0800, Yong wrote:
> Hi,
> 
> On Fri, 22 Dec 2017 14:46:48 +0100
> Ond?ej Jirman <megous@megous.com> wrote:
> 
> > Hello,
> > 
> > Yong Deng p??e v P? 22. 12. 2017 v 17:32 +0800:
> > > This patchset add initial support for Allwinner V3s CSI.
> > > 
> > > Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
> > > and CSI1 is used for parallel interface. This is not documented in
> > > datasheet but by testing and guess.
> > > 
> > > This patchset implement a v4l2 framework driver and add a binding 
> > > documentation for it. 
> > > 
> > > Currently, the driver only support the parallel interface. And has been
> > > tested with a BT1120 signal which generating from FPGA. The following
> > > fetures are not support with this patchset:
> > >   - ISP 
> > >   - MIPI-CSI2
> > >   - Master clock for camera sensor
> > >   - Power regulator for the front end IC
> > > 
> > > Thanks for Ond?ej Jirman's help.
> > > 
> > > Changes in v4:
> > >   * Deal with the CSI 'INNER QUEUE'.
> > >     CSI will lookup the next dma buffer for next frame before the
> > >     the current frame done IRQ triggered. This is not documented
> > >     but reported by Ond?ej Jirman.
> > >     The BSP code has workaround for this too. It skip to mark the
> > >     first buffer as frame done for VB2 and pass the second buffer
> > >     to CSI in the first frame done ISR call. Then in second frame
> > >     done ISR call, it mark the first buffer as frame done for VB2
> > >     and pass the third buffer to CSI. And so on. The bad thing is
> > >     that the first buffer will be written twice and the first frame
> > >     is dropped even the queued buffer is sufficient.
> > >     So, I make some improvement here. Pass the next buffer to CSI
> > >     just follow starting the CSI. In this case, the first frame
> > >     will be stored in first buffer, second frame in second buffer.
> > >     This mothed is used to avoid dropping the first frame, it
> > >     would also drop frame when lacking of queued buffer.
> > >   * Fix: using a wrong mbus_code when getting the supported formats
> > >   * Change all fourcc to pixformat
> > >   * Change some function names
> > > 
> > > Changes in v3:
> > >   * Get rid of struct sun6i_csi_ops
> > >   * Move sun6i-csi to new directory drivers/media/platform/sunxi
> > >   * Merge sun6i_csi.c and sun6i_csi_v3s.c into sun6i_csi.c
> > >   * Use generic fwnode endpoints parser
> > >   * Only support a single subdev to make things simple
> > >   * Many complaintion fix
> > > 
> > > Changes in v2: 
> > >   * Change sunxi-csi to sun6i-csi
> > >   * Rebase to media_tree master branch 
> > > 
> > > Following is the 'v4l2-compliance -s -f' output, I have test this
> > > with both interlaced and progressive signal:
> > > 
> > > # ./v4l2-compliance -s -f
> > > v4l2-compliance SHA   : 6049ea8bd64f9d78ef87ef0c2b3dc9b5de1ca4a1
> > > 
> > > Driver Info:
> > >         Driver name   : sun6i-video
> > >         Card type     : sun6i-csi
> > >         Bus info      : platform:csi
> > >         Driver version: 4.15.0
> > >         Capabilities  : 0x84200001
> > >                 Video Capture
> > >                 Streaming
> > >                 Extended Pix Format
> > >                 Device Capabilities
> > >         Device Caps   : 0x04200001
> > >                 Video Capture
> > >                 Streaming
> > >                 Extended Pix Format
> > > 
> > > Compliance test for device /dev/video0 (not using libv4l2):
> > > 
> > > Required ioctls:
> > >         test VIDIOC_QUERYCAP: OK
> > > 
> > > Allow for multiple opens:
> > >         test second video open: OK
> > >         test VIDIOC_QUERYCAP: OK
> > >         test VIDIOC_G/S_PRIORITY: OK
> > >         test for unlimited opens: OK
> > > 
> > > Debug ioctls:
> > >         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> > >         test VIDIOC_LOG_STATUS: OK (Not Supported)
> > > 
> > > Input ioctls:
> > >         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
> > >         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
> > >         test VIDIOC_ENUMAUDIO: OK (Not Supported)
> > >         test VIDIOC_G/S/ENUMINPUT: OK
> > >         test VIDIOC_G/S_AUDIO: OK (Not Supported)
> > >         Inputs: 1 Audio Inputs: 0 Tuners: 0
> > > 
> > > Output ioctls:
> > >         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
> > >         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
> > >         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
> > >         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
> > >         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
> > >         Outputs: 0 Audio Outputs: 0 Modulators: 0
> > > 
> > > Input/Output configuration ioctls:
> > >         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
> > >         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
> > >         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
> > >         test VIDIOC_G/S_EDID: OK (Not Supported)
> > > 
> > > Test input 0:
> > > 
> > >         Control ioctls:
> > >                 test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
> > >                 test VIDIOC_QUERYCTRL: OK (Not Supported)
> > >                 test VIDIOC_G/S_CTRL: OK (Not Supported)
> > >                 test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
> > >                 test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
> > >                 test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
> > >                 Standard Controls: 0 Private Controls: 0
> > 
> > I'm not sure if your driver passes control queries to the subdev. It
> > did not originally, and I'm not sure you picked up the change from my
> > version of the driver. "Not supported" here seems to indicate that it
> > does not.
> > 
> > I'd be interested what's the recommended practice here. It sure helps
> > with some apps that expect to be able to modify various input controls
> > directly on the /dev/video# device. These are then supported out of the
> > box.
> > 
> > It's a one-line change. See:
> > 
> > https://www.kernel.org/doc/html/latest/media/kapi/v4l2-controls.html#in
> > heriting-controls
> 
> I think this is a feature and not affect the driver's main function.
> I just focused on making the CSI main function to work properly in 
> the initial version. Is this feature mandatory or most commonly used?

I agree here. Adding more and more features along the iterations is
just the best way to never get something merged.

Let's focus on a good basis that this driver provides, merge that, and
then build on top of it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180104/25330596/attachment.sig>
