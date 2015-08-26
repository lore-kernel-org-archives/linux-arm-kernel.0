From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 15:39:28 +0200
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbJppuA6ZyciNAGfSgrf4M2THVHggzuZYSqORjy2JBp_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 4:18 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This commit adds support for UniPhier outer cache controller.
> All the UniPhier SoCs are equipped with the L2 cache, while the L3
> cache is currently only integrated on PH1-Pro5 SoC.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Wow it is really a custom L2$ controller. Wow. Just wow. That's
really brave, given all the problems we've seen in l2x0.

> +UniPhier SoCs are integrated with a level 2 cache controller that resides
> +outside of the ARM cores, some of them also have a level 3 cache controller.
> +
> +Required properties:
> +- compatible: should be one of the followings:
> +       "socionext,uniphier-l2-cache"   (L2 cache)
> +       "socionext,uniphier-l3-cache"   (L3 cache)

Refer to and use the 3.7.3 ePAPR v1.1 specification too:
https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf

cache-unified and cache-level are *not* optional and should be required.

So:

> +The L2 cache must exist to use the L3 cache; adding only an L3 cache device
> +node to the device tree causes the initialization failure of the whole outer
> +cache system.
> +
> +Example:
> +       l2-cache at 500c0000 {
> +               compatible = "socionext,uniphier-l2-cache";
> +               reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
> +                     <0x506c0000 0x400>;

cache-unified;
cache-level = <2>;

> +       /* Not all of UniPhier SoCs have L3 cache */
> +       l3-cache at 500c8000 {
> +               compatible = "socionext,uniphier-l3-cache";
> +               reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
> +                     <0x506c8000 0x400>;

cache-unified;
cache-level = <3>;

(I'm just assuming this cache is unified, anything else would be baffling.)

Further the ePAPR spec optionally supports specifying things like the
cache size, number of sets, block size and line size, unless this can
be hard coded.

Yours,
Linus Walleij
