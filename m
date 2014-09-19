From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Sat, 20 Sep 2014 00:29:01 +0300
Subject: [RFC] ARM: edma: unconditionally ack the error interrupt
In-Reply-To: <20140918161225.GA10232@linutronix.de>
References: <1410377960-26921-1-git-send-email-bigeasy@linutronix.de>
 <541AA900.4080506@ti.com> <20140918161225.GA10232@linutronix.de>
Message-ID: <541CA01D.1000006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 07:12 PM, Sebastian Andrzej Siewior wrote:
> * Peter Ujfalusi | 2014-09-18 12:42:24 [+0300]:
> 
>> My hunch on what could be causing this that we might have unhandled dma event
>> and another comes. This will flag the EDMA_EMR register. Any change in this
>> register will assert error interrupt which can only be cleared by writing to
>> EDMA_EMRC register.
>> The EDMA_EMRC register bits also cleared on edma_start(), edma_stop() and
>> edma_clean_channel() apart from the error interrupt handler.
>> So it is possible that we have missed event on one of the channels but a stop
>> might clear the event so in the interrupt hander we do not see this.
>> I think it would be good to understand what is going on the backround...
>> Can you print out the EDMA_EMCR just before we clear it in the places I have
>> mentioned? We might get better understanding on which stage we clear it and
>> probably we can understand how to fix this properly so we are not going to
>> have missed events on channels.
> 
> Okay. For the protocol I applied this patch:
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 160460ae3a49..16598625a4d1 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -422,20 +422,24 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
>  	int i;
>  	int ctlr;
>  	unsigned int cnt = 0;
> +	u32 emr0;
>  
>  	ctlr = irq2ctlr(irq);
>  	if (ctlr < 0)
>  		return IRQ_NONE;
>  
>  	dev_dbg(data, "dma_ccerr_handler\n");
> +	emr0 = edma_read_array(ctlr, EDMA_EMR, 0);
>  
> -	if ((edma_read_array(ctlr, EDMA_EMR, 0) == 0) &&
> +	if ((emr0 == 0) &&
>  	    (edma_read_array(ctlr, EDMA_EMR, 1) == 0) &&
>  	    (edma_read(ctlr, EDMA_QEMR) == 0) &&
>  	    (edma_read(ctlr, EDMA_CCERR) == 0)) {
>  		edma_write(ctlr, EDMA_EEVAL, 1);
> +		trace_printk("Unhandled\n");
>  		return IRQ_NONE;
>  	}
> +	trace_printk("emr0: %x\n", emr0);
>  
>  	while (1) {
>  		int j = -1;
> @@ -1310,6 +1314,9 @@ int edma_start(unsigned channel)
>  		pr_debug("EDMA: ER%d %08x\n", j,
>  			edma_shadow0_read_array(ctlr, SH_ER, j));
>  		/* Clear any pending event or error */
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_ECR, j, mask);
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  		/* Clear any SER */
> @@ -1347,6 +1354,9 @@ void edma_stop(unsigned channel)
>  		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  
>  		pr_debug("EDMA: EER%d %08x\n", j,
> @@ -1387,6 +1397,9 @@ void edma_clean_channel(unsigned channel)
>  				edma_read_array(ctlr, EDMA_EMR, j));
>  		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
>  		/* Clear the corresponding EMR bits */
> +		trace_printk("j%d mask%x EDMA_EMCR: %x\n",
> +			     j, mask,
> +			     edma_read_array(ctlr, EDMA_EMCR, j));
>  		edma_write_array(ctlr, EDMA_EMCR, j, mask);
>  		/* Clear any SER */
>  		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
> 
> --
> 
> and the result is something like this:
> 
>            <idle>-0     [000] dnh.   303.356403: edma_start: j0 mask8000000 EDMA_EMCR: 0
>            <idle>-0     [000] d.h.   303.396721: edma_stop: j0 mask8000000 EDMA_EMCR: 0
>            <idle>-0     [000] dnh.   303.557103: edma_start: j0 mask8000000 EDMA_EMCR: 0
>            <idle>-0     [000] dnh.   303.557129: edma_stop: j0 mask4000000 EDMA_EMCR: 0
>            <idle>-0     [000] dnH.   303.557142: dma_ccerr_handler: Unhandled
>              less-2612  [000] d...   303.557237: edma_start: j0 mask4000000 EDMA_EMCR: 0
>              less-2612  [000] d.h.   303.562491: edma_stop: j0 mask4000000 EDMA_EMCR: 0
>              less-2612  [000] d...   303.564475: edma_start: j0 mask4000000 EDMA_EMCR: 0
> 
> The full trace is at [0]. I haven't found a single entry where EDMA_EMCR
> was != 0 at those spots. *If* there is a edma_stop() before the
> interrupt then the interrupt remains unhandled. If there is a
> edma_start() with mask 8000000 then we have dma_ccerr_handler() with a
> mask of 4000000.

mask 8000000 means URXEVT0 (UART0 rx), 4000000 is UTXEVT0 (UART0 tx) events.
But it is clear that my theory was not even close to what's going on.
Do you have some tool which can be used to reproduce this issue?

> 
> Fun fact: If I remove the write access to EDMA_EMCR register (the write
> access after the read out) then I haven't seen [1] a single error interrupt
> beeing "unhandled" out of 9. The former has three out of eight.

Hrm, this is interesting. Am I interpret it right:
if you clear the event missed register's bit for the event, you will receive
the interrupt, but there if you read the EMR bits, they are all 0.
if you do not clear the bit in the event missed register (even if it is not
set) you will not receive the error interrupt. Right?

I think this can be due to the fact how edma (if I read the TRM right) works:
the error irq will be asserted if there is a transition from 0 to 1 in one of
the error registers. If you had error and you did not cleared the error bit,
the next error will not going to cause another transition so no interrupt will
be triggered. Having said that, there should be at least one error interrupt
coming since at some point we should have had 0 -> 1 transition...

Can you print out also the EDMA_EMR at places you were printing EDMA_EMCR?

> 
> [0] https://breakpoint.cc/edma_trace.txt.xz
> [1] https://breakpoint.cc/edma_trace_nowrite.txt.xz
> 
> Sebastian
> 


thanks,
P?ter
