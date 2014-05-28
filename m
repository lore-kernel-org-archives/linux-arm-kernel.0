From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 28 May 2014 08:55:39 -0700
Subject: [PATCH v5 2/2] arm64: enable context tracking
In-Reply-To: <20140528114438.GF15222@arm.com> (Will Deacon's message of "Wed,
 28 May 2014 12:44:38 +0100")
References: <1401130573-7443-1-git-send-email-larry.bassel@linaro.org>
 <1401130573-7443-3-git-send-email-larry.bassel@linaro.org>
 <20140528114438.GF15222@arm.com>
Message-ID: <7hegzd99tw.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Will Deacon <will.deacon@arm.com> writes:

> On Mon, May 26, 2014 at 07:56:13PM +0100, Larry Bassel wrote:
>> Make calls to ct_user_enter when the kernel is exited
>> and ct_user_exit when the kernel is entered (in el0_da,
>> el0_ia, el0_svc, el0_irq and all of the "error" paths).
>> 
>> These macros expand to function calls which will only work
>> properly if el0_sync and related code has been rearranged
>> (in a previous patch of this series).
>> 
>> The calls to ct_user_exit are made after hw debugging has been
>> enabled (enable_dbg_and_irq).
>> 
>> The call to ct_user_enter is made at the beginning of the
>> kernel_exit macro.
>> 
>> This patch is based on earlier work by Kevin Hilman.
>> Save/restore optimizations were also done by Kevin.
>
> Apologies if we've discussed this before (it rings a bell), but why are we
> penalising the fast syscall path with this? Shouldn't TIF_NOHZ contribute to
> out _TIF_WORK_MASK, then we could do the tracking on the syscall slow path?

I'll answer here since Larry inherited this design decision from me.

I considered (and even implemented) forcing the slow syscall path
based on TIF_NOHZ but decided (perhaps wrongly) not to.  I guess the
choice is between:

- forcing the overhead of syscall tracing path on all
  TIF_NOHZ processes

- forcing the (much smaller) ct_user_exit overhead on all syscalls,
  (including the fast syscall path)

I had decided that the former was better, but as I write this, I'm
thinking that the NOHZ tasks should probably eat the extra overhead
since we expect their interactions with the kernel to be minimal anyways
(part of the goal of full NOHZ.)

Ultimately, I'm OK with either way and have the other version ready.

> I think that would tidy up your mov into x19 too.

That's correct.  If we force the syscall_trace path, the ct_user_enter
wouldn't have to do any context save/restore.

> Also -- how do you track ret_from_fork in the child with these patches?

Not sure I follow the question, but ret_from_fork calls
ret_to_user, which calls kernel_exit, which calls ct_user_enter.

Kevin
