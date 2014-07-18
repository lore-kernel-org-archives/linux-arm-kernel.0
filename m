From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Jul 2014 10:20:47 +0100
Subject: [PATCH v10 01/11] irq: gic: support hip04 gic
In-Reply-To: <1404957850-13340-2-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140718092046.GD25180@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 03:04:00AM +0100, Haojian Zhuang wrote:
> There's a little difference between ARM GIC and HiP04 GIC.

Given that we can't target interrupts correctly without this patch, and
that the GIC in a HiP04 system can't claim compatibility with any other
GIC, I'd call this a major difference.

>
> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> 8 cores at most. So the difination on GIC_DIST_TARGET registers are
> different since CPU interfaces are increased from 8-bit to 16-bit.
>
> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> support 1020 interrupts at most.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   1 +
>  drivers/irqchip/irq-gic.c                     | 141 +++++++++++++++++++-------
>  2 files changed, 108 insertions(+), 34 deletions(-)

[...]

> +static bool gic_is_standard(struct gic_chip_data *gic_data)
> +{
> +       return (gic_data->nr_cpu_if == 8);
> +}
> +
> +static u32 irqs_per_target_reg(struct gic_chip_data *gic_data)
> +{
> +       return (32 / gic_data->nr_cpu_if);
> +}
> +
> +static u32 irq_to_target_reg(struct gic_chip_data *gic_data, u32 irq)
> +{
> +       if (!gic_is_standard(gic_data))
> +               irq *= 2;

If the function is called gic_is_standard, then the only thing we should
know here is whether the GIC follows the GIC standard, not how it
differs from the standard.

Please rename this function to something like gicd_has_16_bit_targets or
anything else that clearly defines what you're ttrying to derive from
it.

Thanks,
Mark.
