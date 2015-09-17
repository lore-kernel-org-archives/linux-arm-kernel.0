From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 17 Sep 2015 10:38:41 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1442474516.6617.6.camel@pengutronix.de> (Philipp Zabel's message
 of "Thu, 17 Sep 2015 09:21:56 +0200")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
 <m3a8su4llv.fsf@t19.piap.pl>
 <20150910104930.GI21084@n2100.arm.linux.org.uk>
 <1442474516.6617.6.camel@pengutronix.de>
Message-ID: <m3k2rp1lv2.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <p.zabel@pengutronix.de> writes:

> The IDMAC has a few funny restrictions for multiplanar formats, and the
> current code silently assumes that the U and V planes follow right after
> Y.
>
> I have a patch to enforce the same base address:
> http://lists.freedesktop.org/archives/dri-devel/2015-August/089293.html
> but it still doesn't check the offset/pitch limitations properly.

Do you mean the current code as in e.g. v4.2?
I'm passing it (the i.MX6 IMX DRM overlay) a 1024x768 buffer:

ipu_plane_mode_set pitches 1024 512 512 0 offsets 0 786432 983040 0

so the U and V planes closely follow Y, and it doesn't work. The screen
is green to magenta, sometimes there are diagonal stripes (color only,
Y is fine).

Also, e.g. mplayer shows a greenish output.

I've posted a short test program:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/369988.html

You will need to set xv_port = 0 (it will then use the first
YUV420-capable adapter, which on my system is IMX DRM overlay) and you
may want to stick "XSync(display, 0);" after the XvShmPutImage() call.

Also, you may change the "memset(image->data, count, image->data_size)"
into something smaller, e.g. to a subset of Y plane, leaving UV alone.
For example:
	memset(image->data, count % 0x100, 12345);
	memset(image->data + image->pitches[0] * h, 0, (image->pitches[1] + image->pitches[2]) * h / 2);

will set the first 12345 bytes of Y plane, while the U and V will be
zero.

Thanks for looking into this.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
