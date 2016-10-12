From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Oct 2016 06:06:26 +0800
Subject: [arm-soc:to-build 1/3] arch/x86/include/asm/thread_info.h:174:11:
 warning: calling '__builtin_frame_address' with a nonzero argument is unsafe
Message-ID: <201610130620.AU1Lhqk7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   b0a8f2c6d232f3f8463955e5927c56dd057495b1
commit: 3ddcb978f68b765b3af38bf45bf4a1a4b0a87df1 [1/3] Revert "Disable "maybe-uninitialized" warning globally"
config: i386-randconfig-s1-201641 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 3ddcb978f68b765b3af38bf45bf4a1a4b0a87df1
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:69:0,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/mm.h:9,
                    from mm/usercopy.c:17:
   arch/x86/include/asm/thread_info.h: In function 'check_stack_object':
>> arch/x86/include/asm/thread_info.h:174:11: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
     oldframe = __builtin_frame_address(1);
     ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/thread_info.h:176:9: warning: calling '__builtin_frame_address' with a nonzero argument is unsafe [-Wframe-address]
      frame = __builtin_frame_address(2);
      ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/__builtin_frame_address +174 arch/x86/include/asm/thread_info.h

0f60a8ef Kees Cook 2016-07-12  158   * Walks up the stack frames to make sure that the specified object is
0f60a8ef Kees Cook 2016-07-12  159   * entirely contained by a single stack frame.
0f60a8ef Kees Cook 2016-07-12  160   *
0f60a8ef Kees Cook 2016-07-12  161   * Returns:
0f60a8ef Kees Cook 2016-07-12  162   *		 1 if within a frame
0f60a8ef Kees Cook 2016-07-12  163   *		-1 if placed across a frame boundary (or outside stack)
0f60a8ef Kees Cook 2016-07-12  164   *		 0 unable to determine (no frame pointers, etc)
0f60a8ef Kees Cook 2016-07-12  165   */
0f60a8ef Kees Cook 2016-07-12  166  static inline int arch_within_stack_frames(const void * const stack,
0f60a8ef Kees Cook 2016-07-12  167  					   const void * const stackend,
0f60a8ef Kees Cook 2016-07-12  168  					   const void *obj, unsigned long len)
0f60a8ef Kees Cook 2016-07-12  169  {
0f60a8ef Kees Cook 2016-07-12  170  #if defined(CONFIG_FRAME_POINTER)
0f60a8ef Kees Cook 2016-07-12  171  	const void *frame = NULL;
0f60a8ef Kees Cook 2016-07-12  172  	const void *oldframe;
0f60a8ef Kees Cook 2016-07-12  173  
0f60a8ef Kees Cook 2016-07-12 @174  	oldframe = __builtin_frame_address(1);
0f60a8ef Kees Cook 2016-07-12  175  	if (oldframe)
0f60a8ef Kees Cook 2016-07-12  176  		frame = __builtin_frame_address(2);
0f60a8ef Kees Cook 2016-07-12  177  	/*
0f60a8ef Kees Cook 2016-07-12  178  	 * low ----------------------------------------------> high
0f60a8ef Kees Cook 2016-07-12  179  	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
0f60a8ef Kees Cook 2016-07-12  180  	 *                     ^----------------^
0f60a8ef Kees Cook 2016-07-12  181  	 *               allow copies only within here
0f60a8ef Kees Cook 2016-07-12  182  	 */

:::::: The code at line 174 was first introduced by commit
:::::: 0f60a8efe4005ab5e65ce000724b04d4ca04a199 mm: Implement stack frame object validation

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24527 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161013/8e639a65/attachment-0001.gz>
