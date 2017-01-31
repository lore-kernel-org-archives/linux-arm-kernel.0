From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 10:30:19 +0000
Subject: [PATCH v3 17/24] media: imx: Add CSI subdev driver
In-Reply-To: <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170131103019.GT27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:35PM -0800, Steve Longerbeam wrote:
> This is a media entity subdevice for the i.MX Camera
> Serial Interface module.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---

The lack of s_frame_interval/g_frame_interval in this driver means:

media-ctl -v -d /dev/media1 --set-v4l2 '"imx6-mipi-csi2":1[fmt:SGBRG8/512x512 at 1/30]'

Opening media device /dev/media1
Enumerating entities
Found 29 entities
Enumerating pads and links
Setting up format SGBRG8 512x512 on pad imx6-mipi-csi2/1
Format set: SGBRG8 512x512
Setting up frame interval 1/30 on entity imx6-mipi-csi2
Unable to set frame interval: Inappropriate ioctl for device (-25)Unable to setup formats: Inappropriate ioctl for device (25)

which causes the setup of the next element in the chain to also fail
(because the above media-ctl command doesn't set the sink on the
ipu1 csi0 mux.)

It seems to me that without the frame interval supported throughout the
chain, there's no way for an application to properly negotiate the
capture parameters via the "try" mechanism, since it has no idea whether
the frame rate it wants is supported throughout the subdev chain.  Eg,
the sensor may be able to do 100fps but there could be something in the
pipeline that restricts it due to bandwidth.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
