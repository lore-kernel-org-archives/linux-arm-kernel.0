From: kimran@codeaurora.org (Imran Khan)
Date: Fri, 24 Feb 2017 19:11:55 +0530
Subject: Perf degradation seen with thread_info stored in sp_el0
Message-ID: <72e51627-9155-96f2-f7a9-1be8a8198930@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am observing some degradation in context switch performance (reported by sched benchmark of perf), after including the change
to keep thread_info in sp_el0:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6cdf9c7ca687e01840d0215437620a20263012fc

However, if I use D0 to store the same information, I see that performance improves. 

For example, I am getting following numbers for the above mentioned scenarios:

Thread info obtained from stack:

        /data/local # ./perf bench sched messaging -g 5 -l 500
        # Running 'sched/messaging' benchmark:
        # 20 sender and receiver processes per group
        # 5 groups == 200 processes run

        Total time: 2.911 [sec]


Thread info obtained from sp_el0:

        /data/local # ./perf bench sched messaging -g 5 -l 500
        # Running 'sched/messaging' benchmark:
        # 20 sender and receiver processes per group
        # 5 groups == 200 processes run

        Total time: 3.590 [sec]


Thread info obtained from D0: 

        /data/local # ./perf bench sched messaging -g 5 -l 500
        # Running 'sched/messaging' benchmark:
        # 20 sender and receiver processes per group
        # 5 groups == 200 processes run

        Total time: 3.103 [sec]


So keeping thread_info in sp_el0 is resulting in degradation of around 23% , while keeping the same in D0 is 
resulting in degradation of about 6-7%. Of course so far my test cases are not involving cases where D0 might
get changed in kernel space itself e.g. snippets under kernel_neon_begin/end and taking care of those cases
will have further overhead.

But right now I just wanted to have a feedback regarding, what are the possible complications I may face if 
I try to keep thread_info in D0 and whether such a solution will be feasible or not.
Moreover is there any other alternative way to get rid of this performance degradation.

Thanks and Regards,
Imran


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
