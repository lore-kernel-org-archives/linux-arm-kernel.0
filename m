From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Jan 2017 15:40:08 +0000
Subject: [PATCH] arm64: avoid returning from bad_mode
In-Reply-To: <1484760221-30205-1-git-send-email-mark.rutland@arm.com>
References: <1484760221-30205-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170119154008.GC21809@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 05:23:41PM +0000, Mark Rutland wrote:
> Generally, taking an unexpected exception should be a fatal event, and
> bad_mode is intended to cater for this. However, it should be possible
> to contain unexpected synchronous exceptions from EL0 without bringing
> the kernel down, by sending a SIGILL to the task.
> 
> We tried to apply this approach in commit 9955ac47f4ba1c95 ("arm64:
> don't kill the kernel on a bad esr from el0"), by sending a signal for
> any bad_mode call resulting from an EL0 exception.
> 
> However, this also applies to other unexpected exceptions, such as
> SError and FIQ. The entry paths for these exceptions branch to bad_mode
> without configuring the link register, and have no kernel_exit. Thus, if
> we take one of these exceptions from EL0, bad_mode will eventually
> return to the original user link register value.
> 
> This patch fixes this by introducing a new bad_el0_sync handler to cater
> for the recoverable case, and restoring bad_mode to its original state,
> whereby it calls panic() and never returns. The recoverable case
> branches to bad_el0_sync with a bl, and returns to userspace via the
> usual ret_to_user mechanism.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 9955ac47f4ba1c95 ("arm64: don't kill the kernel on a bad esr from el0")
> Reported-by: Mark Salter <msalter@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable at vger.kernel.org

Thanks. I'll queue this for 4.10.

-- 
Catalin
