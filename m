From: lkp@intel.com (kbuild test robot)
Date: Wed, 31 Oct 2018 11:53:13 +0800
Subject: [xlnx:master 1783/2130] arch/arm/include/asm/io.h:100:2: warning:
 'pmap' may be used uninitialized in this function
Message-ID: <201810311109.nQC3Xt2O%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e0652408f6a3e2464aed159fa83dc3b2a2aadefd
commit: 71696811cb3f3c1e8c1ab40ae8f2f72de89363ba [1783/2130] net: xilinx: axiethernet: Split AXIDMA implementation in separate file
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 71696811cb3f3c1e8c1ab40ae8f2f72de89363ba
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

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
                    from drivers/net//ethernet/xilinx/xilinx_axienet.h:12,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm/include/asm/io.h:100:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
     ^~~
   drivers/net//ethernet/xilinx/xilinx_tsn_switch.c:723:6: note: 'pmap' was declared here
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
                    from drivers/net/ethernet/xilinx/xilinx_axienet.h:12,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.h:21,
                    from drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:18:
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c: In function 'tsnswitch_probe':
>> arch/arm/include/asm/io.h:100:2: warning: 'pmap' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
     ^~~
   drivers/net/ethernet/xilinx/xilinx_tsn_switch.c:723:6: note: 'pmap' was declared here
     u32 pmap;
         ^~~~

vim +/pmap +100 arch/arm/include/asm/io.h

195bbcac2 Will Deacon    2012-08-24   96  
84c4d3a6d Thierry Reding 2014-07-28   97  #define __raw_writel __raw_writel
195bbcac2 Will Deacon    2012-08-24   98  static inline void __raw_writel(u32 val, volatile void __iomem *addr)
195bbcac2 Will Deacon    2012-08-24   99  {
195bbcac2 Will Deacon    2012-08-24 @100  	asm volatile("str %1, %0"
5bb5d66d8 Peter Hurley   2015-04-13  101  		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
195bbcac2 Will Deacon    2012-08-24  102  }
195bbcac2 Will Deacon    2012-08-24  103  

:::::: The code at line 100 was first introduced by commit
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
Size: 64470 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181031/2c0c14d1/attachment-0001.gz>
