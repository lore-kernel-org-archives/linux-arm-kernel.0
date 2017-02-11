From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 11 Feb 2017 15:02:10 +0800
Subject: [stericsson:mmc-no-NULL 32/34] include/linux/blk_types.h:209:8:
 error: dereferencing pointer to incomplete type
Message-ID: <201702111508.xxkgeshc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   1bec9a625b256f78d00c38b58caad7ccdae8aaf5
commit: 8b8bcac0e2f2356064488868b08c7d4fe8ef1f44 [32/34] mmc: queue: get/put struct mmc_queue_req
config: i386-randconfig-c0-02111403 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 8b8bcac0e2f2356064488868b08c7d4fe8ef1f44
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/mmc/core/core.c:42:0:
   drivers/mmc/core/queue.h:10:46: warning: 'struct request' declared inside parameter list
    static inline bool mmc_req_is_special(struct request *req)
                                                 ^
   drivers/mmc/core/queue.h:10:46: warning: its scope is only this definition or declaration, which is probably not what you want
   In file included from include/linux/writeback.h:12:0,
                    from include/linux/memcontrol.h:30,
                    from include/linux/swap.h:8,
                    from include/linux/suspend.h:4,
                    from drivers/mmc/core/core.c:27:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
>> include/linux/blk_types.h:209:8: error: dereferencing pointer to incomplete type
     ((req)->cmd_flags & REQ_OP_MASK)
           ^
   drivers/mmc/core/queue.h:13:4: note: in expansion of macro 'req_op'
      (req_op(req) == REQ_OP_FLUSH ||
       ^
>> include/linux/blk_types.h:209:8: error: dereferencing pointer to incomplete type
     ((req)->cmd_flags & REQ_OP_MASK)
           ^
   drivers/mmc/core/queue.h:14:4: note: in expansion of macro 'req_op'
       req_op(req) == REQ_OP_DISCARD ||
       ^
>> include/linux/blk_types.h:209:8: error: dereferencing pointer to incomplete type
     ((req)->cmd_flags & REQ_OP_MASK)
           ^
   drivers/mmc/core/queue.h:15:4: note: in expansion of macro 'req_op'
       req_op(req) == REQ_OP_SECURE_ERASE);
       ^

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
Size: 28244 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170211/474717b0/attachment-0001.gz>
