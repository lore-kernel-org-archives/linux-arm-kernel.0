From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 29 Aug 2012 18:03:18 -0700
Subject: CMA page migration failure due to buffers on bh_lru
Message-ID: <503EBBD6.5080504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been observing a high rate of failures with CMA allocations on my
ARM system. I've set up a test case set up with a 56MB CMA region that
essentially does the following:

	total_failures = 0;
	loop forever:
		loop_failure = 0;
		for (i = 0; i < 56; i++)
			chunk[i] = dma_allocate(&cma_dev, 1MB)
			if (!chunk[i])
				loop_failure = 0

		if (loop_failure)
			total_failures++
			loop_failure = 0

		for (i = 0; i < 56; i++)
			dma_free(&cma_dev, chunk[i], 1MB)

In the background, I also have a process doing some amount of filesystem
activity (adb push/pull since this is an android system). During the 
course of my investigations I generally get ~8500 loops total and ~450 
total failures (i.e. one or more buffers could not be allocated). This 
is unacceptably high for our use cases.

In every case the allocation failure was ultimately due to a migration
failure; the pages contained buffers which could not be dropped because 
the buffers were busy (move_to_new_page -> fallback_migrate_page ->
try_to_release_page -> try_to_free_buffers -> drop_buffers -> 
buffer_busy). In every case, the b_count on the buffer head was always 1.

The problem arises because of the LRU lists for buffer heads:

__getblk
     __getblk_slow
         grow_buffers
             grow_dev_page
                 find_or_create_page -- create a possibly movable page
         __find_get_block
	    __find_get_block_slow
                 find_get_page -- return the movable page
             bh_lru_install
                 get_bh -- buffer head now has a reference

The reference taken in bh_lru_install won't be dropped until the bh is 
evicted from the lru. This means the page cannot be migrated as long as 
the buffer exists on an LRU list. The real issue is that unless the 
buffer gets evicted quickly the page can remain non-migratible for long 
periods of time. This makes CMA regions unusable for long periods of 
time given that we generally don't want to size CMA regions any larger 
than necessary ergo any failure will cause a problem.

My quick and dirty workaround for testing is to remove the GFP_MOVABLE 
flag from find_or_create_page but this seems significantly less than 
optimal. Ideally, it seems like the buffers should be evicted from the 
LRU when trying to drop (expand on invalid_bh_lru?) but I'm not familiar 
enough with the code path to know if this is a good approach.

Any suggestions/feedback is appreciated. Thanks.

Laura
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
