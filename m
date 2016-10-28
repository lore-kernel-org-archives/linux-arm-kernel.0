From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Oct 2016 03:26:13 +0800
Subject: [PATCH v2 3/5] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <202cdeff42a2de149c471630110a8b2657ccf5ca.1477669745.git.stillcompiling@gmail.com>
Message-ID: <201610290332.4bQNcPz6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc2 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161029-012535
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/fpga/cyclone-ps-spi.c:13:0:
   drivers/fpga/cyclone-ps-spi.c: In function 'rev_buf':
>> include/linux/bitrev.h:12:21: error: implicit declaration of function '__arch_bitrev8x4' [-Werror=implicit-function-declaration]
    #define __bitrev8x4 __arch_bitrev8x4
                        ^
>> include/linux/bitrev.h:101:2: note: in expansion of macro '__bitrev8x4'
     __bitrev8x4(__x);    \
     ^~~~~~~~~~~
>> drivers/fpga/cyclone-ps-spi.c:75:11: note: in expansion of macro 'bitrev8x4'
      *fw32 = bitrev8x4(*fw32);
              ^~~~~~~~~
   In file included from include/linux/delay.h:10:0,
                    from drivers/fpga/cyclone-ps-spi.c:14:
   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
   include/linux/kernel.h:739:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   \
                   ^
   include/linux/kernel.h:742:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   \
     ^~~~~
   drivers/fpga/cyclone-ps-spi.c:89:19: note: in expansion of macro 'min'
      size_t stride = min(fw_data_end - fw_data, SZ_4K);
                      ^~~
   cc1: some warnings being treated as errors

vim +/__arch_bitrev8x4 +12 include/linux/bitrev.h

