From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jul 2016 13:42:32 +0800
Subject: [PATCH net-next 08/10] drivers: net: xgene: Poll link status via
 GPIO
In-Reply-To: <1469838843-19943-9-git-send-email-isubramanian@apm.com>
Message-ID: <201607301308.jiblYX9G%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/Fix-warning-and-issues/20160730-083713
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_irq_set_type':
   drivers/gpio/gpio-xgene-sb.c:111:10: error: implicit declaration of function 'irq_chip_set_type_parent' [-Werror=implicit-function-declaration]
      return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
             ^
   drivers/gpio/gpio-xgene-sb.c: At top level:
   drivers/gpio/gpio-xgene-sb.c:118:13: error: 'irq_chip_eoi_parent' undeclared here (not in a function)
     .irq_eoi = irq_chip_eoi_parent,
                ^
   drivers/gpio/gpio-xgene-sb.c:119:20: error: 'irq_chip_mask_parent' undeclared here (not in a function)
     .irq_mask       = irq_chip_mask_parent,
                       ^
   drivers/gpio/gpio-xgene-sb.c:120:20: error: 'irq_chip_unmask_parent' undeclared here (not in a function)
     .irq_unmask     = irq_chip_unmask_parent,
                       ^
   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_domain_alloc':
   drivers/gpio/gpio-xgene-sb.c:198:3: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
      irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
      ^
   drivers/gpio/gpio-xgene-sb.c:201:31: error: 'struct irq_domain' has no member named 'parent'
     parent_fwspec.fwnode = domain->parent->fwnode;
                                  ^
   drivers/gpio/gpio-xgene-sb.c:215:9: error: implicit declaration of function 'irq_domain_alloc_irqs_parent' [-Werror=implicit-function-declaration]
     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
            ^
   drivers/gpio/gpio-xgene-sb.c: At top level:
   drivers/gpio/gpio-xgene-sb.c:220:2: error: unknown field 'translate' specified in initializer
     .translate      = xgene_gpio_sb_domain_translate,
     ^
>> drivers/gpio/gpio-xgene-sb.c:220:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .translate      = xgene_gpio_sb_domain_translate,
                       ^
   drivers/gpio/gpio-xgene-sb.c:220:20: note: (near initialization for 'xgene_gpio_sb_domain_ops.match')
   drivers/gpio/gpio-xgene-sb.c:221:2: error: unknown field 'alloc' specified in initializer
     .alloc          = xgene_gpio_sb_domain_alloc,
     ^
   drivers/gpio/gpio-xgene-sb.c:221:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .alloc          = xgene_gpio_sb_domain_alloc,
                       ^
   drivers/gpio/gpio-xgene-sb.c:221:20: note: (near initialization for 'xgene_gpio_sb_domain_ops.select')
   drivers/gpio/gpio-xgene-sb.c:222:2: error: unknown field 'free' specified in initializer
     .free           = irq_domain_free_irqs_common,
     ^
   drivers/gpio/gpio-xgene-sb.c:222:20: error: 'irq_domain_free_irqs_common' undeclared here (not in a function)
     .free           = irq_domain_free_irqs_common,
                       ^
   drivers/gpio/gpio-xgene-sb.c:223:2: error: unknown field 'activate' specified in initializer
     .activate = xgene_gpio_sb_domain_activate,
     ^
   drivers/gpio/gpio-xgene-sb.c:223:14: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .activate = xgene_gpio_sb_domain_activate,
                 ^
   drivers/gpio/gpio-xgene-sb.c:223:14: note: (near initialization for 'xgene_gpio_sb_domain_ops.unmap')
   drivers/gpio/gpio-xgene-sb.c:224:2: error: unknown field 'deactivate' specified in initializer
     .deactivate = xgene_gpio_sb_domain_deactivate,
     ^
   drivers/gpio/gpio-xgene-sb.c:224:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .deactivate = xgene_gpio_sb_domain_deactivate,
                   ^
   drivers/gpio/gpio-xgene-sb.c:224:16: note: (near initialization for 'xgene_gpio_sb_domain_ops.xlate')
   drivers/gpio/gpio-xgene-sb.c: In function 'xgene_gpio_sb_probe':
   drivers/gpio/gpio-xgene-sb.c:293:21: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
                        ^
   drivers/gpio/gpio-xgene-sb.c:293:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     priv->irq_domain = irq_domain_create_hierarchy(parent_domain,
                      ^
   cc1: some warnings being treated as errors

vim +220 drivers/gpio/gpio-xgene-sb.c

1013fc41 Quan Nguyen 2016-02-17  209  		parent_fwspec.param_count = 2;
1013fc41 Quan Nguyen 2016-02-17  210  		parent_fwspec.param[0] = hwirq + priv->parent_irq_base;
1013fc41 Quan Nguyen 2016-02-17  211  		parent_fwspec.param[1] = fwspec->param[1];
1013fc41 Quan Nguyen 2016-02-17  212  	} else
1013fc41 Quan Nguyen 2016-02-17  213  		return -EINVAL;
1013fc41 Quan Nguyen 2016-02-17  214  
1013fc41 Quan Nguyen 2016-02-17 @215  	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
1013fc41 Quan Nguyen 2016-02-17  216  			&parent_fwspec);
1013fc41 Quan Nguyen 2016-02-17  217  }
1013fc41 Quan Nguyen 2016-02-17  218  
1013fc41 Quan Nguyen 2016-02-17  219  static const struct irq_domain_ops xgene_gpio_sb_domain_ops = {
1013fc41 Quan Nguyen 2016-02-17 @220  	.translate      = xgene_gpio_sb_domain_translate,
1013fc41 Quan Nguyen 2016-02-17  221  	.alloc          = xgene_gpio_sb_domain_alloc,
c6cc75fe Axel Lin    2016-03-17  222  	.free           = irq_domain_free_irqs_common,
1013fc41 Quan Nguyen 2016-02-17  223  	.activate	= xgene_gpio_sb_domain_activate,

:::::: The code at line 220 was first introduced by commit
:::::: 1013fc417cc15ead7c3a9091a47617f357db71a4 gpio: xgene: Enable X-Gene standby GPIO as interrupt controller

:::::: TO: Quan Nguyen <qnguyen@apm.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42688 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/f6bb2a14/attachment-0001.obj>
