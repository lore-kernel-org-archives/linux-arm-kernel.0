From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Mar 2015 12:57:18 +0100
Subject: [PATCH RFC 02/11] drm: bridge/dw_hdmi: use
 drm_hdmi_avi_infoframe_from_display_mode()
In-Reply-To: <551A629C.5010306@rock-chips.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfXa-0002uU-E3@rmk-PC.arm.linux.org.uk>
 <551A629C.5010306@rock-chips.com>
Message-ID: <20150331115718.GS24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 05:02:20AM -0400, Yang Kuankuan wrote:
> Besides, as you are going an dw_hdmi cleanups, I want to point another bugs
> that relate to the HDMI CTS test. There are somethings wrong with General
> Control Pack, as for now the encoder color depth is 8-bit packing mode,
> so the color depth only support 24 bits per pixel video, In this case the
> CD filed in GCP should set to "Color Depth Not indicated".

I'm not sure I follow.

According to the iMX6 documentation, setting the CD field to either 0000
or 0100 indicates that the color depth is 24 bits per pixel, 8 bits per
component, 8 bit packing mode - there's no documented difference between
these.

Are you saying that you wish to pass something other than 24 bpp video
to your HDMI encoder?

> In the end we should keep the *csc_color_depth(HDMI_CSC_SCALE)* &
> *color_depth(HDMI_VP_PR_CD)* to zero, code should modify like this GCP
> would test pass:

>From what you're describing, you want CD field = 0 and CSC_SCALE = 0.
It looks like hdmi_video_packetize() will set the CD field to zero if
hdmi_data.enc_color_depth = 0, but that would cause hdmi_video_sample()
and hdmi_video_csc() to fail.  Maybe those two functions should be fixed
to accept a color depth of zero, and maybe you need to set
enc_color_depth to 0?

Interestingly, HDMI_CSC_SCALE_CSC_COLORDE_PTH_24BPP is defined to be
zero, but again, in the iMX6 data, it could take a value of either
0x00 or 0x40.  I think hdmi_video_csc() should set this to 0x40 if
hdmi_data.enc_color_depth = 0, and 0x40 for hdmi_data.enc_color_depth = 8.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
