From: Robert.Richter@cavium.com (Richter, Robert)
Date: Fri, 9 Nov 2018 07:58:30 +0000
Subject: [PATCH 07/10] irqchip/gic-v3-its: Split probing from its node
 initialization
In-Reply-To: <3ab57b7c-43e4-f6b8-fa4e-433fd087fc01@arm.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-8-rrichter@cavium.com>
 <3ab57b7c-43e4-f6b8-fa4e-433fd087fc01@arm.com>
Message-ID: <20181109075820.GD4064@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.11.18 11:25:24, Julien Thierry wrote:
> On 07/11/18 22:03, Robert Richter wrote:

> >-static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
> >+static int its_init_domain(struct its_node *its)
> >  {
> >      struct irq_domain *inner_domain;
> >      struct msi_domain_info *info;
> >@@ -3384,7 +3385,8 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
> >      if (!info)
> >              return -ENOMEM;
> >
> >-     inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
> >+     inner_domain = irq_domain_create_tree(its->fwnode_handle,
> >+                                     &its_domain_ops, its);
> 
> Separate change?
> 
> >      if (!inner_domain) {
> >              kfree(info);
> >              return -ENOMEM;
> >@@ -3441,8 +3443,7 @@ static int its_init_vpe_domain(void)
> >      return 0;
> >  }
> >
> >-static int __init its_compute_its_list_map(struct resource *res,
> >-                                        void __iomem *its_base)
> >+static int __init its_compute_its_list_map(struct its_node *its)
> >  {
> >      int its_number;
> >      u32 ctlr;
> >@@ -3456,15 +3457,15 @@ static int __init its_compute_its_list_map(struct resource *res,
> >      its_number = find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
> >      if (its_number >= GICv4_ITS_LIST_MAX) {
> >              pr_err("ITS@%pa: No ITSList entry available!\n",
> >-                    &res->start);
> >+                    &its->phys_base);
> >              return -EINVAL;
> >      }
> >
> >-     ctlr = readl_relaxed(its_base + GITS_CTLR);
> >+     ctlr = readl_relaxed(its->base + GITS_CTLR);
> >      ctlr &= ~GITS_CTLR_ITS_NUMBER;
> >      ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
> >-     writel_relaxed(ctlr, its_base + GITS_CTLR);
> >-     ctlr = readl_relaxed(its_base + GITS_CTLR);
> >+     writel_relaxed(ctlr, its->base + GITS_CTLR);
> >+     ctlr = readl_relaxed(its->base + GITS_CTLR);
> 
> This (removal of its_base parameter) also feel like a separate change.

In a separate change the motivation of the change would not be
obvious. While the change of the variable itself is trivial from the
perspective of review and testing, I decided to keep it in the context
of the overall change of this patch.

> 
> Also, I would define a local variable its_base to avoid dereferencing
> its every time in order to get the base address.

Hmm, there is not much difference in reading the code then, while the
use of a local variable just adds more code without benefit. The
compiler does not care as the value is probably stored in a register
anyway. There are also other struct members, should all of them being
mirrored in a local variable?

> 
> >      if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
> >              its_number = ctlr & GITS_CTLR_ITS_NUMBER;
> >              its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
> >@@ -3472,83 +3473,110 @@ static int __init its_compute_its_list_map(struct resource *res,
> >
> >      if (test_and_set_bit(its_number, &its_list_map)) {
> >              pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
> >-                    &res->start, its_number);
> >+                    &its->phys_base, its_number);
> >              return -EINVAL;
> >      }
> >
> >      return its_number;
> >  }
> >
> >+static void its_free(struct its_node *its)
> >+{
> >+     raw_spin_lock(&its_lock);
> >+     list_del(&its->entry);
> >+     raw_spin_unlock(&its_lock);
> >+
> >+     kfree(its);
> >+}
> >+
> >+static int __init its_init_one(struct its_node *its);
> 
> You might as well define its_init_one here, no?

This is an intermediate definition that will be removed in a later
patch. Moving the whole code here would make the change less readable.

