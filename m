From: will.deacon@arm.com (Will Deacon)
Date: Sun, 03 Apr 2011 13:17:01 +0100
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <BANLkTimJwCkabdEhQ89NgEaWyYaX6kSgUQ@mail.gmail.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
	<1301669441-13744-7-git-send-email-will.deacon@arm.com>
	<BANLkTi=xeCaF4HwOsEnqCzkiywPu6R0XbA@mail.gmail.com>
	<BANLkTimJwCkabdEhQ89NgEaWyYaX6kSgUQ@mail.gmail.com>
Message-ID: <1301833021.5022.4.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On Sun, 2011-04-03 at 04:27 +0100, Colin Cross wrote:
> In further testing I found one bug.  d7ed36a added gic_arch_extn,
> which needs to be used in gic_eoi.   arch/arm/mach-tegra/irq.c will
> need to be fixed to replace tegra_ack with tegra_eoi, and any other
> platform that uses gic_arch_extn also needs to be checked (omap4?).

Ok, I'll do some grepping around for those guys. I didn't realise they
were already being used.

> This patch fixes gic.c:
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 6ecd5c7..8e46dac 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -118,7 +118,11 @@ static void gic_unmask_irq(struct irq_data *d)
> 
>  static void gic_eoi_irq(struct irq_data *d)
>  {
> +       spin_lock(&irq_controller_lock);
> +       if (gic_arch_extn.irq_eoi)
> +               gic_arch_extn.irq_eoi(d);
>         writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
> +       spin_unlock(&irq_controller_lock);
>  }
> 
>  static int gic_set_type(struct irq_data *d, unsigned int type)


Hmm, I don't like that spinlock. Are the gic_arch_extn.* pointers ever
modified after being set initially? If not, can we make the locking
conditional on that pointer being non-NULL?

Will
