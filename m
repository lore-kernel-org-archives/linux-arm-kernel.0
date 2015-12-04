From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 04 Dec 2015 11:20:40 +0300
Subject: [PATCH v2] ARM: Enable GICv2m on 32-bit virt machine
In-Reply-To: <CANMBJr6D=-meT6MEQtgyiG2rZ+vzsq-AgLEBAJ7ob-ak2-87wQ@mail.gmail.com>
References: <1448624071-9552-1-git-send-email-p.fedin@samsung.com>
 <CANMBJr6D=-meT6MEQtgyiG2rZ+vzsq-AgLEBAJ7ob-ak2-87wQ@mail.gmail.com>
Message-ID: <00a101d12e6c$aa073600$fe15a200$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> today. Specifically, it is causing boot regressions with
> multi_v7_defconfig variants on the tegra124-jetson-tk1,
> tegra30-beaver, and the armada-370-mirabox platforms, all of which
> have PCI support. I had the bot bisect[2] the boot failures, and it
> pointed to this commit.

 Ouch... What a simple thing and how many problems...
 I have examined the code and i know the source of the problem. CONFIG_ARM_GIC_V2M automatically enables CONFIG_PCI_MSI_IRQ_DOMAIN,
and there we have pci_msi_setup_msi_irqs(), which first tries to call domain ops, then, if there's no irqdomain for the device, then
try oldstyle arch_setup_msi_irqs(). The problem is that with new GENERIC_MSI_IRQ_DOMAIN we always have domain != NULL, and backwards
compatibility logic doesn't work anymore.
 So far, we have the following call chain: pci_msi_setup_msi_irqs -> pci_msi_domain_alloc_irqs -> msi_domain_alloc_irqs. And here
fun begins:

	struct msi_domain_info *info = domain->host_data;
	struct msi_domain_ops *ops = info->ops;

	...

	ret = ops->msi_check(domain, info, dev);

 I intentionally left only these three lines because they are enough for the crash. They assume that domain->host_data holds struct
msi_domain_info *, which is plain wrong with that legacy code.

1. Tegra

 pci-tegra.c does this:

 	msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
					    &msi_domain_ops, &msi->chip);

 where msi->chip is oldstyle struct msi_controller. And __irq_domain_add() simply inserts this pointer into domain->host_data. This
causes msi_domain_alloc_irqs() to go nowhere by dereferencing domain->host_data with a wrong type.

2. Armada.

 I failed to find where exactly MSI irqdomain is created, this should be done somewhere by default, because mvebu PCI host driver
(is it the right one?) does not use any irqdomain operations at all. So, i suppose we have some empty domain with domain->host_data
set to NULL, therefore msi_domain_alloc_irqs() goes to NULL dereference early in the beginning.

 Proposed solution
 -----------------

 I have studied the code a bit more, and i see that proper MSI domains should have domain->ops == &msi_domain_ops. Based on this, i
can suggest the following fix (copypasted from console, so tabs lost, don't pay attention please):

$ git diff
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 53e4632..8531f89 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -43,10 +43,10 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
        struct irq_domain *domain;

        domain = dev_get_msi_domain(&dev->dev);
-       if (domain)
-               return domain;
+       if (!domain)
+               domain = arch_get_pci_msi_domain(dev);

-       return arch_get_pci_msi_domain(dev);
+       return irq_domain_is_generic_msi(domain) ? domain : NULL;
 }

 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/include/linux/msi.h b/include/linux/msi.h
index f71a25e..470d285 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -268,6 +268,7 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
                                         struct msi_domain_info *info,
                                         struct irq_domain *parent);
+bool irq_domain_is_generic_msi(struct irqdomain *domain);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
                          int nvec);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6b0c0b7..22dbc7f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -253,6 +253,17 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 }

 /**
+ * irq_domain_is_generic_msi - Check whether the irqdomain belongs to us
+ * @domain:    The domain to check
+ *
+ * Returns: test result (true or false)
+ */
+bool irq_domain_is_generic_msi(struct irqdomain *domain)
+{
+       return domain && (domain->ops == &msi_domain_ops);
+}
+
+/**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:    The domain to allocate from
  * @dev:       Pointer to device struct of the device for which the interrupts


 Tyler, can you apply this and see what happens? Unfortunately i don't have any of these machines here, so cannot test by myself.
And qemu also cannot emulate them either.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
