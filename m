From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Feb 2016 09:05:44 +0800
Subject: [PATCH v1] kasan, arm64: Unpoison dirty stack frames when
 resuming from suspend.
In-Reply-To: <c08aa050cb03e40098775dc8d200f073451c342e.1456489933.git.glider@google.com>
Message-ID: <201602270944.MOAjfHX8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.5-rc5 next-20160226]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Potapenko/kasan-arm64-Unpoison-dirty-stack-frames-when-resuming-from-suspend/20160226-204052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   mm/kasan/kasan.c: In function 'kasan_stack_watermark':
>> mm/kasan/kasan.c:564:13: warning: assignment makes integer from pointer without a cast
     *watermark = __builtin_frame_address(0);
                ^
   mm/kasan/kasan.c: In function 'kasan_cpu_resume':
>> mm/kasan/kasan.c:570:21: warning: initialization makes integer from pointer without a cast
     unsigned long sp = __builtin_frame_address(0);
                        ^
>> mm/kasan/kasan.c:579:3: warning: passing argument 1 of 'kasan_unpoison_shadow' makes pointer from integer without a cast
      kasan_unpoison_shadow(*watermark, sp - *watermark);
      ^
   mm/kasan/kasan.c:53:6: note: expected 'const void *' but argument is of type 'long unsigned int'
    void kasan_unpoison_shadow(const void *address, size_t size)
         ^

vim +564 mm/kasan/kasan.c

   558	 * will be used upon resume to unpoison the dirty stack frames.
   559	 */
   560	void kasan_stack_watermark(void)
   561	{
   562		unsigned long *watermark = this_cpu_ptr(&cpu_stack_watermark);
   563	
 > 564		*watermark = __builtin_frame_address(0);
   565	}
   566	EXPORT_SYMBOL_GPL(kasan_stack_watermark);
   567	
   568	void kasan_cpu_resume(void)
   569	{
 > 570		unsigned long sp = __builtin_frame_address(0);
   571		unsigned long *watermark = this_cpu_ptr(&cpu_stack_watermark);
   572	
   573		if (*watermark == 0) {
   574			WARN_ON_ONCE(*watermark == 0);
   575			*watermark = sp;
   576			return;
   577		}
   578		if (sp > *watermark) {
 > 579			kasan_unpoison_shadow(*watermark, sp - *watermark);
   580			*watermark = 0;
   581		}
   582	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48245 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160227/22099514/attachment-0001.obj>
