From: anurag19aggarwal@gmail.com (Anurag Aggarwal)
Date: Sat, 3 May 2014 12:35:39 +0530
Subject: [PATCH] ARM: unwind: Fix handling of "Pop r4-r[4+nnn], r14" opcode
In-Reply-To: <1398855131-15079-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1398855131-15079-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <CAPoNrtsqkqR=07nq5zHnWt4eF-m_A1i_0LQf9rF_-ho+uDoY8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I must of missed the wrong opcode, as my major focus was on preventing
the Data abort.


On Wed, Apr 30, 2014 at 4:22 PM, Nikolay Borisov
<Nikolay.Borisov@arm.com> wrote:
> The arm EABI states that opcode 10100nnn means pop register r4-4[4+nnn],
> aditionally there is a similar opcode: 10101nnn which means the same thing plus
> popping r14. Those two cases are handled by the unwind_exec_pop_r4_to_rN
> function which checks whether the 4th bit is set and does r14 popping.
>
> However, up until now it has been checking whether the 8th was set (mask & 0x80)
> instead of the 4th (mask & 0x8), a simple to make typo but this meant that we
> were always popping r14 even if we had the former opcode.
>
> This patch changes the mask so that the 2 opcodes are being handled correctly.
>
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
Reviewed-by: Anurag Aggarwal <anurag19aggarwal@gmail.com>
> ---
>
> I tested this patch using magic sysrq to generate backtrace of every process and
> it was working. However, inspecting the unwind table for vmlinuz it seems that
> the majority of the instructions do in fact require popping r14 so that's why
> this has gone unnoticed for a long period, however I'm open to suggestions how
> to more thoroughly test this.
>
> The first thing that comes to mind is manually fiddle with the unwind table of a
> well-known function so that it no longer requires r14 being popped.
>
>  arch/arm/kernel/unwind.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 3c21769..cb791ac 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -285,7 +285,7 @@ static int unwind_exec_pop_r4_to_rN(struct unwind_ctrl_block *ctrl,
>                 if (unwind_pop_register(ctrl, &vsp, reg))
>                                 return -URC_FAILURE;
>
> -       if (insn & 0x80)
> +       if (insn & 0x8)
>                 if (unwind_pop_register(ctrl, &vsp, 14))
>                                 return -URC_FAILURE;
>
> --
> 1.8.1.5
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Anurag Aggarwal
