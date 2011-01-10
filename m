From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 10 Jan 2011 16:49:07 -0600
Subject: [PATCH 4/5] ARM: pxa: Fix suspend/resume array index
	miscalculation
In-Reply-To: <1294615746-27668-4-git-send-email-marek.vasut@gmail.com>
References: <1294615746-27668-1-git-send-email-marek.vasut@gmail.com>
	<1294615746-27668-4-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=fdTkrdysefE-Wnv0UXN1Wa9j61opAT-GGGwsh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 9, 2011 at 5:29 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/irq.c | ? 10 +++++-----
> ?1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 78f0e0c..81edf97 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -194,14 +194,14 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
>
> ?#ifdef CONFIG_PM
> ?static unsigned long saved_icmr[MAX_INTERNAL_IRQS/32];
> -static unsigned long saved_ipr[MAX_INTERNAL_IRQS];
> +static unsigned long saved_ipr[MAX_INTERNAL_IRQS/32];
>

This isn't right I'm afraid. Unlike other IRQ registers, each interrupt
line has its own IPR register. So the changes below are also invalid.

> ?static int pxa_irq_suspend(struct sys_device *dev, pm_message_t state)
> ?{
> ? ? ? ?int i;
>
> - ? ? ? for (i = 0; i < pxa_internal_irq_nr; i += 32) {
> - ? ? ? ? ? ? ? void __iomem *base = irq_base(i);
> + ? ? ? for (i = 0; i < pxa_internal_irq_nr; i++) {
> + ? ? ? ? ? ? ? void __iomem *base = irq_base(i << 5);
>
> ? ? ? ? ? ? ? ?saved_icmr[i] = __raw_readl(base + ICMR);
> ? ? ? ? ? ? ? ?__raw_writel(0, base + ICMR);
> @@ -219,8 +219,8 @@ static int pxa_irq_resume(struct sys_device *dev)
> ?{
> ? ? ? ?int i;
>
> - ? ? ? for (i = 0; i < pxa_internal_irq_nr; i += 32) {
> - ? ? ? ? ? ? ? void __iomem *base = irq_base(i);
> + ? ? ? for (i = 0; i < pxa_internal_irq_nr; i++) {
> + ? ? ? ? ? ? ? void __iomem *base = irq_base(i << 5);
>
> ? ? ? ? ? ? ? ?__raw_writel(saved_icmr[i], base + ICMR);
> ? ? ? ? ? ? ? ?__raw_writel(0, base + ICLR);
> --
> 1.7.2.3
>
>
