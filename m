From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 20:02:54 +0100
Subject: [PATCH] drm/sun4i: Only count TCON endpoints as valid outputs
In-Reply-To: <20161116093732.12828-1-wens@csie.org>
References: <20161116093732.12828-1-wens@csie.org>
Message-ID: <20161117190254.d4doghspvz6ma6x2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 05:37:31PM +0800, Chen-Yu Tsai wrote:
> The sun4i DRM driver counts the number of endpoints it found and
> registers the whole DRM pipeline if any endpoints are found.
> 
> However, if the TCON and its child endpoints (LCD panels, TV encoder,
> HDMI encoder, MIPI DSI encoder, etc.) aren't found, that means we
> don't have any usable CRTCs, and the display pipeline is incomplete
> and useless.

If some node set as available is not probed, then yes, it does, but
I'm not really sure how it's a problem. Quite the opposite actually.

> The whole DRM display pipeline should only be registered and enabled
> if there are proper outputs available.

Unless I've misunderstood what you're saying, we could have the
writeback for example that would just need the display engine.

> The debug message "Queued %d outputs on pipeline %d\n" is also telling.
> 
> This patch makes the driver only count enabled TCON endpoints. If
> none are found, the DRM pipeline is not used. This avoids screwing
> up the simple framebuffer provided by the bootloader in cases where
> we aren't able to support the display with the DRM subsystem, due
> to lack of panel or bridge drivers, or just lack of progress.

The framebuffer is removed only at bind time, which means that all the
drivers have probed already. Lack of progress isn't an issue here,
since the node simply won't be there, and we wouldn't have it in the
component lists. And lack of drivers shouldn't be an issue either,
since in order for bind to be called, all the drivers would have
gone through their probe.

So I'm not really sure what it fixes.
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/9e378540/attachment.sig>
