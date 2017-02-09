From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 01:11:15 +0800
Subject: [stericsson:mmc-no-NULL 32/34] drivers/mmc/core/queue.h:13:4: note:
 in expansion of macro 'req_op'
Message-ID: <201702100108.pjGLvqhX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   1bec9a625b256f78d00c38b58caad7ccdae8aaf5
commit: 8b8bcac0e2f2356064488868b08c7d4fe8ef1f44 [32/34] mmc: queue: get/put struct mmc_queue_req
config: x86_64-randconfig-x014-201706 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 8b8bcac0e2f2356064488868b08c7d4fe8ef1f44
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mmc/core/core.c:42:0:
   drivers/mmc/core/queue.h:10:46: warning: 'struct request' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool mmc_req_is_special(struct request *req)
                                                 ^~~~~~~
   In file included from include/linux/writeback.h:12:0,
                    from include/linux/memcontrol.h:30,
                    from include/linux/swap.h:8,
                    from include/linux/suspend.h:4,
                    from drivers/mmc/core/core.c:27:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
>> include/linux/blk_types.h:209:8: error: dereferencing pointer to incomplete type 'struct request'
     ((req)->cmd_flags & REQ_OP_MASK)
           ^
>> drivers/mmc/core/queue.h:13:4: note: in expansion of macro 'req_op'
      (req_op(req) == REQ_OP_FLUSH ||
       ^~~~~~

vim +/req_op +13 drivers/mmc/core/queue.h

^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds 2005-04-16   1  #ifndef MMC_QUEUE_H
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds 2005-04-16   2  #define MMC_QUEUE_H
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds 2005-04-16   3  
adc91efbc drivers/mmc/core/queue.h Ulf Hansson    2017-01-13   4  #include <linux/types.h>
8b8bcac0e drivers/mmc/core/queue.h Linus Walleij  2017-02-09   5  #include <linux/spinlock.h>
adc91efbc drivers/mmc/core/queue.h Ulf Hansson    2017-01-13   6  #include <linux/blkdev.h>
adc91efbc drivers/mmc/core/queue.h Ulf Hansson    2017-01-13   7  #include <linux/mmc/core.h>
adc91efbc drivers/mmc/core/queue.h Ulf Hansson    2017-01-13   8  #include <linux/mmc/host.h>
adc91efbc drivers/mmc/core/queue.h Ulf Hansson    2017-01-13   9  
c2df40dfb drivers/mmc/card/queue.h Mike Christie  2016-06-05  10  static inline bool mmc_req_is_special(struct request *req)
c2df40dfb drivers/mmc/card/queue.h Mike Christie  2016-06-05  11  {
3a5e02ced drivers/mmc/card/queue.h Mike Christie  2016-06-05  12  	return req &&
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter  2016-08-16 @13  		(req_op(req) == REQ_OP_FLUSH ||
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter  2016-08-16  14  		 req_op(req) == REQ_OP_DISCARD ||
7afafc8a4 drivers/mmc/card/queue.h Adrian Hunter  2016-08-16  15  		 req_op(req) == REQ_OP_SECURE_ERASE);
c2df40dfb drivers/mmc/card/queue.h Mike Christie  2016-06-05  16  }
ef3a69c7a drivers/mmc/card/queue.h Seungwon Jeon  2013-03-14  17  
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds 2005-04-16  18  struct task_struct;
7db3028e0 drivers/mmc/card/queue.h Linus Walleij  2016-11-18  19  struct mmc_blk_data;
^1da177e4 drivers/mmc/mmc_queue.h  Linus Torvalds 2005-04-16  20  
97868a2bd drivers/mmc/card/queue.h Per Forlin     2011-07-09  21  struct mmc_blk_request {

:::::: The code at line 13 was first introduced by commit
:::::: 7afafc8a44bf0ab841b17d450b02aedb3a138985 block: Fix secure erase

:::::: TO: Adrian Hunter <adrian.hunter@intel.com>
:::::: CC: Jens Axboe <axboe@fb.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21694 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/ba56dc00/attachment-0001.gz>
