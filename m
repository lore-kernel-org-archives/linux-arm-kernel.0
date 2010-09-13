From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 13 Sep 2010 23:27:11 +0800
Subject: [PATCH 1/2] ARM: remove NR_IRQS in gic.c
In-Reply-To: <1284357078-16248-1-git-send-email-haojian.zhuang@marvell.com>
References: <1284357078-16248-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTi=aW4PxF+mSB3hcjrZfq=mt3dqY+owa1v+jQs3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 1:51 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> NR_IRQS is used to specified irq numbers of one cpu. Although this macro
> is effective, it also blocks building multiple cpu architecutre into
> one image.
>
> After SPARSE IRQ is introduced, nr_irqs could also indicate irq numbers of
> one cpu architecture. Now use nr_irqs to replace NR_IRQS in gic.c.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Eric Miao <eric.y.miao@gmail.com>

This is safe. I'm OK with this.

Acked-by: Eric Miao <eric.y.miao@gmail.com>


> ---
> ?arch/arm/common/gic.c | ? ?6 +++---
> ?1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 7dfa9a8..7f43eae 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -191,7 +191,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> ? ? ? ? ? ? ? ?goto out;
>
> ? ? ? ?cascade_irq = gic_irq + chip_data->irq_offset;
> - ? ? ? if (unlikely(gic_irq < 32 || gic_irq > 1020 || cascade_irq >= NR_IRQS))
> + ? ? ? if (unlikely(gic_irq < 32 || gic_irq > 1020 || cascade_irq >= nr_irqs))
> ? ? ? ? ? ? ? ?do_bad_IRQ(cascade_irq, desc);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?generic_handle_irq(cascade_irq);
> @@ -249,8 +249,8 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
> ? ? ? ? * Limit this to either the architected maximum, or the
> ? ? ? ? * platform maximum.
> ? ? ? ? */
> - ? ? ? if (max_irq > max(1020, NR_IRQS))
> - ? ? ? ? ? ? ? max_irq = max(1020, NR_IRQS);
> + ? ? ? if (max_irq > max(1020, nr_irqs))
> + ? ? ? ? ? ? ? max_irq = max(1020, nr_irqs);
>
> ? ? ? ?/*
> ? ? ? ? * Set all global interrupts to be level triggered, active low.
> --
> 1.5.6.5
>
>
