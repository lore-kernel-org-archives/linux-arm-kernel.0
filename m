From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 23 Feb 2011 15:59:42 +0900
Subject: [PATCH 4/5] ARM: s5pv310: update IRQ combiner to use EOI in
	parent chip
In-Reply-To: <1298302096-21275-5-git-send-email-will.deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-5-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTimiPEsb_S3tv+yPOr=p8UageK_-er9HkjM10ro5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Kyungmin Park <kyungmin.park@samsung.com>

It's boot and working at mainline.

It's just for record.
Current mainline codes doesn't have full features of s5pv310 (aka
s5pc210 or exynos4210).
So I back-ported the same codes to 2.6.36. it's booted and working at
boot time, but some times later it's hang.
no serial. I think as irq cores at arm changed, it requires the more
patched than just this patch.

Thank you,
Kyungmin Park

On Tue, Feb 22, 2011 at 12:28 AM, Will Deacon <will.deacon@arm.com> wrote:
> The IRQ combiner code invokes the ->irq_{un}mask routines of the parent
> chip.
>
> This patch updates the cascaded handler to use EOI now that the GIC has
> moved to using the fasteoi flow model.
>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/mach-s5pv310/irq-combiner.c | ? ?7 ++-----
> ?1 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/irq-combiner.c b/arch/arm/mach-s5pv310/irq-combiner.c
> index 1ea4a9e..24d5604 100644
> --- a/arch/arm/mach-s5pv310/irq-combiner.c
> +++ b/arch/arm/mach-s5pv310/irq-combiner.c
> @@ -59,9 +59,6 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> ? ? ? ?unsigned int cascade_irq, combiner_irq;
> ? ? ? ?unsigned long status;
>
> - ? ? ? /* primary controller ack'ing */
> - ? ? ? chip->irq_ack(&desc->irq_data);
> -
> ? ? ? ?spin_lock(&irq_controller_lock);
> ? ? ? ?status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
> ? ? ? ?spin_unlock(&irq_controller_lock);
> @@ -79,8 +76,8 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ?generic_handle_irq(cascade_irq);
>
> ?out:
> - ? ? ? /* primary controller unmasking */
> - ? ? ? chip->irq_unmask(&desc->irq_data);
> + ? ? ? /* primary controller EOI */
> + ? ? ? chip->irq_eoi(&desc->irq_data);
> ?}
>
> ?static struct irq_chip combiner_chip = {
> --
> 1.7.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
