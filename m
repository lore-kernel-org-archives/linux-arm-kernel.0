From: lkp@intel.com (kbuild test robot)
Date: Sun, 23 Jul 2017 10:33:03 +0800
Subject: [PATCH 4/5] PCI: mediatek: Add new generation controller support
In-Reply-To: <416c6158ac6dbb5ef3f55d0a0fe5ba015aee1cd5.1500601172.git.honghui.zhang@mediatek.com>
Message-ID: <201707231054.ZT0yH6mk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryder,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.13-rc1 next-20170721]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/honghui-zhang-mediatek-com/PCI-MediaTek-Add-support-for-new-generation-host-controller/20170723-040107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_startup_ports_v2':
>> drivers/pci/host/pcie-mediatek.c:86:36: warning: right shift count >= width of type [-Wshift-count-overflow]
    #define AHB2PCIE_BASEH(base) (base >> 32)
                                       ^
>> drivers/pci/host/pcie-mediatek.c:440:9: note: in expansion of macro 'AHB2PCIE_BASEH'
      val = AHB2PCIE_BASEH(mem->start);
            ^~~~~~~~~~~~~~
   drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_parse_ports':
>> drivers/pci/host/pcie-mediatek.c:789:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (pcie->soc->setup_irq)
     ^~
   drivers/pci/host/pcie-mediatek.c:791:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
      if (err)
      ^~

vim +86 drivers/pci/host/pcie-mediatek.c

    74	
    75	/* PCIe V2 per-port registers */
    76	#define PCIE_INT_MASK		0x420
    77	#define INTX_MASK		GENMASK(19, 16)
    78	#define INTX_SHIFT		16
    79	#define INTX_NUM		4
    80	#define PCIE_INT_STATUS		0x424
    81	#define AHB2PCIE_BASE0_L	0x438
    82	#define AHB2PCIE_BASE0_H	0x43c
    83	#define PCIE2AXI_WIN		0x448
    84	#define WIN_ENABLE		BIT(7)
    85	#define AHB2PCIE_BASEL(base)	(base & GENMASK(31, 0))
  > 86	#define AHB2PCIE_BASEH(base)	(base >> 32)
    87	#define BASE_SIZE(sz)		(sz & GENMASK(4, 0))
    88	#define PCIE2AXI_SIZE		0xffffffff
    89	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170723/57b1debf/attachment-0001.gz>
