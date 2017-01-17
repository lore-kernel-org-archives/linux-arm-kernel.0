From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Jan 2017 08:54:56 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 (Jan Kiszka's message of "Mon, 16 Jan 2017 19:44:55 +0100")
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <87ziiqdstr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> When using the a device with edge-triggered interrupts, such as MSIs,
> the interrupt handler has to ensure that there is a point in time during
> its execution where all interrupts sources are silent so that a new
> event can trigger a new interrupt again.
>
> This is achieved here by looping over SSSR evaluation. We need to take
> into account that SSCR1 may be changed by the transfer handler, thus we
> need to redo the mask calculation, at least regarding the volatile
> interrupt enable bit (TIE).
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Hi Jan,

> +	while (1) {
This bit worries me a bit, as this can be either :
 - hogging the SoC's CPU, endlessly running
 - or even worse, blocking the CPU for ever

The question behind is, should this be done in a top-half, or moved to a irq
thread ?

> +		/* Ignore possible writes if we don't need to write */
> +		if (!(sccr1_reg & SSCR1_TIE))
> +			mask &= ~SSSR_TFS;
>  
> -	if (!drv_data->master->cur_msg) {
> -		handle_bad_msg(drv_data);
> -		/* Never fail */
> -		return IRQ_HANDLED;
> -	}
> +		if (!(status & mask))
> +			return ret;
> +
> +		if (!drv_data->master->cur_msg) {
> +			handle_bad_msg(drv_data);
> +			/* Never fail */
> +			return IRQ_HANDLED;
> +		}
> +
> +		ret |= drv_data->transfer_handler(drv_data);
Mmm that looks weird to me, oring a irqreturn.

Imagine that on first iteration the handler returns IRQ_NONE, and on second
IRQ_HANDLED. This makes ret IRQ_HANDLED. Yet after the first iteration the
handler should have exited, especially if the interrupt is shared with another
driver.

Another thing which is along what Andy already said : it would be better
practice to have this loop in the form :
do {
...
} while (exit_condition_not_met);

Just for maintainability, it's better, and it concentrates the test on the
"exit_condition_not_met" in one place, which will enable us to review better the
algorithm.

Cheers.

-- 
Robert
