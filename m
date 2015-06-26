From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jun 2015 09:44:17 +0100
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <558CF1CD.5020200@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
 <558CF1CD.5020200@huawei.com>
Message-ID: <558D10E1.8040701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/15 07:31, majun (F) wrote:
> Hi Thomas:
> 
> ? 2015/6/12 10:49, Ma Jun ??:
> 
>> +static int its_mbigen_prepare(struct irq_domain *domain, struct mbi_desc *desc,
>> +								int hwirq, struct mbi_alloc_info *arg)
>> +{
>> +	struct its_node *its = domain->parent->host_data;
>> +	struct its_device *its_dev;
>> +	u32 dev_id;
>> +
>> +	dev_id = desc->msg_id;
>> +
>> +	its_dev = its_find_device(its, dev_id);
>> +	if (!its_dev) {
>> +		its_dev = its_create_device(its, dev_id, desc->lines);
>> +		if (!its_dev)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	arg->scratchpad[0].ptr = its_dev;
>> +	arg->scratchpad[1].ptr = NULL;
>> +
>> +	arg->desc = desc;
>> +	arg->hwirq = hwirq;
>> +	return 0;
>> +}
>> +
>> +static struct mbigen_domain_ops its_mbigen_ops = {
>> +	.mbigen_prepare		= its_mbigen_prepare,
>> +};
>> +
>> +static struct mbigen_domain_info its_mbigen_domain_info = {
>> +	.ops	= &its_mbigen_ops,
>> +};
>> +
> 
> what's you opinion about the function 'its_mbigen_prepare' ?
> put this function in irq-gic-v3-its.c or move to mbigen driver ?
> 
> If I move this function to mbigen driver, some its fuctions
> (ex. its_find_device, its_create_device) and struct data (ex its_node)
> would be used in mbigen driver.

The prepare hook is very PCI specific so far, but could easily be turned into
something that is not. How about splitting it in two:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b7e155..9a68c77 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1200,49 +1200,54 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
-			   int nvec, msi_alloc_info_t *info)
+int its_msi_prepare(struct irq_domain *domain, u32 dev_id,
+		    int nvec, msi_alloc_info_t *info)
 {
-	struct pci_dev *pdev;
 	struct its_node *its;
 	struct its_device *its_dev;
-	struct its_pci_alias dev_alias;
 
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	pdev = to_pci_dev(dev);
-	dev_alias.pdev = pdev;
-	dev_alias.count = nvec;
-
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 	its = domain->parent->host_data;
-
-	its_dev = its_find_device(its, dev_alias.dev_id);
+	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
 		 * We already have seen this ID, probably through
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
-		dev_dbg(dev, "Reusing ITT for devID %x\n", dev_alias.dev_id);
+		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
-	its_dev = its_create_device(its, dev_alias.dev_id, dev_alias.count);
+	its_dev = its_create_device(its, dev_id, nvec);
 	if (!its_dev)
 		return -ENOMEM;
 
-	dev_dbg(&pdev->dev, "ITT %d entries, %d bits\n",
-		dev_alias.count, ilog2(dev_alias.count));
+	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	info->scratchpad[0].ptr = its_dev;
-	info->scratchpad[1].ptr = dev;
 	return 0;
 }
 
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev;
+	struct its_pci_alias dev_alias;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	dev_alias.pdev = pdev;
+	dev_alias.count = nvec;
+
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+
+	return its_msi_prepare(domain, dev_alias.dev_id, dev_alias.count, info);
+}
+
 static struct msi_domain_ops its_pci_msi_ops = {
-	.msi_prepare	= its_msi_prepare,
+	.msi_prepare	= its_pci_msi_prepare,
 };
 
 static struct msi_domain_info its_pci_msi_domain_info = {
@@ -1287,8 +1292,9 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
 					      hwirq, &its_irq_chip, its_dev);
-		dev_dbg(info->scratchpad[1].ptr, "ID:%d pID:%d vID:%d\n",
-			(int)(hwirq - its_dev->lpi_base), (int)hwirq, virq + i);
+		pr_debug("ID:%d pID:%d vID:%d\n",
+			 (int)(hwirq - its_dev->lpi_base),
+			 (int)hwirq, virq + i);
 	}
 
 	return 0;

You can then keep your MBI stuff in a separate file, and call into 
its_msi_prepare.

> Now, all these functions and data structure are defined as static.
> to use them, I have to remove the 'static' definition and put them
> in a head file ? create a new head file).

I don't want to see these functions and structure leaking out of the
ITS code unless we're absolutely forced to do so.  The above code
shows you one possible way to solve the problem.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
