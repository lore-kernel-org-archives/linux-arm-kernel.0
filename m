From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 23 Dec 2017 08:38:37 +0800
Subject: [xlnx:master 1106/1121] arch/arm/include/asm/io.h:101:2: warning:
 'pmap' may be used uninitialized in this function
Message-ID: <201712230834.uU7Jhogj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   9c2e29b2c81dbb1efb7ee4944b18e12226b97513
commit: 75d045afd1d68c05256340776d0fdedbe741842e [1106/1121] drivers: net: ethernet: TSN QBV- Map ST Gate State value
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 75d045afd1d68c05256340776d0fdedbe741842e
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

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
>> arch/arm/include/asm/io.h:101:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
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
>> arch/arm/include/asm/io.h:101:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
     ^~~
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:722:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~

vim +/pmap +101 arch/arm/include/asm/io.h

195bbcac2 Will Deacon    2012-08-24   97  
84c4d3a6d Thierry Reding 2014-07-28   98  #define __raw_writel __raw_writel
195bbcac2 Will Deacon    2012-08-24   99  static inline void __raw_writel(u32 val, volatile void __iomem *addr)
195bbcac2 Will Deacon    2012-08-24  100  {
195bbcac2 Will Deacon    2012-08-24 @101  	asm volatile("str %1, %0"
5bb5d66d8 Peter Hurley   2015-04-13  102  		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
195bbcac2 Will Deacon    2012-08-24  103  }
195bbcac2 Will Deacon    2012-08-24  104  

:::::: The code at line 101 was first introduced by commit
:::::: 195bbcac2e5c12f7fb99cdcc492c3000c5537f4a ARM: 7500/1: io: avoid writeback addressing modes for __raw_ accessors

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59883 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171223/88e5abcb/attachment-0001.gz>
