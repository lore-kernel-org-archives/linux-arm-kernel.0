From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Mar 2017 20:43:24 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
Message-ID: <20170318204324.GM21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 12:58:27PM -0700, Steve Longerbeam wrote:
> Can you share your gstreamer pipeline? For now, until
> VIDIOC_ENUM_FRAMESIZES is implemented, try a pipeline that
> does not attempt to specify a frame rate. I use the attached
> script for testing, which works for me.

It's nothing more than

  gst-launch-1.0 -v v4l2src ! <any needed conversions> ! xvimagesink

in my case, the conversions are bayer2rgbneon.  However, this only shows
you the frame rate negotiated on the pads (which is actually good enough
to show the issue.)

How I stumbled across though this was when I was trying to encode:

 gst-launch-1.0 v4l2src device=/dev/video9 ! bayer2rgbneon ! \
	videoconvert ! x264enc speed-preset=1 ! avimux ! \
	filesink location=test.avi

I noticed that vlc would always say it was playing the resulting AVI
at 30fps.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
