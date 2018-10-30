From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 Oct 2018 18:26:59 +0800
Subject: [xlnx:master 1783/2130] arch/arm64/include/asm/io.h:54:2: warning:
 'pmap' may be used uninitialized in this function
Message-ID: <201810301856.PdeUoovf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priyadarshini,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e0652408f6a3e2464aed159fa83dc3b2a2aadefd
commit: 71696811cb3f3c1e8c1ab40ae8f2f72de89363ba [1783/2130] net: xilinx: axiethernet: Split AXIDMA implementation in separate file
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 71696811cb3f3c1e8c1ab40ae8f2f72de89363ba
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/scatterlist.h:9:0,
                    from include/linux/dma-mapping.h:11,
                    from include/linux/skbuff.h:35,
                    from include/linux/if_ether.h:23,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:41,
                    from drivers/net/ethernet/xilinx/xilinx_axienet.h:12,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm64/include/asm/io.h:54:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
     ^~~
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:723:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~
--
   In file included from include/linux/scatterlist.h:9:0,
                    from include/linux/dma-mapping.h:11,
                    from include/linux/skbuff.h:35,
                    from include/linux/if_ether.h:23,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:41,
                    from drivers/net//ethernet/xilinx/xilinx_axienet.h:12,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm64/include/asm/io.h:54:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
     ^~~
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:723:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~

vim +/pmap +54 arch/arm64/include/asm/io.h

fc47897d Catalin Marinas 2012-03-05  50  
09a57239 Thierry Reding  2014-07-28  51  #define __raw_writel __raw_writel
fc47897d Catalin Marinas 2012-03-05  52  static inline void __raw_writel(u32 val, volatile void __iomem *addr)
fc47897d Catalin Marinas 2012-03-05  53  {
ee5e41b5 Robin Murphy    2016-09-08 @54  	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
fc47897d Catalin Marinas 2012-03-05  55  }
fc47897d Catalin Marinas 2012-03-05  56  

:::::: The code at line 54 was first introduced by commit
:::::: ee5e41b5f21a5438664effce1ba5bdd11e03ee24 arm64/io: Allow I/O writes to use {W,X}ZR

:::::: TO: Robin Murphy <robin.murphy@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58068 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181030/4329326c/attachment-0001.gz>
