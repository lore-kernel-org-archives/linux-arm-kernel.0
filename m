From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Nov 2018 06:24:02 +0800
Subject: [arm-platforms:pci/dwc-mask 2/3]
 drivers/pci/controller/dwc/pcie-designware-host.c:208:35: error: 'flags'
 undeclared; did you mean 'class'?
Message-ID: <201811140600.lhmAcFMg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git pci/dwc-mask
head:   921b42033f8ed0ee5aed9d77ebe29c9efc70df0e
commit: 598caf3b94cec0a5e666295665987aa493a2ba8e [2/3] PCI: designware: Take lock when ACKing an interrupt
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 598caf3b94cec0a5e666295665987aa493a2ba8e
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:50:0,
                    from include/linux/irq.h:14,
                    from include/linux/irqchip/chained_irq.h:21,
                    from drivers/pci/controller/dwc/pcie-designware-host.c:11:
   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_pci_bottom_ack':
>> drivers/pci/controller/dwc/pcie-designware-host.c:208:35: error: 'flags' undeclared (first use in this function); did you mean 'class'?
     raw_spin_lock_irqsave(&pp->lock, flags);
                                      ^
   include/linux/typecheck.h:11:9: note: in definition of macro 'typecheck'
     typeof(x) __dummy2; \
            ^
