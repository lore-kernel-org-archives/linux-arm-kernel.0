From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Nov 2017 11:41:16 +0800
Subject: [PATCH v4][for 4.15] dmaengine: dmatest: move callback wait
 queue to thread context
In-Reply-To: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
References: <1511191578-1781-1-git-send-email-awallis@codeaurora.org>
Message-ID: <201711231135.N6decPxS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20171122]
[cannot apply to v4.14]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Adam-Wallis/dmaengine-dmatest-move-callback-wait-queue-to-thread-context/20171123-101707
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   drivers//dma/dmatest.c: In function 'dmatest_callback':
>> drivers//dma/dmatest.c:358:3: error: call to '__compiletime_assert_358' declared with attribute error: pointer type mismatch in container_of()

vim +/__compiletime_assert_358 +358 drivers//dma/dmatest.c

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
Size: 51348 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/0d82fb69/attachment-0001.gz>
