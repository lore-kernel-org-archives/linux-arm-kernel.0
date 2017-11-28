From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:21:05 +0100
Subject: [PATCH 02/17] drm/sun4i: Start using layer id in DE2 driver
In-Reply-To: <20171127205750.19277-3-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-3-jernej.skrabec@siol.net>
Message-ID: <20171128202105.rrwldhr4e4n3x4ya@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:57:35PM +0100, Jernej Skrabec wrote:
> Till now, plane selection was hardcoded to first overlay in first UI
> channel.
> 
> It turns out that overlays don't fit well in current DRM design, because
> they can't be blended together or scaled independetly when they are set
> to same channel.
> 
> Beause of that, always use only first overlay in each channel. This
> simplifies things, since layer parameter can be then used as channel
> selection.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_layer.c |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 31 +++++++++++--------------------
>  2 files changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_layer.c b/drivers/gpu/drm/sun4i/sun8i_layer.c
> index 23810ff72684..5b2d45a9db8a 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_layer.c
> @@ -126,7 +126,7 @@ struct drm_plane **sun8i_layers_init(struct drm_device *drm,
>  			return ERR_CAST(layer);
>  		};
>  
> -		layer->id = i;
> +		layer->id = mixer->cfg->vi_num + i;
>  		planes[i] = &layer->plane;
>  	};

So we had pretty much the same intent here :)

But I really feel we should model the hardware and have both the
channel and layer IDs. Obviously, at (that patch) moment, we don't
have support for multiple layers per channel, but eventually we should
really model the hardware as much as possible.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/07c84359/attachment-0001.sig>
