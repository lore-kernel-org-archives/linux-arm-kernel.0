From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 23 Dec 2017 08:40:27 +0800
Subject: [xlnx:master 1106/1121] arch/arm64/include/asm/io.h:55:2: warning:
 'pmap' may be used uninitialized in this function
Message-ID: <201712230824.Xs5EMuHw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   9c2e29b2c81dbb1efb7ee4944b18e12226b97513
commit: 75d045afd1d68c05256340776d0fdedbe741842e [1106/1121] drivers: net: ethernet: TSN QBV- Map ST Gate State value
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 75d045afd1d68c05256340776d0fdedbe741842e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dmaengine.h:24,
                    from include/linux/netdevice.h:38,
                    from drivers/net//ethernet/xilinx/xilinx_axienet.h:11,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm64/include/asm/io.h:55:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
     ^~~
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:722:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~
--
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dmaengine.h:24,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/xilinx/xilinx_axienet.h:11,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm64/include/asm/io.h:55:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
     ^~~
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:722:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~

vim +/pmap +55 arch/arm64/include/asm/io.h

fc47897d2 Catalin Marinas 2012-03-05  51  
09a572398 Thierry Reding  2014-07-28  52  #define __raw_writel __raw_writel
fc47897d2 Catalin Marinas 2012-03-05  53  static inline void __raw_writel(u32 val, volatile void __iomem *addr)
fc47897d2 Catalin Marinas 2012-03-05  54  {
ee5e41b5f Robin Murphy    2016-09-08 @55  	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
fc47897d2 Catalin Marinas 2012-03-05  56  }
fc47897d2 Catalin Marinas 2012-03-05  57  

:::::: The code at line 55 was first introduced by commit
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
Size: 52933 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171223/6d2929e1/attachment-0001.gz>
