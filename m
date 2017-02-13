From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 13 Feb 2017 21:27:27 +0800
Subject: [stericsson:mmc-no-NULL 32/34] include/linux/blk_types.h:209:8:
 error: dereferencing pointer to incomplete type 'struct request'
Message-ID: <201702132124.SZtav17Y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   c8140f7069d2f17882ea16e78265b7e31c4b5e45
commit: b4522625e1bdb00314b9e5685660b0c764452569 [32/34] mmc: queue: get/put struct mmc_queue_req
config: x86_64-randconfig-x017-201707 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout b4522625e1bdb00314b9e5685660b0c764452569
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

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
   drivers/mmc/core/queue.h:13:4: note: in expansion of macro 'req_op'
      (req_op(req) == REQ_OP_FLUSH ||
       ^~~~~~

vim +209 include/linux/blk_types.h

a2b80967 Christoph Hellwig  2016-11-01  193  #define REQ_IDLE		(1ULL << __REQ_IDLE)
180b2f95 Martin K. Petersen 2014-09-26  194  #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
ef295ecf Christoph Hellwig  2016-10-28  195  #define REQ_FUA			(1ULL << __REQ_FUA)
ef295ecf Christoph Hellwig  2016-10-28  196  #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
ef295ecf Christoph Hellwig  2016-10-28  197  #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
1d796d6a Jens Axboe         2016-11-01  198  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
7cc01581 Tejun Heo          2010-08-03  199  
7cc01581 Tejun Heo          2010-08-03  200  #define REQ_FAILFAST_MASK \
7cc01581 Tejun Heo          2010-08-03  201  	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
7cc01581 Tejun Heo          2010-08-03  202  
e2a60da7 Martin K. Petersen 2012-09-18  203  #define REQ_NOMERGE_FLAGS \
e8064021 Christoph Hellwig  2016-10-20  204  	(REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
e2a60da7 Martin K. Petersen 2012-09-18  205  
ef295ecf Christoph Hellwig  2016-10-28  206  #define bio_op(bio) \
ef295ecf Christoph Hellwig  2016-10-28  207  	((bio)->bi_opf & REQ_OP_MASK)
ef295ecf Christoph Hellwig  2016-10-28  208  #define req_op(req) \
ef295ecf Christoph Hellwig  2016-10-28 @209  	((req)->cmd_flags & REQ_OP_MASK)
7cc01581 Tejun Heo          2010-08-03  210  
ef295ecf Christoph Hellwig  2016-10-28  211  /* obsolete, don't use in new code */
93c5bdf7 Christoph Hellwig  2016-11-21  212  static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
93c5bdf7 Christoph Hellwig  2016-11-21  213  		unsigned op_flags)
93c5bdf7 Christoph Hellwig  2016-11-21  214  {
93c5bdf7 Christoph Hellwig  2016-11-21  215  	bio->bi_opf = op | op_flags;
93c5bdf7 Christoph Hellwig  2016-11-21  216  }
c11f0c0b Jens Axboe         2016-08-05  217  

:::::: The code at line 209 was first introduced by commit
:::::: ef295ecf090d3e86e5b742fc6ab34f1122a43773 block: better op and flags encoding

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@fb.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26596 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/672affda/attachment-0001.gz>
