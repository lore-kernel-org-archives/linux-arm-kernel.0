From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Sun, 19 Mar 2017 10:45:15 -0400
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170319095558.GP21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
 <1489884074.21659.7.camel@ndufresne.ca>
 <20170319095558.GP21222@n2100.armlinux.org.uk>
Message-ID: <1489934715.3388.3.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 19 mars 2017 ? 09:55 +0000, Russell King - ARM Linux a
?crit?:
> 2) would it also make sense to allow gstreamer's v4l2src to try
> setting
> ?? a these parameters, and only fail if it's unable to set it?? IOW,
> if
> ?? I use:
> 
> gst-launch-1.0 v4l2src device=/dev/video10 ! \
> ????????video/x-bayer,format=RGGB,framerate=20/1 ! ...
> 
> ?? where G_PARM says its currently configured for 25fps, but a S_PARM
> ?? with 20fps would actually succeed.

In current design, v4l2src will "probe" all possible formats, cache
this, and use this information for negotiation. So after the caps has
been probed, there will be no TRY_FMT or anything like this happening
until it's too late. You have spotted a bug though, it should be
reading back the parm structure to validate (and probably produce a
not-negotiated error here).

Recently, specially for the IMX work done by Pengutronix, there was
contributions to enhance this probing to support probing capabilities
that are not enumerable (e.g. interlacing, colorimetry) using TRY_FMT.
There is no TRY_PARM in the API to implement similar fallback. Also,
those ended up creating a massive disaster for slow cameras. We now
have UVC cameras that takes 6s or more to start. I have no other choice
but to rewrite that now. We will negotiate the non-enumerable at the
last minute with TRY_FMT (when the subset is at it's smallest). This
will by accident add support for this camera interface, but that wasn't
the goal. It would still fail with application that enumerates the
possible resolutions and framerate and let you select them with a drop-
down (like cheese). In general, I can only conclude that making
everything that matter enumerable is the only working way to go for
generic userspace. 

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170319/efd02a55/attachment.sig>
