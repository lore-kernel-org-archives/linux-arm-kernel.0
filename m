From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 13 Feb 2017 21:36:15 +0800
Subject: [stericsson:mmc-no-NULL 34/34] include/linux/blk-mq.h:118:2: error:
 unknown type name 'softirq_done_fn'
Message-ID: <201702132112.r1z5EPIm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   c8140f7069d2f17882ea16e78265b7e31c4b5e45
commit: c8140f7069d2f17882ea16e78265b7e31c4b5e45 [34/34] RFC: mmc: switch MMC/SD to use blk-mq multiqueueing v3
config: x86_64-randconfig-x017-201707 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c8140f7069d2f17882ea16e78265b7e31c4b5e45
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from drivers/mmc/core/queue.h:7:0,
                    from drivers/mmc/core/core.c:42:
>> include/linux/blk-mq.h:118:2: error: unknown type name 'softirq_done_fn'
     softirq_done_fn  *complete;
     ^~~~~~~~~~~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
>> include/linux/blk-mq.h:254:22: error: invalid application of 'sizeof' to incomplete type 'struct request'
     return pdu - sizeof(struct request);
                         ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
>> include/linux/blk-mq.h:258:2: error: invalid use of undefined type 'struct request'
     return rq + 1;
     ^~~~~~
   In file included from include/linux/writeback.h:12:0,
                    from include/linux/memcontrol.h:30,
                    from include/linux/swap.h:8,
                    from include/linux/suspend.h:4,
                    from drivers/mmc/core/core.c:27:
   drivers/mmc/core/queue.h: In function 'mmc_req_is_special':
   include/linux/blk_types.h:209:8: error: dereferencing pointer to incomplete type 'struct request'
     ((req)->cmd_flags & REQ_OP_MASK)
           ^
   drivers/mmc/core/queue.h:14:4: note: in expansion of macro 'req_op'
      (req_op(req) == REQ_OP_FLUSH ||
       ^~~~~~

vim +/softirq_done_fn +118 include/linux/blk-mq.h

320ae51f Jens Axboe        2013-10-24  112  
05229bee Jens Axboe        2015-11-05  113  	/*
05229bee Jens Axboe        2015-11-05  114  	 * Called to poll for completion of a specific tag.
05229bee Jens Axboe        2015-11-05  115  	 */
05229bee Jens Axboe        2015-11-05  116  	poll_fn			*poll;
05229bee Jens Axboe        2015-11-05  117  
30a91cb4 Christoph Hellwig 2014-02-10 @118  	softirq_done_fn		*complete;
30a91cb4 Christoph Hellwig 2014-02-10  119  
320ae51f Jens Axboe        2013-10-24  120  	/*
320ae51f Jens Axboe        2013-10-24  121  	 * Called when the block layer side of a hardware queue has been
320ae51f Jens Axboe        2013-10-24  122  	 * set up, allowing the driver to allocate/init matching structures.
320ae51f Jens Axboe        2013-10-24  123  	 * Ditto for exit/teardown.
320ae51f Jens Axboe        2013-10-24  124  	 */
320ae51f Jens Axboe        2013-10-24  125  	init_hctx_fn		*init_hctx;
320ae51f Jens Axboe        2013-10-24  126  	exit_hctx_fn		*exit_hctx;
e9b267d9 Christoph Hellwig 2014-04-15  127  
e9b267d9 Christoph Hellwig 2014-04-15  128  	/*
e9b267d9 Christoph Hellwig 2014-04-15  129  	 * Called for every command allocated by the block layer to allow
e9b267d9 Christoph Hellwig 2014-04-15  130  	 * the driver to set up driver specific data.
f70ced09 Ming Lei          2014-09-25  131  	 *
f70ced09 Ming Lei          2014-09-25  132  	 * Tag greater than or equal to queue_depth is for setting up
f70ced09 Ming Lei          2014-09-25  133  	 * flush request.
f70ced09 Ming Lei          2014-09-25  134  	 *
e9b267d9 Christoph Hellwig 2014-04-15  135  	 * Ditto for exit/teardown.
e9b267d9 Christoph Hellwig 2014-04-15  136  	 */
e9b267d9 Christoph Hellwig 2014-04-15  137  	init_request_fn		*init_request;
e9b267d9 Christoph Hellwig 2014-04-15  138  	exit_request_fn		*exit_request;
486cf989 Sagi Grimberg     2016-07-06  139  	reinit_request_fn	*reinit_request;
da695ba2 Christoph Hellwig 2016-09-14  140  
da695ba2 Christoph Hellwig 2016-09-14  141  	map_queues_fn		*map_queues;
320ae51f Jens Axboe        2013-10-24  142  };
320ae51f Jens Axboe        2013-10-24  143  
320ae51f Jens Axboe        2013-10-24  144  enum {
320ae51f Jens Axboe        2013-10-24  145  	BLK_MQ_RQ_QUEUE_OK	= 0,	/* queued fine */
320ae51f Jens Axboe        2013-10-24  146  	BLK_MQ_RQ_QUEUE_BUSY	= 1,	/* requeue IO for later */
320ae51f Jens Axboe        2013-10-24  147  	BLK_MQ_RQ_QUEUE_ERROR	= 2,	/* end IO with error */
320ae51f Jens Axboe        2013-10-24  148  
320ae51f Jens Axboe        2013-10-24  149  	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
8a58d1f1 Jens Axboe        2014-08-15  150  	BLK_MQ_F_TAG_SHARED	= 1 << 1,
8a58d1f1 Jens Axboe        2014-08-15  151  	BLK_MQ_F_SG_MERGE	= 1 << 2,
e167dfb5 Jens Axboe        2014-10-29  152  	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
1b792f2f Jens Axboe        2016-09-21  153  	BLK_MQ_F_BLOCKING	= 1 << 5,
24391c0d Shaohua Li        2015-01-23  154  	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
24391c0d Shaohua Li        2015-01-23  155  	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
320ae51f Jens Axboe        2013-10-24  156  
5d12f905 Jens Axboe        2014-03-19  157  	BLK_MQ_S_STOPPED	= 0,
0d2602ca Jens Axboe        2014-05-13  158  	BLK_MQ_S_TAG_ACTIVE	= 1,
320ae51f Jens Axboe        2013-10-24  159  
a4391c64 Jens Axboe        2014-06-05  160  	BLK_MQ_MAX_DEPTH	= 10240,
506e931f Jens Axboe        2014-05-07  161  
506e931f Jens Axboe        2014-05-07  162  	BLK_MQ_CPU_WORK_BATCH	= 8,
320ae51f Jens Axboe        2013-10-24  163  };
24391c0d Shaohua Li        2015-01-23  164  #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
24391c0d Shaohua Li        2015-01-23  165  	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
24391c0d Shaohua Li        2015-01-23  166  		((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1))
24391c0d Shaohua Li        2015-01-23  167  #define BLK_ALLOC_POLICY_TO_MQ_FLAG(policy) \
24391c0d Shaohua Li        2015-01-23  168  	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
24391c0d Shaohua Li        2015-01-23  169  		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
320ae51f Jens Axboe        2013-10-24  170  
24d2f903 Christoph Hellwig 2014-04-15  171  struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
b62c21b7 Mike Snitzer      2015-03-12  172  struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
b62c21b7 Mike Snitzer      2015-03-12  173  						  struct request_queue *q);
b21d5b30 Matias Bj?rling   2016-09-16  174  int blk_mq_register_dev(struct device *, struct request_queue *);
b21d5b30 Matias Bj?rling   2016-09-16  175  void blk_mq_unregister_dev(struct device *, struct request_queue *);
320ae51f Jens Axboe        2013-10-24  176  
24d2f903 Christoph Hellwig 2014-04-15  177  int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
24d2f903 Christoph Hellwig 2014-04-15  178  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
24d2f903 Christoph Hellwig 2014-04-15  179  
320ae51f Jens Axboe        2013-10-24  180  void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
320ae51f Jens Axboe        2013-10-24  181  
feb71dae Christoph Hellwig 2014-02-20  182  void blk_mq_insert_request(struct request *, bool, bool, bool);
320ae51f Jens Axboe        2013-10-24  183  void blk_mq_free_request(struct request *rq);
7c7f2f2b Jens Axboe        2014-11-17  184  void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *, struct request *rq);
320ae51f Jens Axboe        2013-10-24  185  bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
6f3b0e8b Christoph Hellwig 2015-11-26  186  
6f3b0e8b Christoph Hellwig 2015-11-26  187  enum {
6f3b0e8b Christoph Hellwig 2015-11-26  188  	BLK_MQ_REQ_NOWAIT	= (1 << 0), /* return when out of requests */
6f3b0e8b Christoph Hellwig 2015-11-26  189  	BLK_MQ_REQ_RESERVED	= (1 << 1), /* allocate from reserved pool */
6f3b0e8b Christoph Hellwig 2015-11-26  190  };
6f3b0e8b Christoph Hellwig 2015-11-26  191  
4ce01dd1 Christoph Hellwig 2014-05-27  192  struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
6f3b0e8b Christoph Hellwig 2015-11-26  193  		unsigned int flags);
1f5bd336 Ming Lin          2016-06-13  194  struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int op,
1f5bd336 Ming Lin          2016-06-13  195  		unsigned int flags, unsigned int hctx_idx);
0e62f51f Jens Axboe        2014-06-04  196  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
320ae51f Jens Axboe        2013-10-24  197  
205fb5f5 Bart Van Assche   2014-10-30  198  enum {
205fb5f5 Bart Van Assche   2014-10-30  199  	BLK_MQ_UNIQUE_TAG_BITS = 16,
205fb5f5 Bart Van Assche   2014-10-30  200  	BLK_MQ_UNIQUE_TAG_MASK = (1 << BLK_MQ_UNIQUE_TAG_BITS) - 1,
205fb5f5 Bart Van Assche   2014-10-30  201  };
205fb5f5 Bart Van Assche   2014-10-30  202  
205fb5f5 Bart Van Assche   2014-10-30  203  u32 blk_mq_unique_tag(struct request *rq);
205fb5f5 Bart Van Assche   2014-10-30  204  
205fb5f5 Bart Van Assche   2014-10-30  205  static inline u16 blk_mq_unique_tag_to_hwq(u32 unique_tag)
205fb5f5 Bart Van Assche   2014-10-30  206  {
205fb5f5 Bart Van Assche   2014-10-30  207  	return unique_tag >> BLK_MQ_UNIQUE_TAG_BITS;
205fb5f5 Bart Van Assche   2014-10-30  208  }
205fb5f5 Bart Van Assche   2014-10-30  209  
205fb5f5 Bart Van Assche   2014-10-30  210  static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
205fb5f5 Bart Van Assche   2014-10-30  211  {
205fb5f5 Bart Van Assche   2014-10-30  212  	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
205fb5f5 Bart Van Assche   2014-10-30  213  }
205fb5f5 Bart Van Assche   2014-10-30  214  
320ae51f Jens Axboe        2013-10-24  215  
973c0191 Keith Busch       2015-01-07  216  int blk_mq_request_started(struct request *rq);
e2490073 Christoph Hellwig 2014-09-13  217  void blk_mq_start_request(struct request *rq);
c8a446ad Christoph Hellwig 2014-09-13  218  void blk_mq_end_request(struct request *rq, int error);
c8a446ad Christoph Hellwig 2014-09-13  219  void __blk_mq_end_request(struct request *rq, int error);
320ae51f Jens Axboe        2013-10-24  220  
2b053aca Bart Van Assche   2016-10-28  221  void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
2b053aca Bart Van Assche   2016-10-28  222  void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
2b053aca Bart Van Assche   2016-10-28  223  				bool kick_requeue_list);
6fca6a61 Christoph Hellwig 2014-05-28  224  void blk_mq_kick_requeue_list(struct request_queue *q);
2849450a Mike Snitzer      2016-09-14  225  void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
1885b24d Jens Axboe        2015-01-07  226  void blk_mq_abort_requeue_list(struct request_queue *q);
f4829a9b Christoph Hellwig 2015-09-27  227  void blk_mq_complete_request(struct request *rq, int error);
30a91cb4 Christoph Hellwig 2014-02-10  228  
fd001443 Bart Van Assche   2016-10-28  229  bool blk_mq_queue_stopped(struct request_queue *q);
320ae51f Jens Axboe        2013-10-24  230  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
320ae51f Jens Axboe        2013-10-24  231  void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
280d45f6 Christoph Hellwig 2013-10-25  232  void blk_mq_stop_hw_queues(struct request_queue *q);
2f268556 Christoph Hellwig 2014-04-16  233  void blk_mq_start_hw_queues(struct request_queue *q);
ae911c5e Jens Axboe        2016-12-08  234  void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
1b4a3258 Christoph Hellwig 2014-04-16  235  void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
b94ec296 Mike Snitzer      2015-03-11  236  void blk_mq_run_hw_queues(struct request_queue *q, bool async);
70f4db63 Christoph Hellwig 2014-04-16  237  void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
e0489487 Sagi Grimberg     2016-03-10  238  void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
e0489487 Sagi Grimberg     2016-03-10  239  		busy_tag_iter_fn *fn, void *priv);
c761d96b Jens Axboe        2015-01-02  240  void blk_mq_freeze_queue(struct request_queue *q);
b4c6a028 Keith Busch       2014-12-19  241  void blk_mq_unfreeze_queue(struct request_queue *q);
b4c6a028 Keith Busch       2014-12-19  242  void blk_mq_freeze_queue_start(struct request_queue *q);
486cf989 Sagi Grimberg     2016-07-06  243  int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
320ae51f Jens Axboe        2013-10-24  244  
9e5a7e22 Christoph Hellwig 2016-11-01  245  int blk_mq_map_queues(struct blk_mq_tag_set *set);
868f2f0b Keith Busch       2015-12-17  246  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
868f2f0b Keith Busch       2015-12-17  247  
320ae51f Jens Axboe        2013-10-24  248  /*
320ae51f Jens Axboe        2013-10-24  249   * Driver command data is immediately after the request. So subtract request
2963e3f7 Jens Axboe        2015-04-09  250   * size to get back to the original request, add request size to get the PDU.
320ae51f Jens Axboe        2013-10-24  251   */
320ae51f Jens Axboe        2013-10-24  252  static inline struct request *blk_mq_rq_from_pdu(void *pdu)
320ae51f Jens Axboe        2013-10-24  253  {
320ae51f Jens Axboe        2013-10-24 @254  	return pdu - sizeof(struct request);
320ae51f Jens Axboe        2013-10-24  255  }
320ae51f Jens Axboe        2013-10-24  256  static inline void *blk_mq_rq_to_pdu(struct request *rq)
320ae51f Jens Axboe        2013-10-24  257  {
2963e3f7 Jens Axboe        2015-04-09 @258  	return rq + 1;
320ae51f Jens Axboe        2013-10-24  259  }
320ae51f Jens Axboe        2013-10-24  260  
320ae51f Jens Axboe        2013-10-24  261  #define queue_for_each_hw_ctx(q, hctx, i)				\

:::::: The code at line 118 was first introduced by commit
:::::: 30a91cb4ef385fe1b260df204ef314d86fff2850 blk-mq: rework I/O completions

:::::: TO: Christoph Hellwig <hch@infradead.org>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/adbfeac1/attachment-0001.gz>
