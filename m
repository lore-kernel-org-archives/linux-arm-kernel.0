From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Mar 2016 23:18:25 +0800
Subject: [PATCH v2] iommu/arm-smmu: Make use of phandle iterators in
 device-tree device-tree parsing
In-Reply-To: <20160323114707.GA17838@8bytes.org>
Message-ID: <201603232325.ah8fLwoH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

[auto build test ERROR on iommu/next]
[also build test ERROR on v4.5 next-20160323]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/iommu-arm-smmu-Make-use-of-phandle-iterators-in-device-tree-device-tree-parsing/20160323-194824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/iommu/arm-smmu.c: In function 'arm_smmu_device_dt_probe':
   drivers/iommu/arm-smmu.c:1746:29: error: storage size of 'it' isn't known
     struct of_phandle_iterator it;
                                ^
>> drivers/iommu/arm-smmu.c:1815:2: error: implicit declaration of function 'of_for_each_phandle' [-Werror=implicit-function-declaration]
     of_for_each_phandle(&it, err, dev->of_node,
     ^
>> drivers/iommu/arm-smmu.c:1816:46: error: expected ';' before '{' token
           "mmu-masters", "#stream-id-cells", 0) {
                                                 ^
   drivers/iommu/arm-smmu.c:1746:29: warning: unused variable 'it' [-Wunused-variable]
     struct of_phandle_iterator it;
                                ^
   drivers/iommu/arm-smmu.c: At top level:
   drivers/iommu/arm-smmu.c:473:12: warning: 'register_smmu_master' defined but not used [-Wunused-function]
    static int register_smmu_master(struct arm_smmu_device *smmu,
               ^
   cc1: some warnings being treated as errors

vim +/of_for_each_phandle +1815 drivers/iommu/arm-smmu.c

  1740	{
  1741		const struct of_device_id *of_id;
  1742		struct resource *res;
  1743		struct arm_smmu_device *smmu;
  1744		struct device *dev = &pdev->dev;
  1745		struct rb_node *node;
> 1746		struct of_phandle_iterator it;
  1747		struct arm_smmu_phandle_args *masterspec;
  1748		int num_irqs, i, err;
  1749	
  1750		smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
  1751		if (!smmu) {
  1752			dev_err(dev, "failed to allocate arm_smmu_device\n");
  1753			return -ENOMEM;
  1754		}
  1755		smmu->dev = dev;
  1756	
  1757		of_id = of_match_node(arm_smmu_of_match, dev->of_node);
  1758		smmu->version = (enum arm_smmu_arch_version)of_id->data;
  1759	
  1760		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1761		smmu->base = devm_ioremap_resource(dev, res);
  1762		if (IS_ERR(smmu->base))
  1763			return PTR_ERR(smmu->base);
  1764		smmu->size = resource_size(res);
  1765	
  1766		if (of_property_read_u32(dev->of_node, "#global-interrupts",
  1767					 &smmu->num_global_irqs)) {
  1768			dev_err(dev, "missing #global-interrupts property\n");
  1769			return -ENODEV;
  1770		}
  1771	
  1772		num_irqs = 0;
  1773		while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
  1774			num_irqs++;
  1775			if (num_irqs > smmu->num_global_irqs)
  1776				smmu->num_context_irqs++;
  1777		}
  1778	
  1779		if (!smmu->num_context_irqs) {
  1780			dev_err(dev, "found %d interrupts but expected at least %d\n",
  1781				num_irqs, smmu->num_global_irqs + 1);
  1782			return -ENODEV;
  1783		}
  1784	
  1785		smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
  1786					  GFP_KERNEL);
  1787		if (!smmu->irqs) {
  1788			dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
  1789			return -ENOMEM;
  1790		}
  1791	
  1792		for (i = 0; i < num_irqs; ++i) {
  1793			int irq = platform_get_irq(pdev, i);
  1794	
  1795			if (irq < 0) {
  1796				dev_err(dev, "failed to get irq index %d\n", i);
  1797				return -ENODEV;
  1798			}
  1799			smmu->irqs[i] = irq;
  1800		}
  1801	
  1802		err = arm_smmu_device_cfg_probe(smmu);
  1803		if (err)
  1804			return err;
  1805	
  1806		i = 0;
  1807		smmu->masters = RB_ROOT;
  1808	
  1809		err = -ENOMEM;
  1810		/* No need to zero the memory for masterspec */
  1811		masterspec = kmalloc(sizeof(*masterspec), GFP_KERNEL);
  1812		if (!masterspec)
  1813			goto out_put_masters;
  1814	
> 1815		of_for_each_phandle(&it, err, dev->of_node,
> 1816				    "mmu-masters", "#stream-id-cells", 0) {
  1817			int count = of_phandle_iterator_args(&it, masterspec->args,
  1818							     MAX_MASTER_STREAMIDS);
  1819			masterspec->np		= of_node_get(it.node);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21203 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/74b47574/attachment-0001.obj>
