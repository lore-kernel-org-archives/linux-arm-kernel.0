From: lkp@intel.com (kbuild test robot)
Date: Sun, 26 Mar 2017 17:53:55 +0800
Subject: [PATCH v3 7/7] vga: Optimise console scrolling
In-Reply-To: <20170324161318.18718-8-willy@infradead.org>
Message-ID: <201703261730.9nRIHfGC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/Add-memsetN-functions/20170326-140108
config: mips-defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h: In function 'scr_memsetw':
>> include/linux/vt_buffer.h:34:2: error: implicit declaration of function 'memset16' [-Werror=implicit-function-declaration]
     memset16(s, c, count / 2);
     ^~~~~~~~
   include/linux/vt_buffer.h: In function 'scr_memcpyw':
>> include/linux/vt_buffer.h:47:2: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
     memcpy(d, s, count);
     ^~~~~~
   include/linux/vt_buffer.h: In function 'scr_memmovew':
>> include/linux/vt_buffer.h:66:2: error: implicit declaration of function 'memmove' [-Werror=implicit-function-declaration]
     memmove(d, s, count);
     ^~~~~~~
   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
   arch/mips/include/asm/string.h: At top level:
>> arch/mips/include/asm/string.h:138:14: error: conflicting types for 'memcpy'
    extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
                 ^~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:47:2: note: previous implicit declaration of 'memcpy' was here
     memcpy(d, s, count);
     ^~~~~~
   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
>> arch/mips/include/asm/string.h:141:14: error: conflicting types for 'memmove'
    extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
                 ^~~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:66:2: note: previous implicit declaration of 'memmove' was here
     memmove(d, s, count);
     ^~~~~~~
   In file included from include/linux/bitmap.h:8:0,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:25,
                    from include/asm-generic/preempt.h:4,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/wait.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:4,
                    from include/linux/vt_kern.h:11,
                    from drivers/video/console/newport_con.c:18:
   include/linux/string.h:104:14: error: conflicting types for 'memset16'
    extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
                 ^~~~~~~~
   In file included from include/linux/selection.h:11:0,
                    from drivers/video/console/newport_con.c:16:
   include/linux/vt_buffer.h:34:2: note: previous implicit declaration of 'memset16' was here
     memset16(s, c, count / 2);
     ^~~~~~~~
   cc1: some warnings being treated as errors

vim +/memset16 +34 include/linux/vt_buffer.h

    28	{
    29	#ifdef VT_BUF_HAVE_RW
    30		count /= 2;
    31		while (count--)
    32			scr_writew(c, s++);
    33	#else
  > 34		memset16(s, c, count / 2);
    35	#endif
    36	}
    37	#endif
    38	
    39	#ifndef VT_BUF_HAVE_MEMCPYW
    40	static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
    41	{
    42	#ifdef VT_BUF_HAVE_RW
    43		count /= 2;
    44		while (count--)
    45			scr_writew(scr_readw(s++), d++);
    46	#else
  > 47		memcpy(d, s, count);
    48	#endif
    49	}
    50	#endif
    51	
    52	#ifndef VT_BUF_HAVE_MEMMOVEW
    53	static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
    54	{
    55	#ifdef VT_BUF_HAVE_RW
    56		if (d < s)
    57			scr_memcpyw(d, s, count);
    58		else {
    59			count /= 2;
    60			d += count;
    61			s += count;
    62			while (count--)
    63				scr_writew(scr_readw(--s), --d);
    64		}
    65	#else
  > 66		memmove(d, s, count);
    67	#endif
    68	}
    69	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 13581 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170326/f2c361de/attachment-0001.gz>
