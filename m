From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Jul 2018 16:58:48 +0800
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180709080724.3ekqb45fsjubvhcm@flea>
References: <20180706124628.3192421-1-arnd@arndb.de>
 <20180709080724.3ekqb45fsjubvhcm@flea>
Message-ID: <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 4:07 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
>> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>>
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>>
>> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
>> the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
>> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
>>
>> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
>> and detach it from the mixer module, I could not tell which way is more
>> appropriate here.
>
> If that's easily doable, then yeah, that would be the preferred option
> I guess. Jernej? Chen-Yu? Any opinion on this?

Yeah, that definitely works for me. Having TCON TOP being part of the core
sun4i-drm makes more sense. The TCON code will likely call into it later on
when Jernej adds the encoder muxing code.

I wonder if we shouldn't just build the whole display engine code, excluding
downstream encoders (HDMI, DSI, TV) into one module. That would also fix the
issue that DRM_SUN4I_BACKEND has to be built-in if DRM_SUN4I is built-in.
That might be overkill though, given that one day we should be able to get
rid of the frontend check.

Here's a list of the size of various parts of this driver, built for ARMv7:

Common stuff:
   text    data     bss     dec     hex filename
   5021     344       0    5365    14f5 drivers/gpu/drm/sun4i/sun4i_drv.o
   1058       0       0    1058     422 drivers/gpu/drm/sun4i/sun4i_layer.o
    192       4       0     196      c4
drivers/gpu/drm/sun4i/sun4i_framebuffer.o
   1704       0       0    1704     6a8 drivers/gpu/drm/sun4i/sun4i_crtc.o
   1221       0       0    1221     4c5 drivers/gpu/drm/sun4i/sun4i_dotclock.o
   1192      28       0    1220     4c4 drivers/gpu/drm/sun4i/sun4i_lvds.o
   1583      92       0    1675     68b drivers/gpu/drm/sun4i/sun4i_rgb.o
  10088     248       0   10336    2860 drivers/gpu/drm/sun4i/sun4i_tcon.o
   1690     104       0    1794     702 drivers/gpu/drm/sun4i/sun6i_drc.o
  23749     820       0   24569    5ff9 (TOTALS)

DE 1.0:
   text    data     bss     dec     hex filename
   3596     248       0    3844     f04 drivers/gpu/drm/sun4i/sun4i_frontend.o
   8735     248       0    8983    2317 drivers/gpu/drm/sun4i/sun4i_backend.o
  12331     496       0   12827    321b (TOTALS)

DE 2.0:
   text    data     bss     dec     hex filename
   4040     248       0    4288    10c0 drivers/gpu/drm/sun4i/sun8i_mixer.o
   2620      28       0    2648     a58 drivers/gpu/drm/sun4i/sun8i_ui_layer.o
   1500       0       0    1500     5dc drivers/gpu/drm/sun4i/sun8i_ui_scaler.o
   2780      28       0    2808     af8 drivers/gpu/drm/sun4i/sun8i_vi_layer.o
  12612       0       0   12612    3144 drivers/gpu/drm/sun4i/sun8i_vi_scaler.o
    367       0       0     367     16f drivers/gpu/drm/sun4i/sun8i_csc.o
  23919     304       0   24223    5e9f (TOTALS)

TCON TOP:
   text    data     bss     dec     hex filename
   2623     104       0    2727     aa7 drivers/gpu/drm/sun4i/sun8i_tcon_top.o
   2623     104       0    2727     aa7 (TOTALS)

DE 1.0 HDMI:
   text    data     bss     dec     hex filename
    913       0       0     913     391
drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.o
   5543     104       0    5647    160f drivers/gpu/drm/sun4i/sun4i_hdmi_enc.o
   2583       0       0    2583     a17 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.o
   1326       0       0    1326     52e
drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.o
  10365     104       0   10469    28e5 (TOTALS)

MIPI DSI:
   text    data     bss     dec     hex filename
   1990     144       0    2134     856 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.o
   5921     132       0    6053    17a5 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.o
   7911     276       0    8187    1ffb (TOTALS)

DW HDMI:
   text    data     bss     dec     hex filename
   1774     104       0    1878     756 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.o
   1189       0       0    1189     4a5
drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.o
   4877     144       0    5021    139d drivers/gpu/drm/sun4i/sun8i_hdmi_phy.o
   7840     248       0    8088    1f98 (TOTALS)

So it seems better to keep various parts as separate modules.

The "data" column makes me wonder if we've constify-ed all possible data
structures yet.

Regards
ChenYu
