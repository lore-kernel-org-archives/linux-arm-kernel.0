From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 26 Jan 2017 02:44:11 +0200
Subject: [PATCH V11 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1484879660-1960-4-git-send-email-agustinv@codeaurora.org>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
 <1484879660-1960-4-git-send-email-agustinv@codeaurora.org>
Message-ID: <CAHp75Vc9XSZZ2eyu=2reqNS22Op6a9g6W--1Zf3z_LZmXDeRtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> Driver for interrupt combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> An interrupt combiner in this block combines a set of interrupts by
> OR'ing the individual interrupt signals into a summary interrupt
> signal routed to a parent interrupt controller, and provides read-
> only, 32-bit registers to query the status of individual interrupts.
> The status bit for IRQ n is bit (n % 32) within register (n / 32)
> of the given combiner. Thus, each combiner can be described as a set
> of register offsets and the number of IRQs managed.

> +static inline u32 irq_register(int irq)
> +{
> +       return irq / REG_SIZE;
> +}
> +
> +static inline u32 irq_bit(int irq)
> +{
> +       return irq % REG_SIZE;
> +
> +}

Besides extra line I do not see a benefit of those helpers. On first
glance they even increase characters to type.

> +static inline int irq_nr(u32 reg, u32 bit)
> +{
> +       return reg * REG_SIZE + bit;
> +}

This one might make sense.

> +static void combiner_handle_irq(struct irq_desc *desc)
> +{
> +       struct combiner *combiner = irq_desc_get_handler_data(desc);
> +       struct irq_chip *chip = irq_desc_get_chip(desc);
> +       u32 reg;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       for (reg = 0; reg < combiner->nregs; reg++) {
> +               int virq;
> +               int hwirq;
> +               u32 bit;
> +               u32 status;
> +
> +               bit = readl_relaxed(combiner->regs[reg].addr);
> +               status = bit & combiner->regs[reg].enabled;
> +               if (!status)
> +                       pr_warn_ratelimited("Unexpected IRQ on CPU%d: (%08x %08lx %p)\n",
> +                                           smp_processor_id(), bit,
> +                                           combiner->regs[reg].enabled,
> +                                           combiner->regs[reg].addr);
> +

> +               while (status) {
> +                       bit = __ffs(status);
> +                       status &= ~(1 << bit);

Interesting way of for_each_set_bit() ?

> +                       hwirq = irq_nr(reg, bit);
> +                       virq = irq_find_mapping(combiner->domain, hwirq);
> +                       if (virq > 0)
> +                               generic_handle_irq(virq);
> +
> +               }
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}
> +

> +/*
> + * irqchip callbacks
> + */

Useless.

> +/*
> + * irq_domain_ops callbacks
> + */

Ditto.

> +/*
> + * Device probing
> + */

Ditto.

> +static acpi_status count_registers_cb(struct acpi_resource *ares, void *context)
> +{
> +       int *count = context;

I would consider to define a struct. It would be easy to extend if needed and...

> +
> +       if (ares->type == ACPI_RESOURCE_TYPE_GENERIC_REGISTER)
> +               ++(*count);

...allows not to use such of constructions. (I think above is
equivalent to ++*count).

> +       return AE_OK;

> +}
> +
> +static int count_registers(struct platform_device *pdev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);

You don't use adev, so, ACPI_HANDLE() ?

> +       acpi_status status;
> +       int count = 0;
> +
> +       if (!acpi_has_method(adev->handle, METHOD_NAME__CRS))
> +               return -EINVAL;
> +
> +       status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> +                                    count_registers_cb, &count);
> +       if (ACPI_FAILURE(status))
> +               return -EINVAL;
> +       return count;
> +}

Oh, since you are using this just as a helper to get count first, why
not to combine this in one callback?
What's the benefit of separation?

