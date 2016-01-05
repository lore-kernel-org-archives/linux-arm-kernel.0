From: lkp@intel.com (kbuild test robot)
Date: Tue, 5 Jan 2016 20:47:37 +0800
Subject: [PATCH 03/11] mmc: sdhci-msm: use sdhci_pltfm_init for private
 allocation
In-Reply-To: <1451991099-4946-4-git-send-email-jszhang@marvell.com>
Message-ID: <201601052054.hzEzw4pe%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

[auto build test WARNING on v4.4-rc8]
[also build test WARNING on next-20160105]
[cannot apply to ulf.hansson-mmc/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/mmc-sdhci-bcm2835-use-sdhci_pltfm_init-for-private-allocation/20160105-190232
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-msm.c: In function 'sdhci_msm_probe':
>> drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host' is used uninitialized in this function [-Wuninitialized]
     host = sdhci_pltfm_init(pdev, &msm_host->sdhci_msm_pdata,
                                   ^

vim +/msm_host +440 drivers/mmc/host/sdhci-msm.c

   424		.set_clock = sdhci_set_clock,
   425		.set_bus_width = sdhci_set_bus_width,
   426		.set_uhs_signaling = sdhci_set_uhs_signaling,
   427	};
   428	
   429	static int sdhci_msm_probe(struct platform_device *pdev)
   430	{
   431		struct sdhci_host *host;
   432		struct sdhci_pltfm_host *pltfm_host;
   433		struct sdhci_msm_host *msm_host;
   434		struct resource *core_memres;
   435		int ret;
   436		u16 host_version, core_minor;
   437		u32 core_version, caps;
   438		u8 core_major;
   439	
 > 440		host = sdhci_pltfm_init(pdev, &msm_host->sdhci_msm_pdata,
   441					sizeof(*msm_host));
   442		if (IS_ERR(host))
   443			return PTR_ERR(host);
   444	
   445		pltfm_host = sdhci_priv(host);
   446		msm_host = sdhci_pltfm_priv(pltfm_host);
   447		msm_host->sdhci_msm_pdata.ops = &sdhci_msm_ops;
   448		msm_host->mmc = host->mmc;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46668 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/966879d4/attachment-0001.obj>
