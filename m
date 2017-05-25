From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 May 2017 17:29:38 +0100
Subject: [PATCH v2 2/2] arm64: Add support for CLOCK_MONOTONIC_RAW in
 clock_gettime() vDSO
In-Reply-To: <CAE2F3rCCJG5+cjTgWmHFN7zeJNhudKWyj5owg1aQnWWhMN3oKQ@mail.gmail.com>
References: <CAE2F3rCCJG5+cjTgWmHFN7zeJNhudKWyj5owg1aQnWWhMN3oKQ@mail.gmail.com>
Message-ID: <20170525162938.GT2859@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[adding John, as I know he's working on patches for this]

On Mon, May 22, 2017 at 04:56:34PM -0700, Daniel Mentz wrote:
> One of the tests in the kselftest suite fails for me on a HiKey board
> (ARM Cortex-A53), and I believe that this change could be related to
> it. The specific test that fails is
> tools/testing/selftests/timers/inconsistency-check.c

Have you got any hints on reproducing this? I've failed to reproduce it
so far on any of my machines running 4.12-rc2.

Which version of the HiKey are you using? The latest one is big.LITTLE
with an A73, which has an unfortunate erratum that ends up disabling the
vDSO.

Will


> Here is a snippet of the test output:
> 
> 285:363928252
> 285:363928252
> 285:363928252
> 285:363928252
> --------------------
> 285:363974918
> 285:363974917
> --------------------
> 285:363974917
> 285:363974917
> 285:363974917
> 285:363974917
> 285:363974917
> 285:363974917
> 285:363974917
> 285:363975751
> 285:363975751
> 285:363975751
> 285:363975751
> 285:363975751
> 285:363975751
> 
> As you can see between the two lines "--------------",
> CLOCK_MONOTONIC_RAW went backwards by one nanosecond.
> 
> From what I understand, the vDSO serves the
> clock_gettime(CLOCK_MONOTONIC_RAW) request as follows: The vDSO has
> copies of tk->tkr_mono.cycle_last, tk->raw_time.tv_nsec,
> tk->tkr_raw.mult and tk->tkr_mono.shift. When the user calls
> clock_gettime(), the vDSO reads the Virtual Timer Count register,
> calculates the difference between cycle_last and then converts the
> difference to nanoseconds. The conversation is done by multiplying
> with tk->tkr_raw.mult followed by a right shift operation by
> tk->tkr_mono.shift bits. The last step is to add the result to
> tk->raw_time.tv_nsec.
> 
> The problem with this approach is that the kernel uses a slightly
> different approach when updating tk->raw_time.tv_nsec: Every time the
> timer count registers advances by tk->cycle_interval, it adds
> tk->raw_interval to tk->raw_time.tv_nsec (see
> logarithmic_accumulation()). Both of these values are pre-calculated
> in tk_setup_internals().
> 
> tk->raw_interval is calculated as follows:
> 
> tk->raw_interval =
> ((u64) interval * clock->mult) >> clock->shift;
> 
> A rounding error is introduced by this last right shift operation. As
> a result, this same rounding error is added to tk->raw_time.tv_nsec
> with every update in logarithmic_accumulation(). Hence, the kernel
> adds (or subtracts) a certain rounding error every cycle_interval.
> 
> The issue is that the vDSO code does not add this very same rounding
> error in the same fashion. Instead, the vDSO code just uses
> clock->mult and clock->shift to convert the counter value difference
> into nanoseconds and then add it to tk->raw_time.tv_nsec. It would not
> introduce this rounding error after every cycle interval. As a result,
> the vDSO and the kernel diverge in a way such that the clock might
> appear to be moving backwards by 1ns after the kernel updates
> tk->raw_time.tv_nsec.
> 
> How should we solve this issue? I suggest exporting tk->cycle_interval
> to the vDSO and falling back to the syscall if the Virtual Timer Count
> register advanced by more than cycle_interval.
> 
> Daniel
