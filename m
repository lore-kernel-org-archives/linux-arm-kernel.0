From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 04 Dec 2015 11:30:03 +0300
Subject: [PATCH v2] ARM: Enable GICv2m on 32-bit virt machine
In-Reply-To: <00a101d12e6c$aa073600$fe15a200$@samsung.com>
References: <1448624071-9552-1-git-send-email-p.fedin@samsung.com>
 <CANMBJr6D=-meT6MEQtgyiG2rZ+vzsq-AgLEBAJ7ob-ak2-87wQ@mail.gmail.com>
 <00a101d12e6c$aa073600$fe15a200$@samsung.com>
Message-ID: <00a901d12e6d$f953b2a0$ebfb17e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

>  Proposed solution
>  -----------------
> 
>  I have studied the code a bit more, and i see that proper MSI domains should have domain->ops
> == &msi_domain_ops. Based on this, i
> can suggest the following fix (copypasted from console, so tabs lost, don't pay attention
> please):

 Damn, sorry, stupid me, pushed "send" before looking at test build results, and overlooked a stupid typo (struct irq_domain, not
struct irqdomain).
 The proper patch is (ignore spaces again plz, if confirmed good and working, i'll post it as appropriate):

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
index f71a25e..c8591a2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -268,6 +268,7 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
                                         struct msi_domain_info *info,
                                         struct irq_domain *parent);
+bool irq_domain_is_generic_msi(struct irq_domain *domain);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
                          int nvec);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6b0c0b7..3182aa1 100644
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
+bool irq_domain_is_generic_msi(struct irq_domain *domain)
+{
+       return domain && (domain->ops == &msi_domain_ops);
+}
+
+/**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:    The domain to allocate from
  * @dev:       Pointer to device struct of the device for which the interrupts

 Actually this looks very similar to Marc's fix, just method of checking is different. Feel free to use whatever you like more.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
