From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 29 Dec 2017 13:04:48 +0800
Subject: [rjarzmik:pxa/for-next 7/10] drivers/gpio/gpio-reg.c:106:21: error:
 'struct gpio_reg' has no member named 'irq'; did you mean 'irqs'?
Message-ID: <201712291346.zodpF8b6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux pxa/for-next
head:   8957e25fd563aca4a15383e9f3a1a679e03b76aa
commit: 9c66638412cd2162f02f9beb12f5495bfe650d03 [7/10] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
config: arm-lubbock_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9c66638412cd2162f02f9beb12f5495bfe650d03
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-reg.c: In function 'gpio_reg_to_irq':
>> drivers/gpio/gpio-reg.c:106:21: error: 'struct gpio_reg' has no member named 'irq'; did you mean 'irqs'?
     if (irq >= 0 && r->irq.domain)
                        ^~~
                        irqs
   drivers/gpio/gpio-reg.c:107:29: error: 'struct gpio_reg' has no member named 'irq'; did you mean 'irqs'?
      irq = irq_find_mapping(r->irq.domain, irq);
                                ^~~
                                irqs

vim +106 drivers/gpio/gpio-reg.c

380639c7 Russell King   2016-08-31  100  
0e3cb6ee Russell King   2016-09-02  101  static int gpio_reg_to_irq(struct gpio_chip *gc, unsigned offset)
0e3cb6ee Russell King   2016-09-02  102  {
0e3cb6ee Russell King   2016-09-02  103  	struct gpio_reg *r = to_gpio_reg(gc);
0e3cb6ee Russell King   2016-09-02  104  	int irq = r->irqs[offset];
0e3cb6ee Russell King   2016-09-02  105  
f0fbe7bc Thierry Reding 2017-11-07 @106  	if (irq >= 0 && r->irq.domain)
f0fbe7bc Thierry Reding 2017-11-07  107  		irq = irq_find_mapping(r->irq.domain, irq);
0e3cb6ee Russell King   2016-09-02  108  
0e3cb6ee Russell King   2016-09-02  109  	return irq;
0e3cb6ee Russell King   2016-09-02  110  }
0e3cb6ee Russell King   2016-09-02  111  

:::::: The code at line 106 was first introduced by commit
:::::: f0fbe7bce733561b76a5b55c5f4625888acd3792 gpio: Move irqdomain into struct gpio_irq_chip

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 13375 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171229/1325fb3a/attachment-0001.gz>
