From: lkp@intel.com (kbuild test robot)
Date: Fri, 13 Jan 2017 18:16:53 +0800
Subject: [PATCH 2/2] arm64: avoid increasing DMA masks above what
 hardware supports
In-Reply-To: <1484159512-28515-3-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <201701131836.15bCKn91%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikita,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc3 next-20170112]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nikita-Yushchenko/dma-mapping-let-arch-know-origin-of-dma-range-passed-to-arch_setup_dma_ops/20170113-152733
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/dma-mapping.c: In function 'dma_set_mask':
>> arch/arm64/mm/dma-mapping.c:210:6: error: 'mask' undeclared (first use in this function)
     if (mask > dev->archdata.parent_dma_mask)
         ^~~~
   arch/arm64/mm/dma-mapping.c:210:6: note: each undeclared identifier is reported only once for each function it appears in

vim +/mask +210 arch/arm64/mm/dma-mapping.c

   204	}
   205	
   206	int dma_set_mask(struct device *dev, u64 dma_mask)
   207	{
   208		const struct dma_map_ops *ops = get_dma_ops(dev);
   209	
 > 210		if (mask > dev->archdata.parent_dma_mask)
   211			mask = dev->archdata.parent_dma_mask;
   212	
   213		if (ops->set_dma_mask)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33713 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170113/4aebcaaa/attachment-0001.gz>
