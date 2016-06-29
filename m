From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 29 Jun 2016 09:45:53 +0800
Subject: [linux-next:master 5450/6660]
 arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared
 inside parameter list
In-Reply-To: <201606290335.vfTSIIB7%fengguang.wu@intel.com>
References: <201606290335.vfTSIIB7%fengguang.wu@intel.com>
Message-ID: <ca3837b2-df80-9c41-eb95-fc5b84468c22@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/29 3:12, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   6f2a161b1445a150f4a759194fde4c386f5e2947
> commit: 850bea2335e42780a0752a75860d3fbcc3d12d6e [5450/6660] arm: Remove unnecessary of_platform_populate with default match table
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 850bea2335e42780a0752a75860d3fbcc3d12d6e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c:18:0:
>>> arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list
>      unsigned long xusbxti_f, bool is_s3c6400, void __iomem *reg_base);
>      ^
>>> arch/arm/mach-s3c64xx/common.h:28:2: warning: its scope is only this definition or declaration, which is probably not what you want

From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Wed, 29 Jun 2016 09:28:48 +0800
Subject: [PATCH] ARM: s3c64xx: Add missing head file

The building reports warning after patch "arm: Remove unnecessary
of_platform_populate with default match table",

"arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list"

Add the missing of.h for device_node struct in common.h, and kill common.h
from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c, because no function need it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mach-s3c64xx/common.h          | 1 +
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 9eb8644..c2c8ac3 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -17,6 +17,7 @@
 #ifndef __ARCH_ARM_MACH_S3C64XX_COMMON_H
 #define __ARCH_ARM_MACH_S3C64XX_COMMON_H

+#include <linux/of.h>
 #include <linux/reboot.h>

 void s3c64xx_init_irq(u32 vic0, u32 vic1);
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 5bf9afa..be0678a 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -15,7 +15,6 @@
 #include <plat/cpu.h>
 #include <mach/map.h>

-#include "common.h"
 #include "watchdog-reset.h"

 /*
-- 
1.7.12.4




> 
> vim +28 arch/arm/mach-s3c64xx/common.h
> 
> b024043b6 Kukjin Kim  2011-12-22  12   * This program is free software; you can redistribute it and/or modify
> b024043b6 Kukjin Kim  2011-12-22  13   * it under the terms of the GNU General Public License version 2 as
> b024043b6 Kukjin Kim  2011-12-22  14   * published by the Free Software Foundation.
> b024043b6 Kukjin Kim  2011-12-22  15   */
> b024043b6 Kukjin Kim  2011-12-22  16  
> b024043b6 Kukjin Kim  2011-12-22  17  #ifndef __ARCH_ARM_MACH_S3C64XX_COMMON_H
> b024043b6 Kukjin Kim  2011-12-22  18  #define __ARCH_ARM_MACH_S3C64XX_COMMON_H
> b024043b6 Kukjin Kim  2011-12-22  19  
> 7b6d864b4 Robin Holt  2013-07-08  20  #include <linux/reboot.h>
> 7b6d864b4 Robin Holt  2013-07-08  21  
> b024043b6 Kukjin Kim  2011-12-22  22  void s3c64xx_init_irq(u32 vic0, u32 vic1);
> b024043b6 Kukjin Kim  2011-12-22  23  void s3c64xx_init_io(struct map_desc *mach_desc, int size);
> b024043b6 Kukjin Kim  2011-12-22  24  
> 7b6d864b4 Robin Holt  2013-07-08  25  void s3c64xx_restart(enum reboot_mode mode, const char *cmd);
> ff84ded26 Kukjin Kim  2012-01-03  26  
> b69f460dc Tomasz Figa 2013-08-26  27  void s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
> b69f460dc Tomasz Figa 2013-08-26 @28  	unsigned long xusbxti_f, bool is_s3c6400, void __iomem *reg_base);
> b69f460dc Tomasz Figa 2013-08-26  29  void s3c64xx_set_xtal_freq(unsigned long freq);
> b69f460dc Tomasz Figa 2013-08-26  30  void s3c64xx_set_xusbxti_freq(unsigned long freq);
> b69f460dc Tomasz Figa 2013-08-26  31  
> b024043b6 Kukjin Kim  2011-12-22  32  #ifdef CONFIG_CPU_S3C6400
> b024043b6 Kukjin Kim  2011-12-22  33  
> b024043b6 Kukjin Kim  2011-12-22  34  extern  int s3c6400_init(void);
> b024043b6 Kukjin Kim  2011-12-22  35  extern void s3c6400_init_irq(void);
> b024043b6 Kukjin Kim  2011-12-22  36  extern void s3c6400_map_io(void);
> 
> :::::: The code at line 28 was first introduced by commit
> :::::: b69f460dc1a074db3f759c2be9cd13271f91fbdd ARM: S3C64XX: Migrate clock handling to Common Clock Framework
> 
> :::::: TO: Tomasz Figa <tomasz.figa@gmail.com>
> :::::: CC: Kukjin Kim <kgene.kim@samsung.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
