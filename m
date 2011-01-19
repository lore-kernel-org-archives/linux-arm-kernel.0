From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 22:24:07 +0000
Subject: [PATCH 2/2] serial: msm: Add support for UARTDM cores
In-Reply-To: <4D3760DD.1010609@codeaurora.org>
References: <1295407585-18386-1-git-send-email-stepanm@codeaurora.org>
	<20110119082534.GA9569@gallagher> <4D3760DD.1010609@codeaurora.org>
Message-ID: <20110119222407.GD6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 02:08:29PM -0800, Stepan Moskovchenko wrote:
>>> +		/* Mask conditions we're ignorning. */
>>> +		sr&= port->read_status_mask;
>>> +		if (sr&  UART_SR_RX_BREAK)
>>> +			flag = TTY_BREAK;
>>> +		else if (sr&  UART_SR_PAR_FRAME_ERR)
>>> +			flag = TTY_FRAME;
>> It doesn't look like the flag is used anywhere after it has been
>> assigned.
> An artifact of an old driver. Removed.

But still required to support proper error signalling.

>>>   static void msm_init_clock(struct uart_port *port)
>>>   {
>>>   	struct msm_port *msm_port = UART_TO_MSM(port);
>>>
>>>   	clk_enable(msm_port->clk);
>>> +	if (msm_port->pclk)
>>> +		clk_enable(msm_port->pclk);
>> NULL is a valid clk, so this should really be something like
>>
>> 	if (!IS_ERR(mem_port->pclk)
>> 		clk_enable(...);
> I don't think that will have the correct behavior. The clock is already  
> checked with IS_ERR in the probe function, so we could not get here if  
> the clk_get returned an error. Depending on the unit, there may or may  
> not be a pclk associated with it. Thus, I use NULL to indicate that a  
> pclk does not exist and should not be turned on. Regardless, at least in  
> the MSM clock driver (and in drivers/clkdev) NULL is not a valid clock,  
> I think this should be fine as is.

Don't invent new ways to do things.  As far as drivers are concerned,
struct clk pointers are cookies.  The only thing they can interpret from
them is whether they're IS_ERR() and then what the error is.  They must
assume every other value is valid.

So, if you want "clock not present" assign ERR_PTR(-ENOENT) to it or
just assign the return value from the failed clk_get().
