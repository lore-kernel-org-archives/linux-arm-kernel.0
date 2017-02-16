From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2017 19:09:31 +0000
Subject: [PATCH v4 20/36] media: imx: Add CSI subdev driver
In-Reply-To: <fa52c59e-f582-672c-8df0-2b959f880fa1@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-21-git-send-email-steve_longerbeam@mentor.com>
 <20170216115206.GL27312@n2100.armlinux.org.uk>
 <20170216124027.GM27312@n2100.armlinux.org.uk>
 <fa52c59e-f582-672c-8df0-2b959f880fa1@gmail.com>
Message-ID: <20170216190931.GV27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 10:44:16AM -0800, Steve Longerbeam wrote:
> On 02/16/2017 04:40 AM, Russell King - ARM Linux wrote:
> >[    8.012191] imx_media_common: module is from the staging directory, the quality is unknown, you have been warned.
> >[    8.018175] imx_media: module is from the staging directory, the quality is unknown, you have been warned.
> >[    8.748345] imx-media: Registered subdev ipu1_csi0_mux
> >[    8.753451] imx-media: Registered subdev ipu2_csi1_mux
> >[    9.055196] imx219 0-0010: detected IMX219 sensor
> >[    9.090733] imx6_mipi_csi2: module is from the staging directory, the quality is unknown, you have been warned.
> >[    9.092247] imx-media: Registered subdev imx219 0-0010
> >[    9.334338] imx-media: Registered subdev imx6-mipi-csi2
> >[    9.372452] imx_media_capture: module is from the staging directory, the quality is unknown, you have been warned.
> >[    9.378163] imx_media_capture: module is from the staging directory, the quality is unknown, you have been warned.
> >[    9.390033] imx_media_csi: module is from the staging directory, the quality is unknown, you have been warned.
> >[    9.394362] imx-media: Received unknown subdev ipu1_csi0
> 
> The root problem is here. I don't know why the CSI entities are not
> being recognized. Can you share the changes you made?

No, it's not the root problem that's causing the BUG/etc, but it is
_a_ problem.  Nevertheless, it's something I fixed - disconnecting
the of_node from the struct device needed one other change in the
imx-media code that was missing at this time.

However, that's no excuse what so ever for the BUG_ON() and lack of
error cleanup (causing use-after-free, which is just another way of
saying "data corruption waiting to happen") that I identified.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
