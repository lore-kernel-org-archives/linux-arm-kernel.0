From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Mon, 2 Aug 2010 10:01:09 +0200
Subject: [PATCH] U6715 platform serial driver It's a generic driver for
	all U6XXX platform
In-Reply-To: <20100731105946.GK23886@n2100.arm.linux.org.uk>
References: <1280417192-25710-1-git-send-email-philippe.langlais@stericsson.com>
	<20100731105946.GK23886@n2100.arm.linux.org.uk>
Message-ID: <4C567B45.7050507@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/31/10 12:59, Russell King - ARM Linux wrote:
> On Thu, Jul 29, 2010 at 05:26:32PM +0200, Philippe Langlais wrote:
>    
>> +unsigned int u6_serial8250_enable_clock(struct uart_port *port)
>> +{
>> +	struct u6_uart *uart_u6 = port->private_data;
>> +
>> +	if (!uart_u6)
>> +		return uart_enable_clock(port);
>> +
>> +	if (IS_ERR(uart_u6->uartClk)) {
>> +		pr_warning("%s - uart clock failed error:%ld\n",
>> +		       __func__, PTR_ERR(uart_u6->uartClk));
>> +		return PTR_ERR(uart_u6->uartClk);
>> +	}
>> +
>> +	if (clk_get_usecount(uart_u6->uartClk) == 0)
>> +		clk_enable(uart_u6->uartClk);
>>      
> This breaks the atomic update nature of the use count of clocks, and breaks
> the model that the driver should only ever enable the clock if it needs it.
> I think instead you need to track whether the driver enabled or disabled
> its own clock.
>    
Hi,
You are right.
I forgot to withdraw these tests needed for our specific power managment.
The new patch will follow.
If you have no more remark, I'm ready to send all U6715 patches in your 
patch system.

Thanks

Philippe
