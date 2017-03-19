From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 00:54:53 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <1489884074.21659.7.camel@ndufresne.ca>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
 <1489884074.21659.7.camel@ndufresne.ca>
Message-ID: <20170319005453.GN21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 08:41:14PM -0400, Nicolas Dufresne wrote:
> Le samedi 18 mars 2017 ? 20:43 +0000, Russell King - ARM Linux a
> ?crit?:
> > On Sat, Mar 18, 2017 at 12:58:27PM -0700, Steve Longerbeam wrote:
> > > Can you share your gstreamer pipeline? For now, until
> > > VIDIOC_ENUM_FRAMESIZES is implemented, try a pipeline that
> > > does not attempt to specify a frame rate. I use the attached
> > > script for testing, which works for me.
> > 
> > It's nothing more than
> > 
> > ? gst-launch-1.0 -v v4l2src ! <any needed conversions> ! xvimagesink
> > 
> > in my case, the conversions are bayer2rgbneon.? However, this only
> > shows
> > you the frame rate negotiated on the pads (which is actually good
> > enough
> > to show the issue.)
> > 
> > How I stumbled across though this was when I was trying to encode:
> > 
> > ?gst-launch-1.0 v4l2src device=/dev/video9 ! bayer2rgbneon ! \
> > ????????videoconvert ! x264enc speed-preset=1 ! avimux ! \
> > ????????filesink location=test.avi
> > 
> > I noticed that vlc would always say it was playing the resulting AVI
> > at 30fps.
> 
> In practice, I have the impression there is a fair reason why framerate
> enumeration isn't implemented (considering there is only 1 valid rate).

That's actually completely incorrect.

With the capture device interfacing directly with CSI, it's possible
_today_ to select:

* the CSI sink pad's resolution
* the CSI sink pad's resolution with the width and/or height halved
* the CSI sink pad's frame rate
* the CSI sink pad's frame rate divided by the frame drop factor

To put it another way, these are possible:

# v4l2-ctl -d /dev/video10 --list-formats-ext
ioctl: VIDIOC_ENUM_FMT
        Index       : 0
        Type        : Video Capture
        Pixel Format: 'RGGB'
        Name        : 8-bit Bayer RGRG/GBGB
                Size: Discrete 816x616
                        Interval: Discrete 0.040s (25.000 fps)
                        Interval: Discrete 0.048s (20.833 fps)
                        Interval: Discrete 0.050s (20.000 fps)
                        Interval: Discrete 0.053s (18.750 fps)
                        Interval: Discrete 0.060s (16.667 fps)
                        Interval: Discrete 0.067s (15.000 fps)
                        Interval: Discrete 0.080s (12.500 fps)
                        Interval: Discrete 0.100s (10.000 fps)
                        Interval: Discrete 0.120s (8.333 fps)
                        Interval: Discrete 0.160s (6.250 fps)
                        Interval: Discrete 0.200s (5.000 fps)
                        Interval: Discrete 0.240s (4.167 fps)
                Size: Discrete 408x616
<same intervals>
                Size: Discrete 816x308
<same intervals>
                Size: Discrete 408x308
<same intervals>

These don't become possible as a result of implementing the enums,
they're all already requestable through /dev/video10.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
