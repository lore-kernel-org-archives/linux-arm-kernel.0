From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Apr 2017 11:05:00 +0200
Subject: [PATCH v5 05/11] drm/sun4i: abstract a engine type
In-Reply-To: <20170423103754.50012-6-icenowy@aosc.io>
References: <20170423103754.50012-1-icenowy@aosc.io>
 <20170423103754.50012-6-icenowy@aosc.io>
Message-ID: <20170424090500.i3k6u7pcahc7m3hv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks a lot for that work.

On Sun, Apr 23, 2017 at 06:37:48PM +0800, Icenowy Zheng wrote:
> As we are going to add support for the Allwinner DE2 engine in sun4i-drm
> driver, we will finally have two types of display engines -- the DE1
> backend and the DE2 mixer. They both do some display blending and feed
> graphics data to TCON, so I choose to call them both "engine" here.
> 
> Abstract the engine type to a new struct with an ops struct, which contains
> functions that should be called outside the engine-specified code (in
> TCON, CRTC or TV Encoder code).
> 
> A dedicated Kconfig option is also added to control whether
> sun4i-backend-specified code (sun4i_backend.c and sun4i_layer.c) should
> be built. As we removed the codes in CRTC code that directly call the
> layer code, we can now extract the layer part and combine it with the
> backend part into a new module, sun4i-backend.ko.

While the code itself is good now, the patch mixes a few things that
would be better to be split in separate patches. I think it would be
better if you had patches organized like this:
  - Abstract the engine type by create the sunxi_engine structure and
    fixing all the callers.
  - Move the layers and backend files in the same module, and remove
    the now useless EXPORT_SYMBOLS.
  - Create a Kconfig option.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/d1d15dd2/attachment-0001.sig>
