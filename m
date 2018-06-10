From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Jun 2018 18:44:39 +0800
Subject: [PATCH v5 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
In-Reply-To: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
Message-ID: <201806101827.lxH5Jvzl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Changbin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
config: i386-randconfig-x079-06101602 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/page_32.h:35:0,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from net//bluetooth/mgmt.c:27:
   net//bluetooth/mgmt.c: In function 'read_local_oob_ext_data_complete':
>> include/linux/string.h:345:9: warning: 'r256' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return __builtin_memcpy(p, q, size);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net//bluetooth/mgmt.c:5669:27: note: 'r256' was declared here
     u8 *h192, *r192, *h256, *r256;
                              ^~~~
--
   In file included from arch/x86/include/asm/page_32.h:35:0,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:38,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from net/bluetooth/mgmt.c:27:
   net/bluetooth/mgmt.c: In function 'read_local_oob_ext_data_complete':
>> include/linux/string.h:345:9: warning: 'r256' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return __builtin_memcpy(p, q, size);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5669:27: note: 'r256' was declared here
     u8 *h192, *r192, *h256, *r256;
                              ^~~~

vim +/r256 +345 include/linux/string.h

6974f0c4 Daniel Micay 2017-07-12  332  
6974f0c4 Daniel Micay 2017-07-12  333  __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
6974f0c4 Daniel Micay 2017-07-12  334  {
6974f0c4 Daniel Micay 2017-07-12  335  	size_t p_size = __builtin_object_size(p, 0);
6974f0c4 Daniel Micay 2017-07-12  336  	size_t q_size = __builtin_object_size(q, 0);
6974f0c4 Daniel Micay 2017-07-12  337  	if (__builtin_constant_p(size)) {
6974f0c4 Daniel Micay 2017-07-12  338  		if (p_size < size)
6974f0c4 Daniel Micay 2017-07-12  339  			__write_overflow();
6974f0c4 Daniel Micay 2017-07-12  340  		if (q_size < size)
6974f0c4 Daniel Micay 2017-07-12  341  			__read_overflow2();
6974f0c4 Daniel Micay 2017-07-12  342  	}
6974f0c4 Daniel Micay 2017-07-12  343  	if (p_size < size || q_size < size)
6974f0c4 Daniel Micay 2017-07-12  344  		fortify_panic(__func__);
6974f0c4 Daniel Micay 2017-07-12 @345  	return __builtin_memcpy(p, q, size);
6974f0c4 Daniel Micay 2017-07-12  346  }
6974f0c4 Daniel Micay 2017-07-12  347  

:::::: The code at line 345 was first introduced by commit
:::::: 6974f0c4555e285ab217cee58b6e874f776ff409 include/linux/string.h: add the option of fortified string.h functions

:::::: TO: Daniel Micay <danielmicay@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25414 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180610/4961cb0f/attachment-0001.gz>
