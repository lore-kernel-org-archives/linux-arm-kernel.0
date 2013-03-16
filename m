From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 15 Mar 2013 21:15:11 -0300
Subject: [PATCH 1/6] serial: 8250_dw: add support for clk api
In-Reply-To: <20130315223917.GZ4977@n2100.arm.linux.org.uk>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363377988-4966-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130315223917.GZ4977@n2100.arm.linux.org.uk>
Message-ID: <BLU0-SMTP4156A39670AA58651B05028AEE0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

El 15/03/13 19:39, Russell King - ARM Linux escribi?:
> On Fri, Mar 15, 2013 at 09:06:23PM +0100, Maxime Ripard wrote:
>> +	/* clock got configured through clk api, all done */
>> +	if (p->uartclk)
> 
> 	if (IS_ERR(p->uartclk))
> 

Isn't IS_ERR for pointers? p->uartclk is an unsigned int

>> +		return 0;
>> +
>> +	/* try to find out clock frequency from DT as fallback */
>>  	if (of_property_read_u32(np, "clock-frequency", &val)) {
>> -		dev_err(p->dev, "no clock-frequency property set\n");
>> +		dev_err(p->dev, "clk or clock-frequency not defined\n");
>>  		return -EINVAL;
>>  	}
>>  	p->uartclk = val;
>> @@ -294,9 +301,21 @@ static int dw8250_probe(struct platform_device *pdev)
>>  	if (!uart.port.membase)
>>  		return -ENOMEM;
>>  
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(data->clk))
>> +		data->clk = NULL;
>> +	else
>> +		clk_prepare_enable(data->clk);
> 
> 	if (!IS_ERR(data->clk))
> 		clk_prepare_enable(data->clk);
> 

See below

>> +
>>  	uart.port.iotype = UPIO_MEM;
>>  	uart.port.serial_in = dw8250_serial_in;
>>  	uart.port.serial_out = dw8250_serial_out;
>> +	uart.port.private_data = data;
>> +	uart.port.uartclk = clk_get_rate(data->clk);
> 
> What if data->clk is invalid?
> 
> 	if (!IS_ERR(data->clk)
> 		uart.port.uartclk = clk_get_rate(data->clk);
> 

I'm not sure if it is coincidental or the way it is supposed to be, but
when using the common clock framework, if you pass a NULL to
clk_get_rate, the function explicitly checks for it and returns 0. I
relied on that behaviour when implementing this; see the if..else block
above. Is this not always the case on other clock drivers?

>>  
>>  	dw8250_setup_port(&uart);
>>  
>> @@ -312,12 +331,6 @@ static int dw8250_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  	}
>>  
>> -	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> -	if (!data)
>> -		return -ENOMEM;
>> -
>> -	uart.port.private_data = data;
>> -
>>  	data->line = serial8250_register_8250_port(&uart);
>>  	if (data->line < 0)
>>  		return data->line;
>> @@ -333,6 +346,8 @@ static int dw8250_remove(struct platform_device *pdev)
>>  
>>  	serial8250_unregister_port(data->line);
>>  
> 
> 	if (!IS_ERR(data->clk)
> 

I just double checked and clk_enable/disable, clk_prepare/unprepare also
ignore NULLs passed to them on the CCF.

>> +	clk_disable_unprepare(data->clk);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 1.7.10.4

Thanks for the review,

Emilio
