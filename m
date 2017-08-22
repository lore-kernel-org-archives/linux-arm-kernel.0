From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Aug 2017 13:57:47 +0100
Subject: Page fault while link_path_walk for path_len > 4060 bytes
In-Reply-To: <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
References: <08e7e3332dc86c535dd2961ac1cde0b5@codeaurora.org>
 <54083a824d6705a93d972ca5ef3a7b35@codeaurora.org>
 <3958983ccec4aca494bf72c397f34bfa@codeaurora.org>
 <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
Message-ID: <20170822125747.GB28024@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ankit,

On Tue, Aug 22, 2017 at 11:19:43AM +0530, ankijain at codeaurora.org wrote:
> Could you please look into this issue?
> Can we use srcu_read_lock/srcu_read_unlock instead of
> rcu_read_lock/rcu_read_unlock in path_init() ,terminate_Walk() and
> complete_walk() ?
> if we go for srcu_read_lock, then how can we maintain the idx for
> srcu_read_unlock in unlazy_walk().
> 
> Requesting you please comment on this issue.

It would help if you could:

  1. Provide the kernel panic log
  2. Describe the machine on which you're running
  3. Run the repro code on a mainline kernel

Assuming this is an arm64 machine, I'm intrigued as to what is generating
the fault. v4.4 doesn't support DEBUG_PAGEALLOC, so it must be something
else. Do you know what the ESR value is when you take the fault?

Does the diff below help?

Will

--->8

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2509e4fe6992..aa6c4a9e1113 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -611,7 +611,7 @@ static const struct fault_info fault_info[] = {
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 0 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
-	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 8"			},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},


> On 2017-08-14 16:44, ankijain at codeaurora.org wrote:
> >Hi linux-fsdevel
> >
> >could you please look at this issue or suggest how we can proceed further.
> >
> >Thanks,
> >
> >On 2017-08-07 17:48, ankijain at codeaurora.org wrote:
> >>On 2017-08-07 11:52, ankijain at codeaurora.org wrote:
> >>>Hi
> >>>
> >>>We are facing a issue while creating the directories up-to maximum
> >>>depth.
> >>>While doing this, page fault occurs some times if PATH_LEN is near to
> >>>page boundary.
> >>>During hash_name() calculation inside link_path_walk(),
> >>>load_unaligned_zeropad() is causing page fault as it tries to access
> >>>next page data(which is not mapped).
> >>>We have already taken a lock(rcu_read_lock) in path_init() and as a
> >>>part of page fault it checks if process can sleep (might_sleep), which
> >>>results in panic as rcu_read_lock is already taken in path_init().
> >>>
> >>>One observation : Panic happens only when page(which contain the
> >>>path_name and length > 4060) is the last page of the slab memory.
> >>>
> >>>Test Case detail:
> >>>Kernel version : 4.4
> >>>We are following stress-ng test.
> >>>https://github.com/ColinIanKing/stress-ng
> >>>
> >>>1. dirdeep for creating directory upto maximum depth.
> >>>2. vm for memory allocation in backgroud.
> >>>
> >>>Above 2 test cases are running simultaneously and it takes ~3-4 hours
> >>>to reproduce this issue.
> >>>
> >>>Pasting comment section for load_unaligned_zeropad():
> >>>/*
> >>>  * Load an unaligned word from kernel space.
> >>>  *
> >>>  * In the (very unlikely) case of the word being a page-crosser
> >>>  * and the next page not being mapped, take the exception and
> >>>  * return zeroes in the non-existing part.
> >>>  */
> >>>
> >>>Wanted to confirm if this "very unlikely case" mentioned above is
> >>>pointing to the same issue ?
> >>>Also let us know if this is a known issue and if some fix is already
> >>>available. If not, please suggest how we can proceed further.
> >>>
> >>>Appreciate your help. Thanks in advance!!
> >>>
> >>>Regards,
> >>>Ankit Jain
> >>>Qualcomm India Private Limited, on behalf of Qualcomm Innovation
> >>>Center, Inc.
> >>>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> >>>Linux Foundation Collaborative Project
