From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Oct 2017 15:37:15 +0100
Subject: [PATCH v2 2/2] arm64: Fix single stepping in kernel traps
In-Reply-To: <1507729721-53978-3-git-send-email-julien.thierry@arm.com>
References: <1507729721-53978-1-git-send-email-julien.thierry@arm.com>
 <1507729721-53978-3-git-send-email-julien.thierry@arm.com>
Message-ID: <20171011143715.GH11106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 02:48:41PM +0100, Julien Thierry wrote:
> Software Step exception is missing after stepping a trapped instruction.
> 
> Ensure SPSR.SS gets set to 0 after emulating/skipping a trapped instruction
> before doing ERET.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> ---
>  arch/arm64/include/asm/insn.h        |  5 +++++
>  arch/arm64/include/asm/traps.h       |  6 ++++++
>  arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
>  arch/arm64/kernel/cpufeature.c       |  2 +-
>  arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
>  5 files changed, 32 insertions(+), 10 deletions(-)

[...]

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5ea4b85..aaf9a523 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -293,6 +293,17 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
> 
> +void arm64_setup_next_instr(struct pt_regs *regs, unsigned long size)
> +{
> +	regs->pc += size;
> +
> +	/*
> +	 * If we were single stepping, we want to get the step exception after
> +	 * we return from the trap.
> +	 */
> +	regs->pstate &= ~DBG_SPSR_SS;

Can you use user_fastforward_single_step instead, like we do for the signal
handling path?

Will
