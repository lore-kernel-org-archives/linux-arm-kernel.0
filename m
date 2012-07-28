From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 15:17:49 +0800
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <1343330187-20049-5-git-send-email-zonque@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <1343330187-20049-5-git-send-email-zonque@gmail.com>
Message-ID: <CAN1soZwGp=OKsyAy=iL7ZUvxG+VPBm-d==8Q-AiPqNUMoiPz-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 3:16 AM, Daniel Mack <zonque@gmail.com> wrote:
> Properly register on-chip interrupt using the irqdomain logic. The
> number of interrupts is taken from the devicetree node.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-pxa/irq.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-pxa/pxa3xx.c | 17 +++++++++--
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> +#ifdef CONFIG_OF
> +static struct irq_domain *pxa_irq_domain;
> +
> +static int pxa_irq_map(struct irq_domain *h, unsigned int virq,
> +                      irq_hw_number_t hw)
> +{
> +       int irq, i = hw % 32;
> +       void __iomem *base = irq_base(hw / 32);
> +
> +       /* initialize interrupt priority */
> +       if (cpu_has_ipr())
> +               __raw_writel(i | IPR_VALID, IRQ_BASE + IPR(i));
Since we have DT support at here. Could we use property for interrupt priority?

> +
> +       irq = PXA_IRQ(virq);
#ifdef CONFIG_PXA_HAVE_ISA_IRQS
#define PXA_ISA_IRQ(x)  (x)
#define PXA_ISA_IRQ_NUM (16)
#else
#define PXA_ISA_IRQ_NUM (0)
#endif

Could we avoid to use PXA_IRQ() at here? We can make use of
NR_IRQS_LEGACY that is 16. Since you already use irq_alloc_descs()
to allocate irqs that virtual irq number starts from 16. So you needn't
use PXA_IRQ() any more.
