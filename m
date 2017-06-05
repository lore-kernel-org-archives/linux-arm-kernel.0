From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Jun 2017 17:29:25 +0100
Subject: [PATCH v3 1/4] arm64: kgdb: fix single stepping
In-Reply-To: <20170523043058.5463-2-takahiro.akashi@linaro.org>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-2-takahiro.akashi@linaro.org>
Message-ID: <20170605162925.GO21944@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 01:30:55PM +0900, AKASHI Takahiro wrote:
> After entering kgdb mode, the first 'stepi' can succeed, but the following
> 'stepi' never executes the next instruction.
> 
> This is because a software step cannot get enabled as the software step
> bit(SS) in SPSR, which is cleared by the first single stepping, will not
> be set again for the following 's' commands.

For userspace, we have user_rewind_single_step to re-arm the state machine
on an unhandled step exception. It sounds like we need the kernel version of
that?

> Please note that this bit, as well as the software step control bit(SS)
> in MDSCR, must be set before resuming the execution.
> kernel_active_single_step() called by kgdb_arch_handle_exception() checks
> only for the bit in MDSCR, and so kgdb_enable_single_step() will never be
> called.

MDSCR.SS shouldn't get cleared by the hardware, so I don't understand your
point here.

Will
