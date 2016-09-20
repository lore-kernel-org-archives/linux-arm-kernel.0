From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Sep 2016 17:43:14 +0900
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <bb9cf2c6-83b4-1c71-d497-67f751de9b35@windriver.com>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
 <0ea7dfad-e25d-2919-2d03-17b850d7ba91@windriver.com>
 <20160916043218.GA30248@linaro.org>
 <bb9cf2c6-83b4-1c71-d497-67f751de9b35@windriver.com>
Message-ID: <20160920084312.GF30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Mon, Sep 19, 2016 at 05:29:36PM -0500, Jason Wessel wrote:
> On 09/15/2016 11:32 PM, AKASHI Takahiro wrote:
> >@@ -176,18 +183,14 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
> >>>		 * over and over again.
> >>>		 */
> >>>		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
> >>>-		atomic_set(&kgdb_cpu_doing_single_step, -1);
> >>>-		kgdb_single_step =  0;
> >>
> >>This is a subtle change, but I assume it is what you intended?  All the CPUs will get released into the run state when exiting the kgdb exception handler.
> >You are talking about "- kgdb_single_step = 0." Right?
> 
> 
> Correct.
> 
> >Do you think that there is any (negative) side effect of this change?
> 
> 
> Not at all.   The kernel debugger always skids to a stop, and it is more reliable from a locking perspective if the other CPU threads are released while a single CPU is asked to single step until the next "skid" for all the other CPUs.
> 
> When you do not release the other CPUs you can end up single stepping a CPU which dead locks or never exits a lock elsewhere due to what ever it was blocking on never getting freed from another CPU.

Thank you for the explanation. This convinces me very much.

-Takahiro AKASHI

> Cheers,
> Jason.