556d2f05 Yalin Wang     2014-11-03    6  #ifdef CONFIG_HAVE_ARCH_BITREVERSE
556d2f05 Yalin Wang     2014-11-03    7  #include <asm/bitrev.h>
556d2f05 Yalin Wang     2014-11-03    8  
556d2f05 Yalin Wang     2014-11-03    9  #define __bitrev32 __arch_bitrev32
556d2f05 Yalin Wang     2014-11-03   10  #define __bitrev16 __arch_bitrev16
556d2f05 Yalin Wang     2014-11-03   11  #define __bitrev8 __arch_bitrev8
69ff2a81 Joshua Clayton 2016-10-28  @12  #define __bitrev8x4 __arch_bitrev8x4
a5cfc1ec Akinobu Mita   2006-12-08   13  
556d2f05 Yalin Wang     2014-11-03   14  #else
556d2f05 Yalin Wang     2014-11-03   15  extern u8 const byte_rev_table[256];
556d2f05 Yalin Wang     2014-11-03   16  static inline u8 __bitrev8(u8 byte)
a5cfc1ec Akinobu Mita   2006-12-08   17  {
a5cfc1ec Akinobu Mita   2006-12-08   18  	return byte_rev_table[byte];
a5cfc1ec Akinobu Mita   2006-12-08   19  }
a5cfc1ec Akinobu Mita   2006-12-08   20  
556d2f05 Yalin Wang     2014-11-03   21  static inline u16 __bitrev16(u16 x)
556d2f05 Yalin Wang     2014-11-03   22  {
556d2f05 Yalin Wang     2014-11-03   23  	return (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8);
556d2f05 Yalin Wang     2014-11-03   24  }
556d2f05 Yalin Wang     2014-11-03   25  
556d2f05 Yalin Wang     2014-11-03   26  static inline u32 __bitrev32(u32 x)
556d2f05 Yalin Wang     2014-11-03   27  {
556d2f05 Yalin Wang     2014-11-03   28  	return (__bitrev16(x & 0xffff) << 16) | __bitrev16(x >> 16);
556d2f05 Yalin Wang     2014-11-03   29  }
556d2f05 Yalin Wang     2014-11-03   30  
69ff2a81 Joshua Clayton 2016-10-28   31  static inline u32 __bitrev8x4(u32 x)
69ff2a81 Joshua Clayton 2016-10-28   32  {
69ff2a81 Joshua Clayton 2016-10-28   33  	return(__bitrev8(x & 0xff) |
69ff2a81 Joshua Clayton 2016-10-28   34  	       (__bitrev8((x >> 8)  & 0xff) << 8) |
69ff2a81 Joshua Clayton 2016-10-28   35  	       (__bitrev8((x >> 16)  & 0xff) << 16) |
69ff2a81 Joshua Clayton 2016-10-28   36  	       (__bitrev8((x >> 24)  & 0xff) << 24));
69ff2a81 Joshua Clayton 2016-10-28   37  }
69ff2a81 Joshua Clayton 2016-10-28   38  
556d2f05 Yalin Wang     2014-11-03   39  #endif /* CONFIG_HAVE_ARCH_BITREVERSE */
556d2f05 Yalin Wang     2014-11-03   40  
556d2f05 Yalin Wang     2014-11-03   41  #define __constant_bitrev32(x)	\
556d2f05 Yalin Wang     2014-11-03   42  ({					\
556d2f05 Yalin Wang     2014-11-03   43  	u32 __x = x;			\
556d2f05 Yalin Wang     2014-11-03   44  	__x = (__x >> 16) | (__x << 16);	\
556d2f05 Yalin Wang     2014-11-03   45  	__x = ((__x & (u32)0xFF00FF00UL) >> 8) | ((__x & (u32)0x00FF00FFUL) << 8);	\
556d2f05 Yalin Wang     2014-11-03   46  	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
556d2f05 Yalin Wang     2014-11-03   47  	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
556d2f05 Yalin Wang     2014-11-03   48  	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
556d2f05 Yalin Wang     2014-11-03   49  	__x;								\
556d2f05 Yalin Wang     2014-11-03   50  })
556d2f05 Yalin Wang     2014-11-03   51  
556d2f05 Yalin Wang     2014-11-03   52  #define __constant_bitrev16(x)	\
556d2f05 Yalin Wang     2014-11-03   53  ({					\
556d2f05 Yalin Wang     2014-11-03   54  	u16 __x = x;			\
556d2f05 Yalin Wang     2014-11-03   55  	__x = (__x >> 8) | (__x << 8);	\
556d2f05 Yalin Wang     2014-11-03   56  	__x = ((__x & (u16)0xF0F0U) >> 4) | ((__x & (u16)0x0F0FU) << 4);	\
556d2f05 Yalin Wang     2014-11-03   57  	__x = ((__x & (u16)0xCCCCU) >> 2) | ((__x & (u16)0x3333U) << 2);	\
556d2f05 Yalin Wang     2014-11-03   58  	__x = ((__x & (u16)0xAAAAU) >> 1) | ((__x & (u16)0x5555U) << 1);	\
556d2f05 Yalin Wang     2014-11-03   59  	__x;								\
556d2f05 Yalin Wang     2014-11-03   60  })
556d2f05 Yalin Wang     2014-11-03   61  
69ff2a81 Joshua Clayton 2016-10-28   62  #define __constant_bitrev8x4(x) \
69ff2a81 Joshua Clayton 2016-10-28   63  ({			\
69ff2a81 Joshua Clayton 2016-10-28   64  	u32 __x = x;	\
69ff2a81 Joshua Clayton 2016-10-28   65  	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
69ff2a81 Joshua Clayton 2016-10-28   66  	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
69ff2a81 Joshua Clayton 2016-10-28   67  	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
69ff2a81 Joshua Clayton 2016-10-28   68  	__x;								\
69ff2a81 Joshua Clayton 2016-10-28   69  })
69ff2a81 Joshua Clayton 2016-10-28   70  
556d2f05 Yalin Wang     2014-11-03   71  #define __constant_bitrev8(x)	\
556d2f05 Yalin Wang     2014-11-03   72  ({					\
556d2f05 Yalin Wang     2014-11-03   73  	u8 __x = x;			\
556d2f05 Yalin Wang     2014-11-03   74  	__x = (__x >> 4) | (__x << 4);	\
556d2f05 Yalin Wang     2014-11-03   75  	__x = ((__x & (u8)0xCCU) >> 2) | ((__x & (u8)0x33U) << 2);	\
556d2f05 Yalin Wang     2014-11-03   76  	__x = ((__x & (u8)0xAAU) >> 1) | ((__x & (u8)0x55U) << 1);	\
556d2f05 Yalin Wang     2014-11-03   77  	__x;								\
556d2f05 Yalin Wang     2014-11-03   78  })
556d2f05 Yalin Wang     2014-11-03   79  
556d2f05 Yalin Wang     2014-11-03   80  #define bitrev32(x) \
556d2f05 Yalin Wang     2014-11-03   81  ({			\
556d2f05 Yalin Wang     2014-11-03   82  	u32 __x = x;	\
556d2f05 Yalin Wang     2014-11-03   83  	__builtin_constant_p(__x) ?	\
556d2f05 Yalin Wang     2014-11-03   84  	__constant_bitrev32(__x) :			\
556d2f05 Yalin Wang     2014-11-03   85  	__bitrev32(__x);				\
556d2f05 Yalin Wang     2014-11-03   86  })
556d2f05 Yalin Wang     2014-11-03   87  
556d2f05 Yalin Wang     2014-11-03   88  #define bitrev16(x) \
556d2f05 Yalin Wang     2014-11-03   89  ({			\
556d2f05 Yalin Wang     2014-11-03   90  	u16 __x = x;	\
556d2f05 Yalin Wang     2014-11-03   91  	__builtin_constant_p(__x) ?	\
556d2f05 Yalin Wang     2014-11-03   92  	__constant_bitrev16(__x) :			\
556d2f05 Yalin Wang     2014-11-03   93  	__bitrev16(__x);				\
556d2f05 Yalin Wang     2014-11-03   94   })
a5cfc1ec Akinobu Mita   2006-12-08   95  
69ff2a81 Joshua Clayton 2016-10-28   96  #define bitrev8x4(x) \
69ff2a81 Joshua Clayton 2016-10-28   97  ({			\
69ff2a81 Joshua Clayton 2016-10-28   98  	u32 __x = x;	\
69ff2a81 Joshua Clayton 2016-10-28   99  	__builtin_constant_p(__x) ?	\
69ff2a81 Joshua Clayton 2016-10-28  100  	__constant_bitrev8x4(__x) :			\
69ff2a81 Joshua Clayton 2016-10-28 @101  	__bitrev8x4(__x);				\
69ff2a81 Joshua Clayton 2016-10-28  102  })
69ff2a81 Joshua Clayton 2016-10-28  103  
556d2f05 Yalin Wang     2014-11-03  104  #define bitrev8(x) \

:::::: The code at line 12 was first introduced by commit
:::::: 69ff2a81709e0969b2d1a0efaa9a010e0093917c lib: add bitrev8x4()

:::::: TO: Joshua Clayton <stillcompiling@gmail.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52470 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161029/eb4a95b7/attachment-0001.gz>
