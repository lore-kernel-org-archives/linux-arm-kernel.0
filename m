From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Feb 2015 15:48:38 +0000
Subject: [PATCH v4 2/5] irqchip: add virtual demultiplexer implementation
In-Reply-To: <1422527620-8308-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <1422527620-8308-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150210154838.GG9432@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +static int __init virt_irq_demux_of_init(struct device_node *node,
> +                                        struct device_node *parent)
> +{
> +       struct irq_chip_virt_demux *demux;
> +       unsigned int irq;
> +       u32 valid_irqs;
> +       int ret;
> +
> +       irq = irq_of_parse_and_map(node, 0);
> +       if (!irq) {
> +               pr_err("Failed to retrieve virt irq demuxer source\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = of_property_read_u32(node, "irqs", &valid_irqs);
> +       if (ret) {
> +               pr_err("Invalid of missing 'irqs' property\n");
> +               return ret;
> +       }
> +
> +       demux = irq_alloc_virt_demux_chip(irq, valid_irqs,
> +                                         IRQ_NOREQUEST | IRQ_NOPROBE |
> +                                         IRQ_NOAUTOEN, 0);
> +       if (!demux) {
> +               pr_err("Failed to allocate virt irq demuxer struct\n");
> +               return -ENOMEM;
> +       }
> +
> +       demux->domain = irq_domain_add_linear(node, BITS_PER_LONG,
> +                                             &irq_virt_demux_domain_ops,
> +                                             demux);
> +       if (!demux->domain) {
> +               ret = -ENOMEM;
> +               goto err_free_demux;
> +       }
> +
> +       ret = irq_set_handler_data(irq, demux);
> +       if (ret) {
> +               pr_err("Failed to assign handler data\n");
> +               goto err_free_domain;
> +       }
> +
> +       irq_set_chained_handler_nostartup(irq, irq_virt_demux_handler);
> +
> +       return 0;
> +
> +err_free_domain:
> +       irq_domain_remove(demux->domain);
> +
> +err_free_demux:
> +       kfree(demux);
> +
> +       return ret;
> +}
> +IRQCHIP_DECLARE(virt_irq_demux, "virtual,irq-demux", virt_irq_demux_of_init);

As mentioned on the DT binding patch, I really don't think this should
be in the DT. It corresponds only to Linux internal details, not a piece
of hardware. If we need this internally, I don't see why it can't be
instanciated as required.

If we _must_ have this in the DT, I have concerns with the binding
w.r.t. the "irqs" property being a 32-bit bitmask (as opposed to say
being something like "num-irqs" which could be far larger, and is
easuier to read).

Thanks,
Mark.
