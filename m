From: b32955@freescale.com (Huang Shijie)
Date: Wed, 2 May 2012 16:28:07 +0800
Subject: [PATCH] serial/imx: enable the clock when we really use the uart
 port
In-Reply-To: <20120502081902.GT4141@pengutronix.de>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>
 <20120502081902.GT4141@pengutronix.de>
Message-ID: <4FA0F017.8090702@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?05?02? 16:19, Sascha Hauer ??:
> On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
>> The current code keeps the clock enabled even when we do not really
>> use the uart port. But keep the clock enabled will consume some power.
>>
>> In order to save more power, disable the clock when we do not use
>> the uart, and enable the clock when we really use the uart port.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
> This conflicts with my series converting i.MX to the common clock
> framework. Please lets delay this until this has been merged.
OK, thanks

Huang Shijie
> Sascha
>
>> ---
>>   drivers/tty/serial/imx.c |    6 +++++-
>>   1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e7fecee..f5dcdf6 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -694,6 +694,8 @@ static int imx_startup(struct uart_port *port)
>>   	int retval;
>>   	unsigned long flags, temp;
>>
>> +	clk_prepare_enable(sport->clk);
>> +
>>   	imx_setup_ufcr(sport, 0);
>>
>>   	/* disable the DREN bit (Data Ready interrupt enable) before
>> @@ -877,6 +879,8 @@ static void imx_shutdown(struct uart_port *port)
>>   		temp&= ~(UCR1_IREN);
>>
>>   	writel(temp, sport->port.membase + UCR1);
>> +
>> +	clk_disable_unprepare(sport->clk);
>>   }
>>
>>   static void
>> @@ -1526,6 +1530,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>>   		goto deinit;
>>   	platform_set_drvdata(pdev,&sport->port);
>>
>> +	clk_disable_unprepare(sport->clk);
>>   	return 0;
>>   deinit:
>>   	if (pdata&&  pdata->exit)
>> @@ -1552,7 +1557,6 @@ static int serial_imx_remove(struct platform_device *pdev)
>>
>>   	if (sport) {
>>   		uart_remove_one_port(&imx_reg,&sport->port);
>> -		clk_disable_unprepare(sport->clk);
>>   		clk_put(sport->clk);
>>   	}
>>
>> -- 
>> 1.7.3.2
>>
>>
>>
