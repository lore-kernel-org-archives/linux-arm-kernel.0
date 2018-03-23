From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Mar 2018 12:14:18 +0800
Subject: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
Message-ID: <201803231138.06xQIU3w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/ib-Eliminate-duplicate-barriers-on-weakly-ordered-archs/20180321-091659
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:73:0,
                    from drivers/infiniband/hw/cxgb4/device.c:40:
   drivers/infiniband/hw/cxgb4/t4.h: In function 'pio_copy':
>> drivers/infiniband/hw/cxgb4/t4.h:460:3: error: implicit declaration of function 'writeq_relaxed'; did you mean 'write_pnet'? [-Werror=implicit-function-declaration]
      writeq_relaxed(*src, dst);
      ^~~~~~~~~~~~~~
      write_pnet
   cc1: some warnings being treated as errors
--
   In file included from drivers/infiniband/hw/cxgb4/iw_cxgb4.h:73:0,
                    from drivers/infiniband/hw/cxgb4/cm.c:53:
   drivers/infiniband/hw/cxgb4/t4.h: In function 'pio_copy':
>> drivers/infiniband/hw/cxgb4/t4.h:460:3: error: implicit declaration of function 'writeq_relaxed'; did you mean 'rt6_release'? [-Werror=implicit-function-declaration]
      writeq_relaxed(*src, dst);
      ^~~~~~~~~~~~~~
      rt6_release
   cc1: some warnings being treated as errors

vim +460 drivers/infiniband/hw/cxgb4/t4.h

   450	
   451	/* This function copies 64 byte coalesced work request to memory
   452	 * mapped BAR2 space. For coalesced WRs, the SGE fetches data
   453	 * from the FIFO instead of from Host.
   454	 */
   455	static inline void pio_copy(u64 __iomem *dst, u64 *src)
   456	{
   457		int count = 8;
   458	
   459		while (count) {
 > 460			writeq_relaxed(*src, dst);
   461			src++;
   462			dst++;
   463			count--;
   464		}
   465	}
   466	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62176 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180323/6e4cc2e2/attachment-0001.gz>
