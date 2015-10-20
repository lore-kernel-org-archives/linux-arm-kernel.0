From: lkp@intel.com (kbuild test robot)
Date: Wed, 21 Oct 2015 02:43:09 +0800
Subject: [PATCH RESEND v6 3/4] irqchip:create irq domain for each mbigen
 device
In-Reply-To: <1445343032-8032-4-git-send-email-majun258@huawei.com>
Message-ID: <201510210208.Hkd8XMxI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ma,

[auto build test ERROR on tip/irq/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/MaJun/irqchip-support-mbigen-interrupt-controller/20151020-202450
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   drivers/irqchip/irq-mbigen.c:84:14: error: 'mbigen_eoi_irq' undeclared here (not in a function)
     .irq_eoi =  mbigen_eoi_irq,
                 ^
   drivers/irqchip/irq-mbigen.c:85:19: error: 'mbigen_set_type' undeclared here (not in a function)
     .irq_set_type =  mbigen_set_type,
                      ^
   drivers/irqchip/irq-mbigen.c: In function 'mbigen_irq_domain_alloc':
>> drivers/irqchip/irq-mbigen.c:150:2: error: implicit declaration of function 'platform_msi_domain_alloc' [-Werror=implicit-function-declaration]
     err = platform_msi_domain_alloc(domain, virq, nr_irqs);
     ^
>> drivers/irqchip/irq-mbigen.c:159:2: error: implicit declaration of function 'platform_msi_get_host_data' [-Werror=implicit-function-declaration]
     mgn_chip = platform_msi_get_host_data(domain);
     ^
>> drivers/irqchip/irq-mbigen.c:159:11: warning: assignment makes pointer from integer without a cast
     mgn_chip = platform_msi_get_host_data(domain);
              ^
   drivers/irqchip/irq-mbigen.c: In function 'mbigen_device_probe':
>> drivers/irqchip/irq-mbigen.c:202:2: error: implicit declaration of function 'platform_msi_create_device_domain' [-Werror=implicit-function-declaration]
     domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
     ^
   drivers/irqchip/irq-mbigen.c:202:9: warning: assignment makes pointer from integer without a cast
     domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
            ^
   cc1: some warnings being treated as errors

vim +/platform_msi_domain_alloc +150 drivers/irqchip/irq-mbigen.c

    78	
    79	
    80	static struct irq_chip mbigen_irq_chip = {
    81		.name =			"mbigen-v2",
    82		.irq_mask =		irq_chip_mask_parent,
    83		.irq_unmask =		irq_chip_unmask_parent,
  > 84		.irq_eoi =		mbigen_eoi_irq,
  > 85		.irq_set_type =		mbigen_set_type,
    86		.irq_set_affinity =	irq_chip_set_affinity_parent,
    87	};
    88	
    89	static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
    90	{
    91		struct mbigen_irq_data *mgn_irq_data = irq_get_chip_data(desc->irq);
    92		u32 val;
    93	
    94		val = readl_relaxed(mgn_irq_data->reg_vec + mgn_irq_data->base);
    95	
    96		val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
    97		val |= (msg->data << IRQ_EVENT_ID_SHIFT);
    98	
    99		writel_relaxed(val, mgn_irq_data->reg_vec + mgn_irq_data->base);
   100	}
   101	
   102	static struct mbigen_irq_data *set_mbigen_irq_data(int hwirq)
   103	{
   104		struct mbigen_irq_data *datap;
   105		unsigned int nid, pin_offset;
   106	
   107		datap = kzalloc(sizeof(*datap), GFP_KERNEL);
   108		if (!datap)
   109			return NULL;
   110	
   111		/* get the mbigen node number */
   112		nid = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP) / IRQS_PER_MBIGEN_NODE + 1;
   113	
   114		pin_offset = (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP)
   115						% IRQS_PER_MBIGEN_NODE;
   116	
   117		datap->reg_vec = get_mbigen_vec_reg(nid, pin_offset);
   118	
   119		return datap;
   120	}
   121	
   122	static int mbigen_domain_translate(struct irq_domain *d,
   123					    struct irq_fwspec *fwspec,
   124					    unsigned long *hwirq,
   125					    unsigned int *type)
   126	{
   127		if (is_of_node(fwspec->fwnode)) {
   128			if (fwspec->param_count != 2)
   129				return -EINVAL;
   130	
   131			*hwirq = fwspec->param[0];
   132			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
   133	
   134			return 0;
   135		}
   136		return -EINVAL;
   137	}
   138	
   139	static int mbigen_irq_domain_alloc(struct irq_domain *domain,
   140						unsigned int virq,
   141						unsigned int nr_irqs,
   142						void *args)
   143	{
   144		struct irq_fwspec *fwspec = args;
   145		irq_hw_number_t hwirq = fwspec->param[0];
   146		struct mbigen_device *mgn_chip;
   147		struct mbigen_irq_data *mgn_irq_data;
   148		int i, err;
   149	
 > 150		err = platform_msi_domain_alloc(domain, virq, nr_irqs);
   151		if (err)
   152			return err;
   153	
   154		/* set related information of this irq */
   155		mgn_irq_data = set_mbigen_irq_data(hwirq);
   156		if (!mgn_irq_data)
   157			return err;
   158	
 > 159		mgn_chip = platform_msi_get_host_data(domain);
   160		mgn_irq_data->base = mgn_chip->base;
   161	
   162		for (i = 0; i < nr_irqs; i++)
   163			irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
   164					      &mbigen_irq_chip, mgn_irq_data);
   165	
   166		return 0;
   167	}
   168	
   169	static void mbigen_domain_free(struct irq_domain *domain, unsigned int virq,
   170				       unsigned int nr_irqs)
   171	{
   172		struct irq_data *d = irq_domain_get_irq_data(domain, virq);
   173		struct mbigen_irq_data *mgn_irq_data = irq_data_get_irq_chip_data(d);
   174	
   175		kfree(mgn_irq_data);
   176		irq_domain_free_irqs_common(domain, virq, nr_irqs);
   177	}
   178	
   179	static struct irq_domain_ops mbigen_domain_ops = {
   180		.translate	= mbigen_domain_translate,
   181		.alloc		= mbigen_irq_domain_alloc,
   182		.free		= mbigen_domain_free,
   183	};
   184	
   185	static int mbigen_device_probe(struct platform_device *pdev)
   186	{
   187		struct mbigen_device *mgn_chip;
   188		struct irq_domain *domain;
   189		u32 num_msis;
   190	
   191		mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
   192		if (!mgn_chip)
   193			return -ENOMEM;
   194	
   195		mgn_chip->pdev = pdev;
   196		mgn_chip->base = of_iomap(pdev->dev.of_node, 0);
   197	
   198		/* If there is no "num-msi" property, assume 64... */
   199		if (of_property_read_u32(pdev->dev.of_node, "num-msis", &num_msis) < 0)
   200			num_msis = 64;
   201	
 > 202		domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
   203								mbigen_write_msg,
   204								&mbigen_domain_ops,
   205								mgn_chip);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45865 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/b499d400/attachment-0001.obj>
