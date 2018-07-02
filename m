From: lkp@intel.com (kbuild test robot)
Date: Mon, 2 Jul 2018 15:21:56 +0800
Subject: [PATCH v2 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
In-Reply-To: <1530503384-1218-4-git-send-email-honghui.zhang@mediatek.com>
References: <1530503384-1218-4-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <201807021314.g0DZwyBM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Honghui,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.18-rc3 next-20180629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/honghui-zhang-mediatek-com/PCI-mediatek-fixup-find_port-enable_msi-and-add-pm-module-support/20180702-115447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-mediatek.c: In function 'mtk_pcie_resume_noirq':
>> drivers/pci/controller/pcie-mediatek.c:1249:51: error: macro "list_for_each_entry_safe" requires 4 arguments, but only 3 given
     list_for_each_entry_safe(port, &pcie->ports, list)
                                                      ^
>> drivers/pci/controller/pcie-mediatek.c:1249:2: error: unknown type name 'list_for_each_entry_safe'
     list_for_each_entry_safe(port, &pcie->ports, list)
     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-mediatek.c:1250:3: warning: parameter names (without types) in function declaration
      mtk_pcie_enable_port(port);
      ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-mediatek.c:1250:3: error: conflicting types for 'mtk_pcie_enable_port'
   drivers/pci/controller/pcie-mediatek.c:794:13: note: previous definition of 'mtk_pcie_enable_port' was here
    static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
                ^~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-mediatek.c:1249:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     list_for_each_entry_safe(port, &pcie->ports, list)
     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:1234:24: warning: unused variable 'port' [-Wunused-variable]
     struct mtk_pcie_port *port;
                           ^~~~

vim +/list_for_each_entry_safe +1249 drivers/pci/controller/pcie-mediatek.c

  1229	
  1230	static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
  1231	{
  1232		struct mtk_pcie *pcie = dev_get_drvdata(dev);
  1233		const struct mtk_pcie_soc *soc = pcie->soc;
  1234		struct mtk_pcie_port *port;
  1235	
  1236		if (!soc->pm_support)
  1237			return 0;
  1238	
  1239		if (list_empty(&pcie->ports))
  1240			return 0;
  1241	
  1242		if (dev->pm_domain) {
  1243			pm_runtime_enable(dev);
  1244			pm_runtime_get_sync(dev);
  1245		}
  1246	
  1247		clk_prepare_enable(pcie->free_ck);
  1248	
> 1249		list_for_each_entry_safe(port, &pcie->ports, list)
> 1250			mtk_pcie_enable_port(port);
  1251	
  1252		/* In case of EP was removed while system suspend. */
  1253		if (list_empty(&pcie->ports))
  1254			mtk_pcie_subsys_powerdown(pcie);
  1255	
  1256		return 0;
  1257	}
  1258	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63999 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/21dfd43e/attachment-0001.gz>
