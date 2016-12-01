From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 01 Dec 2016 11:28:45 +0200
Subject: How should we group related devices in DT ? (was Re: [PATCH v7 0/8]
 drm: sun8i: Add DE2 HDMI video support)
In-Reply-To: <20161201091313.th7nucjmvtuolqza@lukather>
References: <cover.1480414715.git.moinejf@free.fr> <2039137.LtCOH6bs2I@avalon>
 <20161201091313.th7nucjmvtuolqza@lukather>
Message-ID: <2679960.kPaBMLjofm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday 01 Dec 2016 10:13:13 Maxime Ripard wrote:

[snip]

> The earlier Allwinner SoCs (with the old display engine), we had some
> SoCs with multiple instances of the display engine and TCON (the
> display engine roughly implementing the planes, the TCON the
> CRTC. Roughly.). However, those were sharing some encoders (HDMI,
> DSI) after that.
> 
> So we need to have a single DRM device taking care of the multiple
> display engines, which essentialy means that we have to decouple the
> DRM device from the display engine. This was done in the earlier
> designs using an additional node with a list of phandles to the
> display engines in the system, and obviously, I'd prefer to have some
> consistency and reuse the same thing.

I believe this problem isn't limited to sunxi and should be addressed in a 
more generic way. How should we describe in the device tree that multiple 
instances of a device unrelated from a control point of view are related at 
the hardware level ? There are multiple reasons why we need this, and here are 
a few.

- As described above, unrelated display controller instances that share 
encoders at their output need to be exposed to userspace as a single DRM 
device. This is also the case on Renesas platforms (where the display engines 
are independent except for the "small" detail that output routing is 
controlled through the first display engine).

- On Renesas platforms again a radio-related SPI receiver has multiple 
independent channels that each have their own registers, clocks and 
interrupts, but share the same physical clock and sync pins. They are used to 
receive multiple channels of the same data stream and must be exposed as a 
single V4L2 device to userspace. A generic DT binding RFC is available at 
http://www.spinics.net/lists/devicetree/msg152414.html.

> But the current approach doesn't work and will require some DT
> modifications if that case happens again, which we can't do because of
> the DT ABI.

-- 
Regards,

Laurent Pinchart
