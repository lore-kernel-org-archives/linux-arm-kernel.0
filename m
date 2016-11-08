From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Nov 2016 14:11:48 +0800
Subject: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201611081454.el7dW6X4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.9-rc4 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161108-114742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers/bus/hisi_lpc.c: In function 'hisilpc_probe':
>> drivers/bus/hisi_lpc.c:439:45: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat=]
      dev_err(&pdev->dev, "ioremap memory FAIL(%d)!\n",
                                                ^

vim +439 drivers/bus/hisi_lpc.c

   423	{
   424		struct resource *iores;
   425		struct hisilpc_dev *lpcdev;
   426		int ret;
   427	
   428		dev_info(&pdev->dev, "probing hslpc...\n");
   429	
   430		lpcdev = devm_kzalloc(&pdev->dev,
   431					sizeof(struct hisilpc_dev), GFP_KERNEL);
   432		if (!lpcdev)
   433			return -ENOMEM;
   434	
   435		spin_lock_init(&lpcdev->cycle_lock);
   436		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   437		lpcdev->membase = devm_ioremap_resource(&pdev->dev, iores);
   438		if (IS_ERR(lpcdev->membase)) {
 > 439			dev_err(&pdev->dev, "ioremap memory FAIL(%d)!\n",
   440					PTR_ERR(lpcdev->membase));
   441			return PTR_ERR(lpcdev->membase);
   442		}
   443		/*
   444		 * The first PCIBIOS_MIN_IO is reserved specifically for indirectIO.
   445		 * It will separate indirectIO range from pci host bridge to
   446		 * avoid the possible PIO conflict.
   447		 * Set the indirectIO range directly here.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51464 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/819b59bc/attachment-0001.gz>
