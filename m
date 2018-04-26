From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2018 09:52:52 +0200
Subject: [PATCH 1/2 v4] drm/pl111: Support the Versatile Express
In-Reply-To: <4255fd6b-caf7-1347-b97b-ab7b229a08ba@arm.com>
References: <20180423072017.6690-1-linus.walleij@linaro.org>
 <4255fd6b-caf7-1347-b97b-ab7b229a08ba@arm.com>
Message-ID: <CACRpkdYpMsGOTPU81cO92DFSrzt659UmD_p5uKehBWnZk-cjnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 2:04 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> I've given this a go on the nearest VExpress (with CA15_A7 tile) and sadly
> it doesn't quite work for me :( With the HDLCD driver configure out, the
> PL111 driver seems to repeatedly defer somewhere past
> pl111_versatile_init():
>
> root at jet-set-radio:~# dmesg | grep -i lcd
> [    2.739358] drm-clcd-pl111 1c1f0000.clcd: sysreg has not yet probed
> [    3.406534] drm-clcd-pl111 1c1f0000.clcd: initializing Versatile Express
> PL111
> [    3.428218] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
> [    3.898768] drm-clcd-pl111 1c1f0000.clcd: initializing Versatile Express
> PL111
> [    3.920441] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
> [   10.896158] drm-clcd-pl111 1c1f0000.clcd: initializing Versatile Express
> PL111
> [   10.917839] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
> [   18.513233] drm-clcd-pl111 1c1f0000.clcd: initializing Versatile Express
> PL111
> [   18.535007] drm-clcd-pl111 1c1f0000.clcd: DVI muxed to motherboard CLCD
> root at jet-set-radio:~# ls /sys/bus/amba/drivers/drm-clcd-pl111/
> bind  uevent  unbind
>
>
> There's no obvious indication of what's missing, but it does still manage to
> do enough to make the external display come on (still showing the
> motherboard PoST screen). By comparison, the old fbdev driver probes OK and
> thinks it's set up a 640x480 console but doesn't actually turn the monitor
> on (and HDLCD doesn't probe at all due to vexpress-v2p-ca15_a7.dts lacking
> any graph endpoint).
>
> Config attached, just in case I'm missing something trivially dumb.

Hm you definately need CONFIG_CMA and CONFIG_DMA_CMA so
the driver actually uses the special memory.

I have all these:

config-drm: config-base
        $(CURDIR)/scripts/config --file $(config_file) \
        --disable FB_ARMCLCD \
        --enable CMA \
        --enable CMA_DEBUG \
        --enable CMA_DEBUGFS \
        --enable DMA_CMA \
        --enable DRM \
        --enable DRM_PL111 \
        --enable FRAMEBUFFER_CONSOLE \
        --enable DRM_PANEL \
        --enable DRM_PANEL_SIMPLE \
        --enable DRM_BRIDGE \
        --enable DRM_PANEL_BRIDGE \
        --enable DRM_SII902X \
        --enable LOGO

Please try with the stuff above, when I switch the mainline platforms
I plan to update the defconfigs with all the above.

Yours,
Linus Walleij
