From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Wed, 19 Jan 2011 14:08:29 -0800
Subject: [PATCH 2/2] serial: msm: Add support for UARTDM cores
In-Reply-To: <20110119082534.GA9569@gallagher>
References: <1295407585-18386-1-git-send-email-stepanm@codeaurora.org>
	<20110119082534.GA9569@gallagher>
Message-ID: <4D3760DD.1010609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jamie

Thanks for the comments. Responses inline. I will have a v2 out once 
I've had a chance to retest everything.

Steve

On 1/19/2011 12:25 AM, Jamie Iles wrote:
> Hi Stepan,
>
> A couple of pedantic comments inline, otherwise looks good to me.
>
> Jamie
>
> On Tue, Jan 18, 2011 at 07:26:25PM -0800, Stepan Moskovchenko wrote:
>> @@ -38,9 +40,20 @@ struct msm_port {
>>   	struct uart_port	uart;
>>   	char			name[16];
>>   	struct clk		*clk;
>> +	struct clk		*pclk;
>>   	unsigned int		imr;
>> +	unsigned int            *gsbi_base;
>> +	int			is_dm;
>> +	unsigned int		old_snap_state;
>>   };
> Out of interest, what does .is_dm mean?  Is that obvious to someone who
> knows about msm?
It indicates the type of the UART block. I agree that it isn't a very 
good name, but there are no clear versions defined. Basically, the 
driver used to support the MSM UART block, but we are now adding support 
for the UARTDM block (which is very similar to the original, but had 
some DMA capabilities). I've renamed it to is_uartdm for more clarity.


>> +static inline void wait_for_xmitr(struct uart_port *port, int bits)
>> +{
>> +	if (!(msm_read(port, UART_SR)&  UART_SR_TX_EMPTY))
>> +		while ((msm_read(port, UART_ISR)&  bits) != bits)
>> +			cpu_relax();
>> +}
> Is it worth adding a timeout in here?
I don't think so. Other drivers generally don't have timeouts in their 
console path, since dropping characters or timing out in this case could 
be misleading (and if it's happening, you have bigger problems). As for 
the general transmit path, this would only be called when the TX FIFO 
interrupt happens, meaning this will be a fall-through.

>> +		/* Mask conditions we're ignorning. */
>> +		sr&= port->read_status_mask;
>> +		if (sr&  UART_SR_RX_BREAK)
>> +			flag = TTY_BREAK;
>> +		else if (sr&  UART_SR_PAR_FRAME_ERR)
>> +			flag = TTY_FRAME;
> It doesn't look like the flag is used anywhere after it has been
> assigned.
An artifact of an old driver. Removed.

>>   static void msm_init_clock(struct uart_port *port)
>>   {
>>   	struct msm_port *msm_port = UART_TO_MSM(port);
>>
>>   	clk_enable(msm_port->clk);
>> +	if (msm_port->pclk)
>> +		clk_enable(msm_port->pclk);
> NULL is a valid clk, so this should really be something like
>
> 	if (!IS_ERR(mem_port->pclk)
> 		clk_enable(...);
I don't think that will have the correct behavior. The clock is already 
checked with IS_ERR in the probe function, so we could not get here if 
the clk_get returned an error. Depending on the unit, there may or may 
not be a pclk associated with it. Thus, I use NULL to indicate that a 
pclk does not exist and should not be turned on. Regardless, at least in 
the MSM clock driver (and in drivers/clkdev) NULL is not a valid clock, 
I think this should be fine as is.

>>   	msm_serial_set_mnd_regs(port);
>>   }
>>
>> @@ -347,15 +455,32 @@ static int msm_startup(struct uart_port *port)
>>   		msm_write(port, data, UART_IPR);
>>   	}
>>
>> -	msm_reset(port);
>> +	data = 0;
>> +	if ((!port->cons) ||
>> +	    (port->cons&&  (!(port->cons->flags&  CON_ENABLED)))) {
> Safe to remove the extra parentheses here.
Done.

>> -	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (unlikely(!resource))
>> +	uart_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (unlikely(!uart_resource))
>>   		return;
>> -	size = resource->end - resource->start + 1;
>> +	size = uart_resource->end - uart_resource->start + 1;
> resource_size()?
Ooh, how useful :). Done, in all instances.

>> +
>> +		if (unlikely(!request_mem_region(gsbi_resource->start, size,
>> +						 "msm_serial"))) {
>> +			ret = -EBUSY;
>> +			goto fail_release_port;
>> +		}
> Is the unlikely() really worth it in this sort of path?  More
> particularly, why is request_mem_region() more special than the other
> calls that can fail here?

Cleaned up the unlikely stuff.

>>   static int msm_verify_port(struct uart_port *port, struct serial_struct *ser)
>> @@ -515,9 +697,13 @@ static void msm_power(struct uart_port *port, unsigned int state,
>>   	switch (state) {
>>   	case 0:
>>   		clk_enable(msm_port->clk);
>> +		if (msm_port->pclk)
>> +			clk_enable(msm_port->pclk);
> if (!IS_ERR(msm_port->pclk))
>
>>   		break;
>>   	case 3:
>>   		clk_disable(msm_port->clk);
>> +		if (msm_port->pclk)
>> +			clk_disable(msm_port->pclk);
> if (!IS_ERR(msm_port->pclk))
See the earlier comment. We are checking the clock for IS_ERR when we 
clk_get it (and bail if there is an error) so there is no use checking 
it here again. We need NULL to indicate that the clock is not present in 
this case (and null will not be something legitimately returned by clk_get).

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