> 
> >+
> >  static int __init its_probe_one(struct resource *res,
> >                              struct fwnode_handle *handle, int numa_node)
> >  {
> >      struct its_node *its;
> >+     int err;
> >+
> >+     its = kzalloc(sizeof(*its), GFP_KERNEL);
> >+     if (!its)
> >+             return -ENOMEM;
> >+
> >+     raw_spin_lock_init(&its->lock);
> >+     INIT_LIST_HEAD(&its->entry);
> >+     INIT_LIST_HEAD(&its->its_device_list);
> >+     its->fwnode_handle = handle;
> >+     its->phys_base = res->start;
> >+     its->phys_size = resource_size(res);
> >+     its->numa_node = numa_node;
> >+
> >+     raw_spin_lock(&its_lock);
> >+     list_add_tail(&its->entry, &its_nodes);
> >+     raw_spin_unlock(&its_lock);
> >+
> >+     pr_info("ITS %pR\n", res);
> >+
> >+     err = its_init_one(its);
> >+     if (err)
> >+             its_free(its);
> >+
> >+     return err;
> >+}
> >+
> >+static int __init its_init_one(struct its_node *its)
> >+{
> >      void __iomem *its_base;
> >      u32 val, ctlr;
> >      u64 baser, tmp, typer;
> >      int err;
> >
> >-     its_base = ioremap(res->start, resource_size(res));
> >+     its_base = ioremap(its->phys_base, its->phys_size);
> >      if (!its_base) {
> >-             pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
> >-             return -ENOMEM;
> >+             pr_warn("ITS@%pa: Unable to map ITS registers\n", &its->phys_base);
> >+             err = -ENOMEM;
> >+             goto fail;
> >      }
> >
> >      val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
> >      if (val != 0x30 && val != 0x40) {
> >-             pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
> >+             pr_warn("ITS@%pa: No ITS detected, giving up\n", &its->phys_base);
> >              err = -ENODEV;
> >              goto out_unmap;
> >      }
> >
> >      err = its_force_quiescent(its_base);
> >      if (err) {
> >-             pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
> >+             pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &its->phys_base);
> >              goto out_unmap;
> >      }
> >
> >-     pr_info("ITS %pR\n", res);
> >-
> >-     its = kzalloc(sizeof(*its), GFP_KERNEL);
> >-     if (!its) {
> >-             err = -ENOMEM;
> >-             goto out_unmap;
> >-     }
> >-
> >-     raw_spin_lock_init(&its->lock);
> >-     INIT_LIST_HEAD(&its->entry);
> >-     INIT_LIST_HEAD(&its->its_device_list);
> >      typer = gic_read_typer(its_base + GITS_TYPER);
> >      its->base = its_base;
> >-     its->phys_base = res->start;
> >      its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
> >      its->device_ids = GITS_TYPER_DEVBITS(typer);
> >      its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
> >      if (its->is_v4) {
> >              if (!(typer & GITS_TYPER_VMOVP)) {
> >-                     err = its_compute_its_list_map(res, its_base);
> >+                     err = its_compute_its_list_map(its);
> >                      if (err < 0)
> >-                             goto out_free_its;
> >+                             goto out_unmap;
> >
> >                      its->list_nr = err;
> >
> >                      pr_info("ITS@%pa: Using ITS number %d\n",
> >-                             &res->start, err);
> >+                             &its->phys_base, err);
> >              } else {
> >-                     pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
> >+                     pr_info("ITS@%pa: Single VMOVP capable\n",
> >+                             &its->phys_base);
> >              }
> >      }
> >
> >-     its->numa_node = numa_node;
> >-
> >      its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> >                                              get_order(ITS_CMD_QUEUE_SZ));
> >      if (!its->cmd_base) {
> >              err = -ENOMEM;
> >-             goto out_free_its;
> >+             goto out_unmap;
> >      }
> >      its->cmd_write = its->cmd_base;
> >-     its->fwnode_handle = handle;
> >      its->get_msi_base = its_irq_get_msi_base;
> >      its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
> >
> >@@ -3597,13 +3625,11 @@ static int __init its_probe_one(struct resource *res,
> >      if (GITS_TYPER_HCC(typer))
> >              its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
> >
> >-     err = its_init_domain(handle, its);
> >+     err = its_init_domain(its);
> 
> I'm not sure what is the logic for "this goes in probe, this goes in init?".

It is fairly simple, gic-its register access is done in init.
Everything that is detected during devicetree or ACPI device discovery
is done in the probe function that collects all data in struct
its_node.

> 
> >      if (err)
> >              goto out_free_tables;
> >
> >-     raw_spin_lock(&its_lock);
> >-     list_add_tail(&its->entry, &its_nodes);
> >-     raw_spin_unlock(&its_lock);
> >+     pr_info("ITS@%pa: ITS node added\n", &its->phys_base);
> >
> >      return 0;

Thanks,

-Robert
