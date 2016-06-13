From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jun 2016 13:48:24 +0100
Subject: [PATCH 1/2] arm64: fix dump_instr when PAN and UAO are in use
In-Reply-To: <1465812915-19801-2-git-send-email-mark.rutland@arm.com>
References: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
 <1465812915-19801-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20160613124823.GF1605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 11:15:14AM +0100, Mark Rutland wrote:
> If the kernel is set to show unhandled signals, and a user task does not
> handle a SIGILL as a result of an instruction abort, we will attempt to
> log the offending instruction with dump_instr before killing the task.
> 
> We use dump_instr to log the encoding of the offending userspace
> instruction. However, dump_instr is also used to dump instructions from
> kernel space, and internally always switches to KERNEL_DS before dumping
> the instruction with get_user. When both PAN and UAO are in use, reading
> a user instruction via get_user while in KERNEL_DS will result in a
> permission fault, which leads to an Oops.
> 
> As we have regs corresponding to the context of the original instruction
> abort, we can inspect this and only flip to KERNEL_DS if the original
> abort was taken from the kernel, avoiding this issue. At the same time,
> remove the redundant (and incorrect) comments regarding the order
> dump_mem and dump_instr are called in.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 57f4959bad0a154a ("arm64: kernel: Add support for User Access Override")
> ---
>  arch/arm64/kernel/traps.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Queued as a fix for 4.8 w/ Vladimir's Tested-by. Please try to keep fixes
and cleanups/features separate in future series.

Will
