From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 20 Oct 2017 13:53:11 +0300
Subject: [PATCH 2/2 v3] drm: bridge: Add THS8134A/B support to dumb VGA DAC
In-Reply-To: <20171020065941.3877-1-linus.walleij@linaro.org>
References: <20171020065941.3877-1-linus.walleij@linaro.org>
Message-ID: <4461777.gksfa5PW48@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Friday, 20 October 2017 09:59:41 EEST Linus Walleij wrote:
> This extends the dumb VGA DAC bridge to handle the THS8134A
> and THS8134B VGA DACs in addition to those already handled.
> 
> The THS8134A, THS8134B and as it turns out also THS8135 need to
> have data clocked out at the negative edge of the clock pulse,
> since they clock it into the DAC at the positive edge (so by
> then it needs to be stable) so we need some extra logic to flag
> this on the connector to the driver.
> 
> The semantics of the flag DRM_BUS_FLAG_PIXDATA_NEGEDGE in
> <drm/drm_connector.h> clearly indicates that this flag tells
> when to *drive* the data, not when the receiver *reads* it,
> so the TI variants needs to be handled like this.
> 
> Introduce a variant struct and contain the information there,
> and add a bit of helpful comments about how this works so
> people will get it right when adding new DACs or connectiong
> new display drivers to DACs.
> 
> The fact that THS8135 might be working on some systems today
> is probably due to the fact that the display driver cannot
> configure when the data is clocked out and the electronics
> have simply been designed around it so it works anyways.
> 
> The phenomenon is very real on the ARM reference designs using
> PL111 where the hardware can control which edge to push out
> the data.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Move const specifier.
> - Cut one line of code assigning bus flags.
> - Preserve the "ti,ths8135" compatible for elder device trees.
> ChangeLog v1->v2:
> - Alphabetize includes
> - Use a u32 with the bus polarity flags and just encode the
>   polarity using the DRM define directly.
> - Rename vendor_data to vendor_info.
> - Simplify assignment of the flag as it is just a simple
>   u32 now.
> - Probe all TI variants on the "ti,ths813x" wildcard for now,
>   we only need to know that the device is in this family to
>   set the clock edge flag right.
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 55 +++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 831a606c4706..2622e2f778d1
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c

[snip]

> @@ -55,7 +65,8 @@ static int dumb_vga_get_modes(struct drm_connector
> *connector) }
> 
>  	drm_mode_connector_update_edid_property(connector, edid);
> -	return drm_add_edid_modes(connector, edid);
> +	connector->display_info.bus_flags |= vga->variant->clk_edge_latch;
> +	retturn drm_add_edid_modes(connector, edid);

Have you compiled this ?

>  fallback:
>  	/*

[snip]

-- 
Regards,

Laurent Pinchart
