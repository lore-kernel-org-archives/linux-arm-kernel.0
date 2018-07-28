From: lkp@intel.com (kbuild test robot)
Date: Sun, 29 Jul 2018 01:35:45 +0800
Subject: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
In-Reply-To: <20180726151424.4bcecf41@xhacker.debian>
References: <20180726151424.4bcecf41@xhacker.debian>
Message-ID: <201807290135.LvhI1VTR%fengguang.wu@intel.com>
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
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_adma_write_desc':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:18:12: error: 'SZ_128M' undeclared (first use in this function)
     ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
               ^
>> drivers/mmc/host/sdhci-of-dwcmshc.c:34:6: note: in expansion of macro 'BOUNDARY_OK'
     if (BOUNDARY_OK(addr, len) || !len)
         ^~~~~~~~~~~
   drivers/mmc/host/sdhci-of-dwcmshc.c:18:12: note: each undeclared identifier is reported only once for each function it appears in
     ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
               ^
>> drivers/mmc/host/sdhci-of-dwcmshc.c:34:6: note: in expansion of macro 'BOUNDARY_OK'
     if (BOUNDARY_OK(addr, len) || !len)
         ^~~~~~~~~~~
   In file included from include/linux/cache.h:5:0,
                    from include/linux/printk.h:9,
                    from include/linux/kernel.h:14,
                    from include/linux/clk.h:16,
                    from drivers/mmc/host/sdhci-of-dwcmshc.c:10:
   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_probe':
   drivers/mmc/host/sdhci-of-dwcmshc.c:82:39: error: 'SZ_128M' undeclared (first use in this function)
     extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
                                          ^
   include/uapi/linux/kernel.h:13:46: note: in definition of macro '__KERNEL_DIV_ROUND_UP'
    #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
                                                 ^
>> drivers/mmc/host/sdhci-of-dwcmshc.c:82:10: note: in expansion of macro 'DIV_ROUND_UP'
     extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
             ^~~~~~~~~~~~

vim +/SZ_128M +18 drivers/mmc/host/sdhci-of-dwcmshc.c

  > 10	#include <linux/clk.h>
    11	#include <linux/mm.h>
    12	#include <linux/module.h>
    13	#include <linux/of.h>
    14	
    15	#include "sdhci-pltfm.h"
    16	
    17	#define BOUNDARY_OK(addr, len) \
  > 18		((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
    19	
    20	struct dwcmshc_priv {
    21		struct clk	*bus_clk;
    22	};
    23	
    24	/*
    25	 * if DMA addr spans 128MB boundary, we split the DMA transfer into two
    26	 * so that the DMA transfer doesn't exceed the boundary.
    27	 */
    28	static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
    29						    void *desc, dma_addr_t addr,
    30						    int len, unsigned int cmd)
    31	{
    32		int tmplen, offset;
    33	
  > 34		if (BOUNDARY_OK(addr, len) || !len)
    35			return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
    36	
    37		offset = addr & (SZ_128M - 1);
    38		tmplen = SZ_128M - offset;
    39		_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
    40	
    41		addr += tmplen;
    42		len -= tmplen;
    43		desc += host->desc_sz;
    44		_sdhci_adma_write_desc(host, desc, addr, len, cmd);
    45	
    46		return host->desc_sz * 2;
    47	}
    48	
    49	static const struct sdhci_ops sdhci_dwcmshc_ops = {
    50		.set_clock		= sdhci_set_clock,
    51		.set_bus_width		= sdhci_set_bus_width,
    52		.set_uhs_signaling	= sdhci_set_uhs_signaling,
    53		.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
    54		.reset			= sdhci_reset,
    55		.adma_write_desc	= dwcmshc_adma_write_desc,
    56	};
    57	
    58	static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
    59		.ops = &sdhci_dwcmshc_ops,
    60		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
    61	};
    62	
    63	static int dwcmshc_probe(struct platform_device *pdev)
    64	{
    65		struct sdhci_pltfm_host *pltfm_host;
    66		struct sdhci_host *host;
    67		struct dwcmshc_priv *priv;
    68		int err;
    69		u32 extra;
    70	
    71		host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
    72					sizeof(struct dwcmshc_priv));
    73		if (IS_ERR(host))
    74			return PTR_ERR(host);
    75	
    76		/*
    77		 * The DMA descriptor table number is calculated as the maximum
    78		 * number of segments times 2, to allow for an alignment
    79		 * descriptor for each segment, plus 1 for a nop end descriptor,
    80		 * plus extra number for cross 128M boundary handling.
    81		 */
  > 82		extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
    83		if (extra > SDHCI_MAX_SEGS)
    84			extra = SDHCI_MAX_SEGS;
    85		host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
    86	
    87		pltfm_host = sdhci_priv(host);
    88		priv = sdhci_pltfm_priv(pltfm_host);
    89	
    90		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
    91		if (IS_ERR(pltfm_host->clk)) {
    92			err = PTR_ERR(pltfm_host->clk);
    93			dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
    94			goto free_pltfm;
    95		}
    96		err = clk_prepare_enable(pltfm_host->clk);
    97		if (err)
    98			goto free_pltfm;
    99	
   100		priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
   101		if (!IS_ERR(priv->bus_clk))
   102			clk_prepare_enable(priv->bus_clk);
   103	
   104		err = mmc_of_parse(host->mmc);
   105		if (err)
   106			goto err_clk;
   107	
   108		sdhci_get_of_property(pdev);
   109	
   110		err = sdhci_add_host(host);
   111		if (err)
   112			goto err_clk;
   113	
   114		return 0;
   115	
   116	err_clk:
   117		clk_disable_unprepare(pltfm_host->clk);
   118		clk_disable_unprepare(priv->bus_clk);
   119	free_pltfm:
   120		sdhci_pltfm_free(pdev);
   121		return err;
   122	}
   123	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64628 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180729/0e5bb783/attachment-0001.gz>
