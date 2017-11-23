From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Nov 2017 11:29:43 +0800
Subject: [PATCH v4][for 4.15] dmaengine: dmatest: move callback wait
 queue to thread context
In-Reply-To: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
References: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
Message-ID: <201711231023.g8OlwYsR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20171122]
[cannot apply to v4.14]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Adam-Wallis/dmaengine-dmatest-move-callback-wait-queue-to-thread-context/20171123-101707
config: i386-randconfig-x001-201747 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from include/linux/delay.h:22,
                    from drivers//dma/dmatest.c:13:
   drivers//dma/dmatest.c: In function 'dmatest_callback':
   include/linux/compiler.h:319:38: error: call to '__compiletime_assert_358' declared with attribute error: pointer type mismatch in container_of()
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:299:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:319:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:930:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
>> drivers//dma/dmatest.c:358:3: note: in expansion of macro 'container_of'
      container_of(done, struct dmatest_thread, done_wait);
      ^~~~~~~~~~~~

vim +/container_of +358 drivers//dma/dmatest.c

   352	
   353	
   354	static void dmatest_callback(void *arg)
   355	{
   356		struct dmatest_done *done = arg;
   357		struct dmatest_thread *thread =
 > 358			container_of(done, struct dmatest_thread, done_wait);
   359		if (!thread->done) {
   360			done->done = true;
   361			wake_up_all(done->wait);
   362		} else {
   363			/*
   364			 * If thread->done, it means that this callback occurred
   365			 * after the parent thread has cleaned up. This can
   366			 * happen in the case that driver doesn't implement
   367			 * the terminate_all() functionality and a dma operation
   368			 * did not occur within the timeout period
   369			 */
   370			WARN(1, "dmatest: Kernel memory may be corrupted!!\n");
   371		}
   372	}
   373	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32042 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/b3d358c5/attachment-0001.gz>