> +
> +struct get_registers_context {
> +       struct device *dev;
> +       struct combiner *combiner;
> +       int err;
> +};
> +
> +static acpi_status get_registers_cb(struct acpi_resource *ares, void *context)
> +{
> +       struct get_registers_context *ctx = context;
> +       struct acpi_resource_generic_register *reg;
> +       phys_addr_t paddr;
> +       void __iomem *vaddr;
> +
> +       if (ares->type != ACPI_RESOURCE_TYPE_GENERIC_REGISTER)
> +               return AE_OK;
> +
> +       reg = &ares->data.generic_reg;
> +       paddr = reg->address;
> +       if ((reg->space_id != ACPI_SPACE_MEM) ||
> +           (reg->bit_offset != 0) ||
> +           (reg->bit_width > REG_SIZE)) {
> +               dev_err(ctx->dev, "Bad register resource @%pa\n", &paddr);
> +               ctx->err = -EINVAL;
> +               return AE_ERROR;
> +       }
> +
> +       vaddr = devm_ioremap(ctx->dev, reg->address, REG_SIZE);
> +       if (IS_ERR(vaddr)) {
> +               dev_err(ctx->dev, "Can't map register @%pa\n", &paddr);
> +               ctx->err = PTR_ERR(vaddr);
> +               return AE_ERROR;
> +       }

This all sounds to me like an OperationalRegion. But I'm not sure it's
suitable here.
Do you have ACPI table carved in stone?

> +
> +       ctx->combiner->regs[ctx->combiner->nregs].addr = vaddr;
> +       ctx->combiner->nirqs += reg->bit_width;
> +       ctx->combiner->nregs++;
> +       return AE_OK;
> +}
> +
> +static int get_registers(struct platform_device *pdev, struct combiner *comb)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +       acpi_status status;
> +       struct get_registers_context ctx;
> +
> +       if (!acpi_has_method(adev->handle, METHOD_NAME__CRS))
> +               return -EINVAL;
> +
> +       ctx.dev = &pdev->dev;
> +       ctx.combiner = comb;
> +       ctx.err = 0;
> +
> +       status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> +                                    get_registers_cb, &ctx);
> +       if (ACPI_FAILURE(status))
> +               return ctx.err;
> +       return 0;
> +}
> +
> +static int __init combiner_probe(struct platform_device *pdev)
> +{
> +       struct combiner *combiner;
> +       size_t alloc_sz;
> +       u32 nregs;
> +       int err;
> +
> +       nregs = count_registers(pdev);
> +       if (nregs <= 0) {
> +               dev_err(&pdev->dev, "Error reading register resources\n");
> +               return -EINVAL;
> +       }
> +
> +       alloc_sz = sizeof(*combiner) + sizeof(struct combiner_reg) * nregs;
> +       combiner = devm_kzalloc(&pdev->dev, alloc_sz, GFP_KERNEL);
> +       if (!combiner)
> +               return -ENOMEM;
> +
> +       err = get_registers(pdev, combiner);
> +       if (err < 0)
> +               return err;
> +
> +       combiner->parent_irq = platform_get_irq(pdev, 0);
> +       if (combiner->parent_irq <= 0) {
> +               dev_err(&pdev->dev, "Error getting IRQ resource\n");
> +               return -EPROBE_DEFER;
> +       }
> +
> +       combiner->domain = irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
> +                                                   &domain_ops, combiner);
> +       if (!combiner->domain)
> +               /* Errors printed by irq_domain_create_linear */
> +               return -ENODEV;
> +
> +       irq_set_chained_handler_and_data(combiner->parent_irq,
> +                                        combiner_handle_irq, combiner);
> +
> +       dev_info(&pdev->dev, "Initialized with [p=%d,n=%d,r=%p]\n",
> +                combiner->parent_irq, combiner->nirqs, combiner->regs[0].addr);
> +       return 0;
> +}
> +
> +static const struct acpi_device_id qcom_irq_combiner_ids[] __dsdt_irqchip = {
> +       { "QCOM80B1", },
> +       { }
> +};
> +
> +static struct platform_driver qcom_irq_combiner_probe = {
> +       .driver = {
> +               .name = "qcom-irq-combiner",

> +               .owner = THIS_MODULE,

Do you still need this?

> +               .acpi_match_table = ACPI_PTR(qcom_irq_combiner_ids),
> +       },

-- 
With Best Regards,
Andy Shevchenko
