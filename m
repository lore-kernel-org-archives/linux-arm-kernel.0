From: lkp@intel.com (kbuild test robot)
Date: Sun, 26 Mar 2017 15:28:02 +0800
Subject: [PATCH v3 4/7] alpha: Add support for memset16
In-Reply-To: <20170324161318.18718-5-willy@infradead.org>
Message-ID: <201703261542.3JwqrQIw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Add-memsetN-functions/20170326-140108
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:4,
                    from include/linux/sched.h:13,
                    from arch/alpha/kernel/asm-offsets.c:9:
   arch/alpha/include/asm/string.h: In function 'memset16':
>> arch/alpha/include/asm/string.h:74:2: error: expected ';' before 'return'
     return __memset16(p, v, n * 2);
     ^~~~~~
   make[2]: *** [arch/alpha/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +74 arch/alpha/include/asm/string.h

    68	#define __HAVE_ARCH_MEMSET16
    69	extern void * __memset16(void *dest, unsigned short, size_t count);
    70	static inline void *memset16(uint16_t *p, uint16_t v, size_t n)
    71	{
    72		if (__builtin_constant_p(v))
    73			return __constant_c_memset(p, 0x0001000100010001UL * v, n * 2)
  > 74		return __memset16(p, v, n * 2);
    75	}
    76	
    77	#endif /* __KERNEL__ */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49576 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/1a1fb4b2/attachment-0001.gz>
