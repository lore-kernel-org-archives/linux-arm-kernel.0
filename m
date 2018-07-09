From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Jul 2018 17:17:35 +0800
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180709091524.sfamfdmbmwclmegj@flea>
References: <20180706124628.3192421-1-arnd@arndb.de>
 <20180709080724.3ekqb45fsjubvhcm@flea>
 <CAGb2v64HmXRK19-ahv624F8mpNCt21ri3AaVEiB+Gw9GsVeb=Q@mail.gmail.com>
 <20180709091524.sfamfdmbmwclmegj@flea>
Message-ID: <CAGb2v66HX9YBzPsUjyUmf3XBufnipZRmfkZKnGJCh4Mh89WvqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2018 at 5:15 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Mon, Jul 09, 2018 at 04:58:48PM +0800, Chen-Yu Tsai wrote:
>> On Mon, Jul 9, 2018 at 4:07 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> > On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
>> >> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
>> >> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
>> >>
>> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
>> >> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
>> >>
>> >> This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol, building
>> >> the sun8i_tcon_top module the same way as the core sun4i-drm module whenever
>> >> DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
>> >>
>> >> Alternatively, we could always build sun8i_tcon_top.ko along with sun4-drm.ko
>> >> and detach it from the mixer module, I could not tell which way is more
>> >> appropriate here.
>> >
>> > If that's easily doable, then yeah, that would be the preferred option
>> > I guess. Jernej? Chen-Yu? Any opinion on this?
>>
>> Yeah, that definitely works for me. Having TCON TOP being part of the core
>> sun4i-drm makes more sense. The TCON code will likely call into it later on
>> when Jernej adds the encoder muxing code.
>>
>> I wonder if we shouldn't just build the whole display engine code, excluding
>> downstream encoders (HDMI, DSI, TV) into one module. That would also fix the
>> issue that DRM_SUN4I_BACKEND has to be built-in if DRM_SUN4I is built-in.
>> That might be overkill though, given that one day we should be able to get
>> rid of the frontend check.
>
> We can't really do that (or at least without rewriting a significant
> part of the driver), since we can have only one
> module_init/module_exit function per module, and we have one
> per-hardware block.

Right. That would require some serious plumbing to register all the drivers.

ChenYu
