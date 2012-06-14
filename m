From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 15:13:28 +0800
Subject: [PATCH 06/16] ARM: imx: move irq_domain_add_legacy call into
 avic driver
In-Reply-To: <1339653587-4832-7-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120614071326.GC31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:37PM +0800, Shawn Guo wrote:
> Move irq_domain_add_legacy call from imx27-dt.c into avic init function
> and have the avic driver adopt irqdomain support for both DT and non-DT
> boot.
> 
> Now avic init function calls irq_alloc_descs to get irq_base and adds
> a lenacy irqdomain with the irq_base, so that the mapping between avic
> irq and Linux irq number can be handled by irqdomain.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/imx27-dt.c |   15 ---------------
>  arch/arm/plat-mxc/avic.c     |   26 +++++++++++++++++++-------
>  2 files changed, 19 insertions(+), 22 deletions(-)
> 
The following changes should be amended.

Regards,
Shawn

--8<---

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 4fe1d9b..e612cc1 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -59,9 +59,12 @@ static u32 avic_saved_mask_reg[2];
 #ifdef CONFIG_MXC_IRQ_PRIOR
 static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
 {
+       struct irq_data *d = irq_get_irq_data(irq);
        unsigned int temp;
        unsigned int mask = 0x0F << irq % 8 * 4;

+       irq = d->hwirq;
+
        if (irq >= AVIC_NUM_IRQS)
                return -EINVAL;

@@ -78,8 +81,11 @@ static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
 #ifdef CONFIG_FIQ
 static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
+       struct irq_data *d = irq_get_irq_data(irq);
        unsigned int irqt;

+       irq = d->hwirq;
+
        if (irq >= AVIC_NUM_IRQS)
                return -EINVAL;
