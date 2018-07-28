From: lkp@intel.com (kbuild test robot)
Date: Sun, 29 Jul 2018 03:27:45 +0800
Subject: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
In-Reply-To: <20180726151424.4bcecf41@xhacker.debian>
References: <20180726151424.4bcecf41@xhacker.debian>
Message-ID: <201807290313.14xizaiA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on ulf.hansson-mmc/next]
[also build test ERROR on next-20180727]
[cannot apply to v4.18-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/solve-SDHCI-DWC-MSHC-128MB-DMA-boundary-limitation/20180728-234650
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_adma_write_desc':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:18:12: error: 'SZ_128M' undeclared (first use in this function); did you mean 'PM_128K'?
     ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
               ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:34:6: note: in expansion of macro 'BOUNDARY_OK'
     if (BOUNDARY_OK(addr, len) || !len)
         ^~~~~~~~~~~
   drivers/mmc/host/sdhci-of-dwcmshc.c:18:12: note: each undeclared identifier is reported only once for each function it appears in
     ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
               ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:34:6: note: in expansion of macro 'BOUNDARY_OK'
     if (BOUNDARY_OK(addr, len) || !len)
         ^~~~~~~~~~~
   In file included from include/linux/cache.h:5:0,
                    from arch/mips/include/asm/cpu-info.h:15,
                    from arch/mips/include/asm/cpu-features.h:13,
                    from arch/mips/include/asm/bitops.h:21,
                    from include/linux/bitops.h:38,
                    from include/linux/kernel.h:11,
                    from include/linux/clk.h:16,
                    from drivers/mmc/host/sdhci-of-dwcmshc.c:10:
   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_probe':
   drivers/mmc/host/sdhci-of-dwcmshc.c:82:39: error: 'SZ_128M' undeclared (first use in this function); did you mean 'PM_128K'?
     extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
                                          ^
   include/uapi/linux/kernel.h:13:46: note: in definition of macro '__KERNEL_DIV_ROUND_UP'
    #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                                 ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:82:10: note: in expansion of macro 'DIV_ROUND_UP'
     extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
             ^~~~~~~~~~~~

vim +18 drivers/mmc/host/sdhci-of-dwcmshc.c

    16	
    17	#define BOUNDARY_OK(addr, len) \
  > 18		((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
    19	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56337 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180729/cb0f27e0/attachment-0001.gz>
