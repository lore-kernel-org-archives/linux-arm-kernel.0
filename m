From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Sat, 18 Mar 2017 20:41:14 -0400
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170318204324.GM21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
Message-ID: <1489884074.21659.7.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le samedi 18 mars 2017 ? 20:43 +0000, Russell King - ARM Linux a
?crit?:
> On Sat, Mar 18, 2017 at 12:58:27PM -0700, Steve Longerbeam wrote:
> > Can you share your gstreamer pipeline? For now, until
> > VIDIOC_ENUM_FRAMESIZES is implemented, try a pipeline that
> > does not attempt to specify a frame rate. I use the attached
> > script for testing, which works for me.
> 
> It's nothing more than
> 
> ? gst-launch-1.0 -v v4l2src ! <any needed conversions> ! xvimagesink
> 
> in my case, the conversions are bayer2rgbneon.? However, this only
> shows
> you the frame rate negotiated on the pads (which is actually good
> enough
> to show the issue.)
> 
> How I stumbled across though this was when I was trying to encode:
> 
> ?gst-launch-1.0 v4l2src device=/dev/video9 ! bayer2rgbneon ! \
> ????????videoconvert ! x264enc speed-preset=1 ! avimux ! \
> ????????filesink location=test.avi
> 
> I noticed that vlc would always say it was playing the resulting AVI
> at 30fps.

In practice, I have the impression there is a fair reason why framerate
enumeration isn't implemented (considering there is only 1 valid rate).
Along with the norm fallback, GStreamer could could also consider the
currently set framerate as returned by?VIDIOC_G_PARM. At the same time,
implementing that enumeration shall be straightforward, and will make a
large amount of existing userspace work.

regards,
Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170318/9bd83c41/attachment.sig>
