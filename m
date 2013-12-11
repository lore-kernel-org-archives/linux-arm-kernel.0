From: courtney.cavin@sonymobile.com (Courtney Cavin)
Date: Wed, 11 Dec 2013 13:30:04 -0800
Subject: [PATCH 7/8] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <1386718523-2587-8-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131211213003.GC15223@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 12:35:22AM +0100, Stephen Boyd wrote:
> Convert this driver to use irqdomains so that the PMIC's child
> devices can be converted to devicetree.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/mfd/pm8921-core.c         | 186 ++++++++++++++------------------------
>  include/linux/mfd/pm8xxx/irq.h    |  59 ------------
>  include/linux/mfd/pm8xxx/pm8921.h |  30 ------
>  3 files changed, 66 insertions(+), 209 deletions(-)
>  delete mode 100644 include/linux/mfd/pm8xxx/irq.h
>  delete mode 100644 include/linux/mfd/pm8xxx/pm8921.h
> 
[...]
> @@ -282,17 +278,14 @@ static struct irq_chip pm8xxx_irq_chip = {
>   * RETURNS:
>   * an int indicating the value read on that line
>   */
> -int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
> +static int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
>  {
>         int pmirq, rc;
>         u8  block, bits, bit;
>         unsigned long flags;
> +       struct irq_data *irq_data = irq_get_irq_data(irq);
> 
> -       if (chip == NULL || irq < chip->irq_base ||
> -                       irq >= chip->irq_base + chip->num_irqs)
> -               return -EINVAL;
> -
> -       pmirq = irq - chip->irq_base;
> +       pmirq = irq_data->hwirq;
> 
>         block = pmirq / 8;
>         bit = pmirq % 8;
> @@ -322,64 +315,55 @@ bail_out:
>  }
>  EXPORT_SYMBOL_GPL(pm8xxx_get_irq_stat);

Surely this isn't needed anymore, since the function is now static.

[...]
> +static int pm8xxx_irq_init(struct platform_device *pdev, unsigned int irq,
> +                          unsigned int nirqs)

'nirqs' seems to always be 256.  Is there a benefit to keeping this
dynamic?

> +{
> +       struct pm_irq_chip  *chip;
> +
> +       chip = devm_kzalloc(&pdev->dev, sizeof(*chip) + sizeof(u8) * nirqs,
> +                           GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
> 
> -       chip->dev = dev;
> -       chip->devirq = devirq;
> -       chip->irq_base = pdata->irq_base;
> -       chip->num_irqs = pdata->irq_cdata.nirqs;
> +       chip->dev = &pdev->dev;
> +       chip->num_irqs = nirqs;
>         chip->num_blocks = DIV_ROUND_UP(chip->num_irqs, 8);
>         chip->num_masters = DIV_ROUND_UP(chip->num_blocks, 8);
>         spin_lock_init(&chip->pm_irq_lock);
> 
> -       for (pmirq = 0; pmirq < chip->num_irqs; pmirq++) {

-Courtney
