From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 07 Feb 2011 10:26:32 +1100
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
In-Reply-To: <1295262433.30950.53.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
Message-ID: <1297034792.14982.10.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-17 at 12:07 +0100, Peter Zijlstra wrote:
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 68034bb..7ee0fc3 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -128,6 +128,7 @@ static irqreturn_t call_function_action(int irq, void *data)
>  static irqreturn_t reschedule_action(int irq, void *data)
>  {
>         /* we just need the return path side effect of checking need_resched */
> +       scheduler_ipi();
>         return IRQ_HANDLED;
>  }
>   

You missed:

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9813605..467d122 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -98,6 +98,7 @@ void smp_message_recv(int msg)
                break;
        case PPC_MSG_RESCHEDULE:
                /* we notice need_resched on exit */
+               scheduler_ipi();
                break;
        case PPC_MSG_CALL_FUNC_SINGLE:
                generic_smp_call_function_single_interrupt();

Fold that in and add:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(We have two variants of the IPIs)

Cheers,
Ben.
