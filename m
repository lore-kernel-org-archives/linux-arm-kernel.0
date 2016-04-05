From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 6 Apr 2016 06:52:08 +0800
Subject: [arm-platforms:irq/percpu-partition 4/5]
 drivers/irqchip/irq-partition-percpu.c:102:2: error: implicit declaration of
 function 'seq_printf'
Message-ID: <201604060607.866QNds6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/percpu-partition
head:   452d6110d1a1b660f3af1c345515c05463a40afc
commit: bc141791ab2c8383c2501829e4d5a56e28d062b0 [4/5] irqchip/gic-v3: Add support for partitionned PPIs
config: arm64-alldefconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bc141791ab2c8383c2501829e4d5a56e28d062b0
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-partition-percpu.c: In function 'partition_irq_print_chip':
>> drivers/irqchip/irq-partition-percpu.c:102:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
     seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
     ^
   cc1: some warnings being treated as errors

vim +/seq_printf +102 drivers/irqchip/irq-partition-percpu.c

c6a92952 Marc Zyngier 2016-04-05   86  	struct partition_desc *part = irq_data_get_irq_chip_data(d);
c6a92952 Marc Zyngier 2016-04-05   87  	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
c6a92952 Marc Zyngier 2016-04-05   88  	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
c6a92952 Marc Zyngier 2016-04-05   89  
c6a92952 Marc Zyngier 2016-04-05   90  	if (chip->irq_set_type)
c6a92952 Marc Zyngier 2016-04-05   91  		return chip->irq_set_type(data, type);
c6a92952 Marc Zyngier 2016-04-05   92  
c6a92952 Marc Zyngier 2016-04-05   93  	return -EINVAL;
c6a92952 Marc Zyngier 2016-04-05   94  }
c6a92952 Marc Zyngier 2016-04-05   95  
c6a92952 Marc Zyngier 2016-04-05   96  static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
c6a92952 Marc Zyngier 2016-04-05   97  {
c6a92952 Marc Zyngier 2016-04-05   98  	struct partition_desc *part = irq_data_get_irq_chip_data(d);
c6a92952 Marc Zyngier 2016-04-05   99  	struct irq_chip *chip = irq_desc_get_chip(part->chained_desc);
c6a92952 Marc Zyngier 2016-04-05  100  	struct irq_data *data = irq_desc_get_irq_data(part->chained_desc);
c6a92952 Marc Zyngier 2016-04-05  101  
c6a92952 Marc Zyngier 2016-04-05 @102  	seq_printf(p, " %5s-%lu", chip->name, data->hwirq);
c6a92952 Marc Zyngier 2016-04-05  103  }
c6a92952 Marc Zyngier 2016-04-05  104  
c6a92952 Marc Zyngier 2016-04-05  105  static struct irq_chip partition_irq_chip = {
c6a92952 Marc Zyngier 2016-04-05  106  	.irq_mask		= partition_irq_mask,
c6a92952 Marc Zyngier 2016-04-05  107  	.irq_unmask		= partition_irq_unmask,
c6a92952 Marc Zyngier 2016-04-05  108  	.irq_set_type		= partition_irq_set_type,
c6a92952 Marc Zyngier 2016-04-05  109  	.irq_get_irqchip_state	= partition_irq_get_irqchip_state,
c6a92952 Marc Zyngier 2016-04-05  110  	.irq_set_irqchip_state	= partition_irq_set_irqchip_state,

:::::: The code at line 102 was first introduced by commit
:::::: c6a9295215cc6ccb22e25408f58fd2335cb9fb75 irqchip: Add per-cpu interrupt partitionning library

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 8121 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160406/580105b7/attachment.obj>
