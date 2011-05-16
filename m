From: saeed@marvell.com (Saeed Bishara)
Date: Mon, 16 May 2011 15:13:33 +0300
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <1305547130.19230.42.camel@e102109-lin.cambridge.arm.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
	<BANLkTikUphZ4azqK50YBZa4uTyU4EystLA@mail.gmail.com>
	<BANLkTikWJzdYOrk4=gte8zOHDVioGAOhhg@mail.gmail.com>
	<BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
	<BANLkTi=cf47Axm1rXEa-gX7oK0h2aGq0nA@mail.gmail.com>
	<1305547130.19230.42.camel@e102109-lin.cambridge.arm.com>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009F01162C92016E@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>> BTW, there is something concerns me about ARM11MP core, this system
>> doesn't support cache maintenance broadcasting, but when looking at
>> do_cache_op(), it doesn't seem to flush the cache of other 
>cpus, so if
>> we have a multithreaded applications like java that uses self
>> modifying code, how can you make sure that all cpus will have their I
>> cache flushed when one cpu requests to do do_cache_op?
>
>We don't :). If you are unlucky enough, your thread may migrate to
>another CPU between the moment it wrote the data and the do_cache_op()
>call so you'll miss the D-cache flushing.
>
>I had a simple fix for a while, see below (I posted it in the past in a
>slightly different form, maybe I should post it again).
Well, this patch seems to handle the case were the thread migrated to another CPU.
But what about this case:
1. Thread 0 runs on CPU0
2. Thread 1 runs on CPU1 and run a code from A.
3. Thread 0 modifies the code at A
4. Thread 0 calls do_cache_op()
5. Thread 1 tries to run new code from A.
I'm assuming that thread 1 continued to run on CPU1 and no context switch occurred on that CPU.


saeed