>> drivers/pci/controller/dwc/pcie-designware-host.c:208:2: note: in expansion of macro 'raw_spin_lock_irqsave'
     raw_spin_lock_irqsave(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:208:35: note: each undeclared identifier is reported only once for each function it appears in
     raw_spin_lock_irqsave(&pp->lock, flags);
                                      ^
   include/linux/typecheck.h:11:9: note: in definition of macro 'typecheck'
     typeof(x) __dummy2; \
            ^
>> drivers/pci/controller/dwc/pcie-designware-host.c:208:2: note: in expansion of macro 'raw_spin_lock_irqsave'
     raw_spin_lock_irqsave(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/spinlock.h:240:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags); \
      ^~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:208:2: note: in expansion of macro 'raw_spin_lock_irqsave'
     raw_spin_lock_irqsave(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: warning: comparison of distinct pointer types lacks a cast
     (void)(&__dummy == &__dummy2); \
                     ^
   include/linux/spinlock.h:278:3: note: in expansion of macro 'typecheck'
      typecheck(unsigned long, flags);  \
      ^~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:213:2: note: in expansion of macro 'raw_spin_unlock_irqrestore'
     raw_spin_unlock_irqrestore(&pp->lock, flags);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~

vim +208 drivers/pci/controller/dwc/pcie-designware-host.c

  > 11	#include <linux/irqchip/chained_irq.h>
    12	#include <linux/irqdomain.h>
    13	#include <linux/of_address.h>
    14	#include <linux/of_pci.h>
    15	#include <linux/pci_regs.h>
    16	#include <linux/platform_device.h>
    17	
    18	#include "../../pci.h"
    19	#include "pcie-designware.h"
    20	
    21	static struct pci_ops dw_pcie_ops;
    22	
    23	static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
    24				       u32 *val)
    25	{
    26		struct dw_pcie *pci;
    27	
    28		if (pp->ops->rd_own_conf)
    29			return pp->ops->rd_own_conf(pp, where, size, val);
    30	
    31		pci = to_dw_pcie_from_pp(pp);
    32		return dw_pcie_read(pci->dbi_base + where, size, val);
    33	}
    34	
    35	static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
    36				       u32 val)
    37	{
    38		struct dw_pcie *pci;
    39	
    40		if (pp->ops->wr_own_conf)
    41			return pp->ops->wr_own_conf(pp, where, size, val);
    42	
    43		pci = to_dw_pcie_from_pp(pp);
    44		return dw_pcie_write(pci->dbi_base + where, size, val);
    45	}
    46	
    47	static void dw_msi_ack_irq(struct irq_data *d)
    48	{
    49		irq_chip_ack_parent(d);
    50	}
    51	
    52	static void dw_msi_mask_irq(struct irq_data *d)
    53	{
    54		pci_msi_mask_irq(d);
    55		irq_chip_mask_parent(d);
    56	}
    57	
    58	static void dw_msi_unmask_irq(struct irq_data *d)
    59	{
    60		pci_msi_unmask_irq(d);
    61		irq_chip_unmask_parent(d);
    62	}
    63	
    64	static struct irq_chip dw_pcie_msi_irq_chip = {
    65		.name = "PCI-MSI",
    66		.irq_ack = dw_msi_ack_irq,
    67		.irq_mask = dw_msi_mask_irq,
    68		.irq_unmask = dw_msi_unmask_irq,
    69	};
    70	
    71	static struct msi_domain_info dw_pcie_msi_domain_info = {
    72		.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
    73			   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
    74		.chip	= &dw_pcie_msi_irq_chip,
    75	};
    76	
    77	/* MSI int handler */
    78	irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
    79	{
    80		int i, pos, irq;
    81		u32 val, num_ctrls;
    82		irqreturn_t ret = IRQ_NONE;
    83	
    84		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
    85	
    86		for (i = 0; i < num_ctrls; i++) {
    87			dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
    88						(i * MSI_REG_CTRL_BLOCK_SIZE),
    89					    4, &val);
    90			if (!val)
    91				continue;
    92	
    93			ret = IRQ_HANDLED;
    94			pos = 0;
    95			while ((pos = find_next_bit((unsigned long *) &val,
    96						    MAX_MSI_IRQS_PER_CTRL,
    97						    pos)) != MAX_MSI_IRQS_PER_CTRL) {
    98				irq = irq_find_mapping(pp->irq_domain,
    99						       (i * MAX_MSI_IRQS_PER_CTRL) +
   100						       pos);
   101				generic_handle_irq(irq);
   102				dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
   103							(i * MSI_REG_CTRL_BLOCK_SIZE),
   104						    4, 1 << pos);
   105				pos++;
   106			}
   107		}
   108	
   109		return ret;
   110	}
   111	
   112	/* Chained MSI interrupt service routine */
   113	static void dw_chained_msi_isr(struct irq_desc *desc)
   114	{
   115		struct irq_chip *chip = irq_desc_get_chip(desc);
   116		struct pcie_port *pp;
   117	
   118		chained_irq_enter(chip, desc);
   119	
   120		pp = irq_desc_get_handler_data(desc);
   121		dw_handle_msi_irq(pp);
   122	
   123		chained_irq_exit(chip, desc);
   124	}
   125	
   126	static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
   127	{
   128		struct pcie_port *pp = irq_data_get_irq_chip_data(data);
   129		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   130		u64 msi_target;
   131	
   132		if (pp->ops->get_msi_addr)
   133			msi_target = pp->ops->get_msi_addr(pp);
   134		else
   135			msi_target = (u64)pp->msi_data;
   136	
   137		msg->address_lo = lower_32_bits(msi_target);
   138		msg->address_hi = upper_32_bits(msi_target);
   139	
   140		if (pp->ops->get_msi_data)
   141			msg->data = pp->ops->get_msi_data(pp, data->hwirq);
   142		else
   143			msg->data = data->hwirq;
   144	
   145		dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
   146			(int)data->hwirq, msg->address_hi, msg->address_lo);
   147	}
   148	
   149	static int dw_pci_msi_set_affinity(struct irq_data *irq_data,
   150					   const struct cpumask *mask, bool force)
   151	{
   152		return -EINVAL;
   153	}
   154	
   155	static void dw_pci_bottom_mask(struct irq_data *data)
   156	{
   157		struct pcie_port *pp = irq_data_get_irq_chip_data(data);
   158		unsigned int res, bit, ctrl;
   159		unsigned long flags;
   160	
   161		raw_spin_lock_irqsave(&pp->lock, flags);
   162	
   163		if (pp->ops->msi_clear_irq) {
   164			pp->ops->msi_clear_irq(pp, data->hwirq);
   165		} else {
   166			ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
   167			res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
   168			bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
   169	
   170			pp->irq_status[ctrl] &= ~(1 << bit);
   171			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
   172					    pp->irq_status[ctrl]);
   173		}
   174	
   175		raw_spin_unlock_irqrestore(&pp->lock, flags);
   176	}
   177	
   178	static void dw_pci_bottom_unmask(struct irq_data *data)
   179	{
   180		struct pcie_port *pp = irq_data_get_irq_chip_data(data);
   181		unsigned int res, bit, ctrl;
   182		unsigned long flags;
   183	
   184		raw_spin_lock_irqsave(&pp->lock, flags);
   185	
   186		if (pp->ops->msi_set_irq) {
   187			pp->ops->msi_set_irq(pp, data->hwirq);
   188		} else {
   189			ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
   190			res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
   191			bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
   192	
   193			pp->irq_status[ctrl] |= 1 << bit;
   194			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
   195					    pp->irq_status[ctrl]);
   196		}
   197	
   198		raw_spin_unlock_irqrestore(&pp->lock, flags);
   199	}
   200	
   201	static void dw_pci_bottom_ack(struct irq_data *d)
   202	{
   203		struct msi_desc *msi = irq_data_get_msi_desc(d);
   204		struct pcie_port *pp;
   205	
   206		pp = msi_desc_to_pci_sysdata(msi);
   207	
 > 208		raw_spin_lock_irqsave(&pp->lock, flags);
   209	
   210		if (pp->ops->msi_irq_ack)
   211			pp->ops->msi_irq_ack(d->hwirq, pp);
   212	
 > 213		raw_spin_unlock_irqrestore(&pp->lock, flags);
   214	}
   215	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66605 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/bdd62550/attachment-0001.gz>
