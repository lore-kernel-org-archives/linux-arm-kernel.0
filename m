From: lkp@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 04:49:58 +0800
Subject: [PATCH net-next 5/6] drivers: net: xgene-v2: Add transmit and
 receive
In-Reply-To: <1485889401-13909-6-git-send-email-isubramanian@apm.com>
Message-ID: <201702010421.Lhy8B6ne%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iyappan,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/drivers-net-xgene-v2-Add-RGMII-based-1G-driver/20170201-034317
config: parisc-allyesconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All warnings (new ones prefixed by >>):

   In file included from include/linux/swab.h:4:0,
                    from include/uapi/linux/byteorder/big_endian.h:12,
                    from include/linux/byteorder/big_endian.h:4,
                    from arch/parisc/include/uapi/asm/byteorder.h:4,
                    from arch/parisc/include/asm/bitops.h:10,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/resource_ext.h:17,
                    from include/linux/acpi.h:26,
                    from drivers/net/ethernet/apm/xgene-v2/main.h:25,
                    from drivers/net/ethernet/apm/xgene-v2/main.c:22:
   drivers/net/ethernet/apm/xgene-v2/main.c: In function 'xge_refill_buffers':
   drivers/net/ethernet/apm/xgene-v2/main.c:162:20: warning: right shift count >= width of type [-Wshift-count-overflow]
              dma_addr >> PKT_ADDRL_LEN));
                       ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
>> include/linux/byteorder/generic.h:85:21: note: in expansion of macro '__cpu_to_le64'
    #define cpu_to_le64 __cpu_to_le64
                        ^~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:161:9: note: in expansion of macro 'SET_BITS'
            SET_BITS(PKT_ADDRH,
            ^~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:162:20: warning: right shift count >= width of type [-Wshift-count-overflow]
              dma_addr >> PKT_ADDRL_LEN));
                       ^
   include/uapi/linux/swab.h:131:12: note: in definition of macro '__swab64'
     __fswab64(x))
               ^
>> include/linux/byteorder/generic.h:85:21: note: in expansion of macro '__cpu_to_le64'
    #define cpu_to_le64 __cpu_to_le64
                        ^~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:161:9: note: in expansion of macro 'SET_BITS'
            SET_BITS(PKT_ADDRH,
            ^~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c: In function 'xge_start_xmit':
   drivers/net/ethernet/apm/xgene-v2/main.c:346:19: warning: right shift count >= width of type [-Wshift-count-overflow]
             dma_addr >> PKT_ADDRL_LEN));
                      ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
>> include/linux/byteorder/generic.h:85:21: note: in expansion of macro '__cpu_to_le64'
    #define cpu_to_le64 __cpu_to_le64
                        ^~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:345:8: note: in expansion of macro 'SET_BITS'
           SET_BITS(PKT_ADDRH,
           ^~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:346:19: warning: right shift count >= width of type [-Wshift-count-overflow]
             dma_addr >> PKT_ADDRL_LEN));
                      ^
   include/uapi/linux/swab.h:131:12: note: in definition of macro '__swab64'
     __fswab64(x))
               ^
>> include/linux/byteorder/generic.h:85:21: note: in expansion of macro '__cpu_to_le64'
    #define cpu_to_le64 __cpu_to_le64
                        ^~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c:345:8: note: in expansion of macro 'SET_BITS'
           SET_BITS(PKT_ADDRH,
           ^~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c: In function 'xge_rx_poll':
   drivers/net/ethernet/apm/xgene-v2/main.c:453:23: warning: left shift count >= width of type [-Wshift-count-overflow]
      dma_addr = (addr_hi << PKT_ADDRL_LEN) | addr_lo;
                          ^~

vim +/__cpu_to_le64 +85 include/linux/byteorder/generic.h

^1da177e Linus Torvalds 2005-04-16  69   *	cpu_to_[bl]eXX(__uXX x)
^1da177e Linus Torvalds 2005-04-16  70   *	[bl]eXX_to_cpu(__uXX x)
^1da177e Linus Torvalds 2005-04-16  71   *
^1da177e Linus Torvalds 2005-04-16  72   * The same, but takes a pointer to the value to convert
^1da177e Linus Torvalds 2005-04-16  73   *	cpu_to_[bl]eXXp(__uXX x)
^1da177e Linus Torvalds 2005-04-16  74   *	[bl]eXX_to_cpup(__uXX x)
^1da177e Linus Torvalds 2005-04-16  75   *
^1da177e Linus Torvalds 2005-04-16  76   * The same, but change in situ
^1da177e Linus Torvalds 2005-04-16  77   *	cpu_to_[bl]eXXs(__uXX x)
^1da177e Linus Torvalds 2005-04-16  78   *	[bl]eXX_to_cpus(__uXX x)
^1da177e Linus Torvalds 2005-04-16  79   *
^1da177e Linus Torvalds 2005-04-16  80   * See asm-foo/byteorder.h for examples of how to provide
^1da177e Linus Torvalds 2005-04-16  81   * architecture-optimized versions
^1da177e Linus Torvalds 2005-04-16  82   *
^1da177e Linus Torvalds 2005-04-16  83   */
^1da177e Linus Torvalds 2005-04-16  84  
^1da177e Linus Torvalds 2005-04-16 @85  #define cpu_to_le64 __cpu_to_le64
^1da177e Linus Torvalds 2005-04-16  86  #define le64_to_cpu __le64_to_cpu
^1da177e Linus Torvalds 2005-04-16  87  #define cpu_to_le32 __cpu_to_le32
^1da177e Linus Torvalds 2005-04-16  88  #define le32_to_cpu __le32_to_cpu
^1da177e Linus Torvalds 2005-04-16  89  #define cpu_to_le16 __cpu_to_le16
^1da177e Linus Torvalds 2005-04-16  90  #define le16_to_cpu __le16_to_cpu
^1da177e Linus Torvalds 2005-04-16  91  #define cpu_to_be64 __cpu_to_be64
^1da177e Linus Torvalds 2005-04-16  92  #define be64_to_cpu __be64_to_cpu
^1da177e Linus Torvalds 2005-04-16  93  #define cpu_to_be32 __cpu_to_be32

:::::: The code at line 85 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48442 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/7498852d/attachment-0001.gz>
