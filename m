From: b32955@freescale.com (Huang Shijie)
Date: Fri, 28 Jun 2013 10:17:49 +0800
Subject: [PATCH 1/2] serial: imx: remove the uart_console() check
In-Reply-To: <20130627141535.GD2695@S2101-09.ap.freescale.net>
References: <1372239359-4054-1-git-send-email-b32955@freescale.com>
 <20130627141535.GD2695@S2101-09.ap.freescale.net>
Message-ID: <51CCF24D.1060007@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?06?27? 22:15, Shawn Guo ??:
>>   	* Check whether an invalid uart number has been specified, and
>> >  @@ -1371,6 +1381,15 @@ imx_console_setup(struct console *co, char *options)
>> >    	if (sport == NULL)
>> >    		return -ENODEV;
>> >  
>> >  +	retval = clk_prepare_enable(sport->clk_per);
>> >  +	if (retval)
>> >  +		goto error_console;
>> >  +	retval = clk_prepare_enable(sport->clk_ipg);
>> >  +	if (retval) {
>> >  +		clk_disable_unprepare(sport->clk_per);
>> >  +		goto error_console;
>> >  +	}
>> >  +
> Why do we need clk_enable() here at all?  The amba-pl011 driver only
> calls clk_prepare() in console .setup().
>
We need to set the imx_setUp_ufcr() in our imx_console_setup(),
so we need to enable the clocks, aren't we?
>> >    	if (options)
>> >    		uart_parse_options(options,&baud,&parity,&bits,&flow);
>> >    	else
>> >  @@ -1378,7 +1397,17 @@ imx_console_setup(struct console *co, char *options)
>> >  
>> >    	imx_setup_ufcr(sport, 0);
>> >  
>> >  -	return uart_set_options(&sport->port, co, baud, parity, bits, flow);
>> >  +	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
>> >  +
>> >  +	clk_disable(sport->clk_per);
>> >  +	clk_disable(sport->clk_ipg);
>> >  +	if (retval) {
>> >  +		clk_unprepare(sport->clk_per);
>> >  +		clk_unprepare(sport->clk_ipg);
>> >  +	}
>> >  +
>> >  +error_console:
>> >  +	return retval;
>> >    }
>> >  
>> >    static struct uart_driver imx_reg;
>> >  @@ -1583,10 +1612,8 @@ static int serial_imx_probe(struct platform_device *pdev)
>> >    		goto deinit;
>> >    	platform_set_drvdata(pdev, sport);
>> >  
>> >  -	if (!uart_console(&sport->port)) {
>> >  -		clk_disable_unprepare(sport->clk_per);
>> >  -		clk_disable_unprepare(sport->clk_ipg);
>> >  -	}
>> >  +	clk_disable_unprepare(sport->clk_per);
>> >  +	clk_disable_unprepare(sport->clk_ipg);
> I also had a hard time to understand why we need to turn on the clocks
> in .probe() for a while and then turn them off.
In the probe's uart_add_one_port(), we will register the console and 
call the setup() hook,
so it's ok to disable the clocks in the end of the probe.
> It just reminds me a thing.  Did you test CONFIG_CONSOLE_POLL support
> when your commit 28eb427 (serial: imx: enable the clocks only when the
> uart is used) went in?  The commit turns off the clocks at the
sorry, i did not do this.
> end of .probe(), but who will enable the clocks for .poll_get_char()
> and .poll_put_char()?  The amba-pl011 driver does that in .poll_init().
>
dido. in the uart_add_one_port().

thanks
Huang Shijie
