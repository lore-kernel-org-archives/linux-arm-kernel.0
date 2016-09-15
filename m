From: jason.wessel@windriver.com (Jason Wessel)
Date: Thu, 15 Sep 2016 08:04:57 -0500
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <0ea7dfad-e25d-2919-2d03-17b850d7ba91@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2015 08:13 PM, AKASHI Takahiro wrote:
> Jason,
>
> Could you please review my patch below?
> See also arm64 maintainer's comment:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313712.html
>
> Thanks,
> -Takahiro AKASHI
>
> I tried to verify kgdb in vanilla kernel on fast model, but it seems that
> the single stepping with kgdb doesn't work correctly since its first
> appearance at v3.15.
>
> On v3.15, 'stepi' command after breaking the kernel at some breakpoint
> steps forward to the next instruction, but the succeeding 'stepi' never
> goes beyond that.
> On v3.16, 'stepi' moves forward and stops at the next instruction just
> after enable_dbg in el1_dbg, and never goes beyond that. This variance of
> behavior seems to come in with the following patch in v3.16:
>
>     commit 2a2830703a23 ("arm64: debug: avoid accessing mdscr_el1 on fault
>     paths where possible")
>
> This patch
> (1) moves kgdb_disable_single_step() from 'c' command handling to single
>     step handler.
>     This makes sure that single stepping gets effective at every 's' command.
>     Please note that, under the current implementation, single step bit in
>     spsr, which is cleared by the first single stepping, will not be set
>     again for the consecutive 's' commands because single step bit in mdscr
>     is still kept on (that is, kernel_active_single_step() in
>     kgdb_arch_handle_exception() is true).
> (2) re-implements kgdb_roundup_cpus() because the current implementation
>     enabled interrupts naively. See below.
> (3) removes 'enable_dbg' in el1_dbg.
>     Single step bit in mdscr is turned on in do_handle_exception()->
>     kgdb_handle_expection() before returning to debugged context, and if
>     debug exception is enabled in el1_dbg, we will see unexpected single-
>     stepping in el1_dbg.
>     Since v3.18, the following patch does the same:
>       commit 1059c6bf8534 ("arm64: debug: don't re-enable debug exceptions
>       on return from el1_dbg)
> (4) masks interrupts while single-stepping one instruction.
>     If an interrupt is caught during processing a single-stepping, debug
>     exception is unintentionally enabled by el1_irq's 'enable_dbg' before
>     returning to debugged context.
>     Thus, like in (2), we will see unexpected single-stepping in el1_irq.
>
> Basically (1) and (2) are for v3.15, (3) and (4) for v3.1[67].
>
> @@ -176,18 +183,14 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>  		 * over and over again.
>  		 */
>  		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
> -		atomic_set(&kgdb_cpu_doing_single_step, -1);
> -		kgdb_single_step =  0;


This is a subtle change, but I assume it is what you intended?  All the CPUs will get released into the run state when exiting the kgdb exception handler.


> -
> -		/*
> -		 * Received continue command, disable single step
> -		 */
> -		if (kernel_active_single_step())
> -			kernel_disable_single_step();
>


I see why this is not needed above any more given that you have a function that cleans up the state on entry to the kgdb exception handler.

The rest of the patch is fine.

I added the patch to kgdb-next after fixing up the context since it no longer applied to the mainline ( https://git.kernel.org/cgit/linux/kernel/git/jwessel/kgdb.git/log/?h=kgdb-next).  If there is further discussion on the point above, another patch can be added, but it I am assuming this is the way you desire it to work as there are some other architectures that use the same behaviour.  I do not presently have any ARM64 hardware to validate this particular change.

I also added to the patch a "Cc: linux-stable <stable@vger.kernel.org>" so we can have this appear on some of the older kernels.


Thanks,
Jason.
