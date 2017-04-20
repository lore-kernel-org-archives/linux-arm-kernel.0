From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 20 Apr 2017 21:08:29 +0800
Subject: [arm:for-next 9/10] include/linux/bitops.h:56:34: error: passing
 argument 1 of '_find_next_zero_bit_le' from incompatible pointer type
Message-ID: <201704202122.19GxTlev%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
head:   b353b2cf63d7b9d5031ca7fd259ab58e492e7dc1
commit: c4f8ff16b46b3857a1e0a3b06b2b5c74c8556eda [9/10] ARM: 8669/1: bitops: Align prototypes to generic API
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c4f8ff16b46b3857a1e0a3b06b2b5c74c8556eda
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:36:0,
                    from include/linux/bitmap.h:7,
                    from drivers/dma/sun4i-dma.c:11:
   drivers/dma/sun4i-dma.c: In function 'find_and_use_pchan':
>> include/linux/bitops.h:56:34: error: passing argument 1 of '_find_next_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
     for ((bit) = find_next_zero_bit((addr), (size), (bit)); \
                                     ^
   arch/arm/include/asm/bitops.h:200:61: note: in definition of macro 'find_next_zero_bit'
    #define find_next_zero_bit(p,sz,off) _find_next_zero_bit_le(p,sz,off)
                                                                ^
>> drivers/dma/sun4i-dma.c:241:2: note: in expansion of macro 'for_each_clear_bit_from'
     for_each_clear_bit_from(i, &priv->pchans_used, max) {
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:163:12: note: expected 'const long unsigned int *' but argument is of type 'long unsigned int (*)[1]'
    extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:58:34: error: passing argument 1 of '_find_next_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
          (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
                                     ^
   arch/arm/include/asm/bitops.h:200:61: note: in definition of macro 'find_next_zero_bit'
    #define find_next_zero_bit(p,sz,off) _find_next_zero_bit_le(p,sz,off)
                                                                ^
>> drivers/dma/sun4i-dma.c:241:2: note: in expansion of macro 'for_each_clear_bit_from'
     for_each_clear_bit_from(i, &priv->pchans_used, max) {
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:163:12: note: expected 'const long unsigned int *' but argument is of type 'long unsigned int (*)[1]'
    extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/bitops.h:36:0,
                    from include/linux/bitmap.h:7,
                    from drivers//dma/sun4i-dma.c:11:
   drivers//dma/sun4i-dma.c: In function 'find_and_use_pchan':
>> include/linux/bitops.h:56:34: error: passing argument 1 of '_find_next_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
     for ((bit) = find_next_zero_bit((addr), (size), (bit)); \
                                     ^
   arch/arm/include/asm/bitops.h:200:61: note: in definition of macro 'find_next_zero_bit'
    #define find_next_zero_bit(p,sz,off) _find_next_zero_bit_le(p,sz,off)
                                                                ^
   drivers//dma/sun4i-dma.c:241:2: note: in expansion of macro 'for_each_clear_bit_from'
     for_each_clear_bit_from(i, &priv->pchans_used, max) {
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:163:12: note: expected 'const long unsigned int *' but argument is of type 'long unsigned int (*)[1]'
    extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:58:34: error: passing argument 1 of '_find_next_zero_bit_le' from incompatible pointer type [-Werror=incompatible-pointer-types]
          (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
                                     ^
   arch/arm/include/asm/bitops.h:200:61: note: in definition of macro 'find_next_zero_bit'
    #define find_next_zero_bit(p,sz,off) _find_next_zero_bit_le(p,sz,off)
                                                                ^
   drivers//dma/sun4i-dma.c:241:2: note: in expansion of macro 'for_each_clear_bit_from'
     for_each_clear_bit_from(i, &priv->pchans_used, max) {
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:163:12: note: expected 'const long unsigned int *' but argument is of type 'long unsigned int (*)[1]'
    extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/_find_next_zero_bit_le +56 include/linux/bitops.h

4677d4a5 Borislav Petkov 2010-05-03  30  extern unsigned long __sw_hweight64(__u64 w);
4677d4a5 Borislav Petkov 2010-05-03  31  
^1da177e Linus Torvalds  2005-04-16  32  /*
^1da177e Linus Torvalds  2005-04-16  33   * Include this here because some architectures need generic_ffs/fls in
^1da177e Linus Torvalds  2005-04-16  34   * scope
^1da177e Linus Torvalds  2005-04-16  35   */
^1da177e Linus Torvalds  2005-04-16 @36  #include <asm/bitops.h>
^1da177e Linus Torvalds  2005-04-16  37  
984b3f57 Akinobu Mita    2010-03-05  38  #define for_each_set_bit(bit, addr, size) \
3e037454 Shannon Nelson  2007-10-16  39  	for ((bit) = find_first_bit((addr), (size));		\
3e037454 Shannon Nelson  2007-10-16  40  	     (bit) < (size);					\
3e037454 Shannon Nelson  2007-10-16  41  	     (bit) = find_next_bit((addr), (size), (bit) + 1))
3e037454 Shannon Nelson  2007-10-16  42  
1e2ad28f Robert Richter  2011-11-18  43  /* same as for_each_set_bit() but use bit as value to start with */
307b1cd7 Akinobu Mita    2012-03-23  44  #define for_each_set_bit_from(bit, addr, size) \
1e2ad28f Robert Richter  2011-11-18  45  	for ((bit) = find_next_bit((addr), (size), (bit));	\
1e2ad28f Robert Richter  2011-11-18  46  	     (bit) < (size);					\
1e2ad28f Robert Richter  2011-11-18  47  	     (bit) = find_next_bit((addr), (size), (bit) + 1))
1e2ad28f Robert Richter  2011-11-18  48  
03f4a822 Akinobu Mita    2012-03-23  49  #define for_each_clear_bit(bit, addr, size) \
03f4a822 Akinobu Mita    2012-03-23  50  	for ((bit) = find_first_zero_bit((addr), (size));	\
03f4a822 Akinobu Mita    2012-03-23  51  	     (bit) < (size);					\
03f4a822 Akinobu Mita    2012-03-23  52  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
03f4a822 Akinobu Mita    2012-03-23  53  
03f4a822 Akinobu Mita    2012-03-23  54  /* same as for_each_clear_bit() but use bit as value to start with */
03f4a822 Akinobu Mita    2012-03-23  55  #define for_each_clear_bit_from(bit, addr, size) \
03f4a822 Akinobu Mita    2012-03-23 @56  	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
03f4a822 Akinobu Mita    2012-03-23  57  	     (bit) < (size);					\
03f4a822 Akinobu Mita    2012-03-23  58  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
03f4a822 Akinobu Mita    2012-03-23  59  

:::::: The code at line 56 was first introduced by commit
:::::: 03f4a8226c2f9c14361f75848d1e93139bab90c4 bitops: introduce for_each_clear_bit()

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20782 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/4a18f434/attachment-0001.gz>
