From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 11 May 2012 18:04:58 -0700
Subject: [PATCH] RFC: ARM: msm: re-read DMA IRQ status on each iteration
In-Reply-To: <1336738791-15037-1-git-send-email-linus.walleij@stericsson.com>
References: <1336738791-15037-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4FADB73A.8050200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2012 05:19 AM, Linus Walleij wrote:
> David et al: I'm uncertain about this one since the comment
> says that the read clears the IRQ, such as if the read operation
> itself will latch out the flag register and clear it. (I encountered
> this behaviour in the MOS6569 VIC raster IRQ register $D019 in the
> 1980s if I'm not mistaken.)
> ---
>   arch/arm/mach-msm/dma.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
> index 02cae5e..ee11afe 100644
> --- a/arch/arm/mach-msm/dma.c
> +++ b/arch/arm/mach-msm/dma.c
> @@ -147,10 +147,8 @@ static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
>
>   	spin_lock_irqsave(&msm_dmov_lock, irq_flags);
>
> -	int_status = readl(DMOV_ISR); /* read and clear interrupt */
> -	PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
> -
> -	while (int_status) {
> +	while (int_status = readl(DMOV_ISR)) {
> +		PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
>   		mask = int_status&  -int_status;
>   		id = fls(mask) - 1;
> PRINT_FLOW("msm_datamover_irq_handler %08x %08x id %d\n", int_status, 
> mask, id);
This is incorrect. Reading from the DMOV_ISR register there will 
actually clear it, causing us to
lose state for interrupts on channels other than the first one 
processed. If we miss some by not
re-reading the register, another interrupt will be raised so it isn't a 
problem.

Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
