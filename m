From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Jul 2018 17:33:09 +0200
Subject: [PATCH v2] drm/sun4i: sun8i: Avoid clearing blending order at
 each atomic commit
In-Reply-To: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
References: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180717153309.bhxw6gdeyz7lwq7s@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 02:25:22PM +0200, Paul Kocialkowski wrote:
> Blending order is set based on the z position of each DRM plane. The
> blending order register is currently cleared at each atomic DRM commit,
> with the intent that each committed plane will set the appropriate
> bits (based on its z-pos) when enabling the plane.
> 
> However, it sometimes happens that a particular plane is left unchanged
> by an atomic commit and thus will not be configured again. In that
> scenario, blending order is cleared and only the bits relevant for the
> planes affected by the commit are set. This leaves the planes that did
> not change without their blending order set in the register, leading
> to that plane not being displayed.
> 
> Instead of clearing the blending order register at every atomic commit,
> this change moves the register's initial clear at bind time and only
> clears the bits for a specific plane when disabling it or changing its
> zpos.
> 
> This way, planes that are left untouched by a DRM atomic commit are
> no longer disabled.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/d61f83d3/attachment.sig>
