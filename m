From: jean.pihet@linaro.org (Jean Pihet)
Date: Tue, 26 Aug 2014 16:43:10 +0200
Subject: [PATCH 11/11] arm64: perf: don't rely on layout of pt_regs when
 grabbing sp or pc
In-Reply-To: <1409062410-25891-12-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-12-git-send-email-will.deacon@arm.com>
Message-ID: <CAFrcx1moWmtAtuJaR79JpabzUfqwgn4hKL4ZtfR1mDxquF3jZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 26 August 2014 16:13, Will Deacon <will.deacon@arm.com> wrote:
> The current perf_regs code relies on sp and pc sitting just off the end
> of the pt_regs->regs array. This is ugly and fragile, so this patch
> checks for these register explicitly and returns the appropriate field.
That is correct but costs you some code to test the index.

Acked-by: Jean Pihet <jean.pihet@linaro.org>

Jean

>
> Cc: Jean Pihet <jean.pihet@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/perf_regs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> index 422ebd63b619..6762ad705587 100644
> --- a/arch/arm64/kernel/perf_regs.c
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -24,6 +24,12 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>                         return regs->compat_lr;
>         }
>
> +       if ((u32)idx == PERF_REG_ARM64_SP)
> +               return regs->sp;
> +
> +       if ((u32)idx == PERF_REG_ARM64_PC)
> +               return regs->pc;
> +
>         return regs->regs[idx];
>  }
>
> --
> 2.1.0.rc1
>
