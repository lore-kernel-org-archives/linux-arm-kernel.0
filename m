From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 10:24:51 -0800
Subject: [PATCH 05/11] drm/sun4i: Initialize crtc from tcon bind function
In-Reply-To: <20170223080543.6659-6-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
 <20170223080543.6659-6-wens@csie.org>
Message-ID: <20170223182451.vpzuf3pey3jly4te@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 04:05:37PM +0800, Chen-Yu Tsai wrote:
> The tcon provides part of the functionality of the crtc, and also
> provides the device node for the output port of the crtc. To be able
> to use drm_of_find_possible_crtcs(), all crtc must be initialized before
> any downstream encoders. The other part of the crtc is the display
> backend.
> 
> The Rockchip DRM driver does this by first binding all vops, which is
> their crtc, and this step also creates the crtc objects. Then all
> remaining hardware components are bound. With the Allwinner display
> pipeline, we have multiple components comprising the crtc, and varying
> depths of the display pipeline. Since components are added with a depth
> first search of the of_graph, we can initialize the crtc object within
> the tcon bind function. Since the backend precedes the tcon, and the
> backends cannot be muxed or switched around, we can be sure that the
> associated backend is already initialized.
> 
> This patch also moves the crtc pointer from the main drm_device data to
> the tcon device data. Besides the crtc callbacks, the crtc structure is
> only used within the tcon driver to signal vblank events from its
> interrupt handler.
> 
> As the crtc and layer bits are now called from the tcon bits, we must
> move them from the sun4i-drm module to the sun4i-tcon module to avoid
> circular dependencies between the two modules. This is because sun4i-drm
> also calls into sun4i-tcon.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/276e23a9/attachment.sig>
