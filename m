From: robh@kernel.org (Rob Herring)
Date: Thu, 15 Oct 2015 08:58:53 -0500
Subject: [PATCH 01/13] ARM: add some L220 DT settings
In-Reply-To: <1444916813-31024-2-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_JsqJRYmAdwOUbRE-uRjWG2KNovMXricSC1JT2RGxnvK8YhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 8:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The RealView ARM11MPCore enables parity, eventmon and shared
> override in the cache controller through its current boardfile,
> but the code and DT bindings for the ARM L220 is currently
> lacking the ability to set this up from DT. Add the required
> bool parameters.
>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I know this patch mixes code and DT changes but it is silly to
> split such a small patch. Will submit this to Russell's patch
> tracker if it looks OK to the DT people. (Or if they are quiet.)
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt | 10 ++++++----
>  arch/arm/mm/cache-l2x0.c                       | 15 +++++++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index 06c88a4d28ac..4d262e9b3464 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -67,12 +67,14 @@ Optional properties:
>    disable if zero.
>  - arm,prefetch-offset : Override prefetch offset value. Valid values are
>    0-7, 15, 23, and 31.
> -- arm,shared-override : The default behavior of the pl310 cache controller with
> -  respect to the shareable attribute is to transform "normal memory
> -  non-cacheable transactions" into "cacheable no allocate" (for reads) or
> -  "write through no write allocate" (for writes).
> +- arm,shared-override : The default behavior of the PL220 or PL310 cache

PL220 is something else:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0249b/CHDIIEAD.html


> +  controllers with respect to the shareable attribute is to transform "normal
> +  memory non-cacheable transactions" into "cacheable no allocate" (for reads)
> +  or "write through no write allocate" (for writes).

I seem to recall the PL310 TRM says this bit is different from the
L220 or the default is.

>    On systems where this may cause DMA buffer corruption, this property must be
>    specified to indicate that such transforms are precluded.
> +- arm,parity-enable : enable parity checking on the L2 cache (PL220 only).

PL310 has parity.

> +- arm,eventmon-enable : enable the event monitor on the L2 cache (PL220 only).

and eventmon.

There's a slight problem here in that you can turn on these with DT,
but you can't turn them off as absence means don't touch. Maybe a
value of 0 should be allowed for disabling.

>  - prefetch-data : Data prefetch. Value: <0> (forcibly disable), <1>
>    (forcibly enable), property absent (retain settings set by firmware)
>  - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 493692d838c6..d4e9fa2594f3 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1060,6 +1060,21 @@ static void __init l2x0_of_parse(const struct device_node *np,
>                 val |= (dirty - 1) << L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT;
>         }
>
> +       if (of_property_read_bool(np, "arm,parity-enable")) {
> +               mask &= ~L2C_AUX_CTRL_PARITY_ENABLE;
> +               val |= L2C_AUX_CTRL_PARITY_ENABLE;
> +       }
> +
> +       if (of_property_read_bool(np, "arm,eventmon-enable")) {
> +               mask &= ~L2C_AUX_CTRL_EVTMON_ENABLE;
> +               val |= L2C_AUX_CTRL_EVTMON_ENABLE;
> +       }
> +
> +       if (of_property_read_bool(np, "arm,shared-override")) {
> +               mask &= ~L2C_AUX_CTRL_SHARED_OVERRIDE;
> +               val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
> +       }
> +
>         ret = l2x0_cache_size_of_parse(np, aux_val, aux_mask, &assoc, SZ_256K);
>         if (ret)
>                 return;
> --
> 2.4.3
>
