From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 Aug 2014 15:47:51 +0800
Subject: [PATCH v7 1/8] arm64: kernel: refactor the CPU suspend API for
 retention states
In-Reply-To: <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <53F1AFA7.5040003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-13 23:52, Lorenzo Pieralisi wrote:
> CPU suspend is the standard kernel interface to be used to enter
> low-power states on ARM64 systems. Current cpu_suspend implementation
> by default assumes that all low power states are losing the CPU context,
> so the CPU registers must be saved and cleaned to DRAM upon state
> entry. Furthermore, the current cpu_suspend() implementation assumes
> that if the CPU suspend back-end method returns when called, this has
> to be considered an error regardless of the return code (which can be
> successful) since the CPU was not expected to return from a code path that
> is different from cpu_resume code path - eg returning from the reset vector.
> 
> All in all this means that the current API does not cope well with low-power
> states that preserve the CPU context when entered (ie retention states),
> since first of all the context is saved for nothing on state entry for
> those states and a successful state entry can return as a normal function
> return, which is considered an error by the current CPU suspend
> implementation.
> 
> This patch refactors the cpu_suspend() API so that it can be split in
> two separate functionalities. The arm64 cpu_suspend API just provides
> a wrapper around CPU suspend operation hook. A new function is
> introduced (for architecture code use only) for states that require
> context saving upon entry:
> 
> __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> 
> __cpu_suspend() saves the context on function entry and calls the
> so called suspend finisher (ie fn) to complete the suspend operation.
> The finisher is not expected to return, unless it fails in which case
> the error is propagated back to the __cpu_suspend caller.
> 
> The API refactoring results in the following pseudo code call sequence for a
> suspending CPU, when triggered from a kernel subsystem:
> 
> /*
>  * int cpu_suspend(unsigned long idx)
>  * @idx: idle state index
>  */
> {
> -> cpu_suspend(idx)
> 	|---> CPU operations suspend hook called, if present
> 		|--> if (retention_state)
> 			|--> direct suspend back-end call (eg PSCI suspend)
> 		     else
> 			|--> __cpu_suspend(idx, &back_end_finisher);
> }
> 
> By refactoring the cpu_suspend API this way, the CPU operations back-end
> has a chance to detect whether idle states require state saving or not
> and can call the required suspend operations accordingly either through
> simple function call or indirectly through __cpu_suspend() which carries out
> state saving and suspend finisher dispatching to complete idle state entry.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This patch is pretty fine to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
