From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 16 Jul 2014 10:26:38 +0200
Subject: [PATCH 3/6] tty: serial: 8250 core: add runtime pm
In-Reply-To: <20140710062812.GF28884@atomide.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-4-git-send-email-bigeasy@linutronix.de>
 <20140710062812.GF28884@atomide.com>
Message-ID: <53C6373E.2010408@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 08:28 AM, Tony Lindgren wrote:
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -571,7 +573,17 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>>  			serial_out(p, UART_EFR, 0);
>>  			serial_out(p, UART_LCR, 0);
>>  		}
>> +
>> +		if (!device_may_wakeup(p->port.dev)) {
>> +			if (sleep)
>> +				pm_runtime_forbid(p->port.dev);
>> +			else
>> +				pm_runtime_allow(p->port.dev);
>> +		}
>>  	}
>> +out:
>> +	pm_runtime_mark_last_busy(p->port.dev);
>> +	pm_runtime_put_autosuspend(p->port.dev);
>>  }
> 
> The device_may_wakeup logic here is wrong as I described in the
> earlier thread. For runtime PM, the wake-up events should be
> always enabled. So the device_may_wakeup checks should be only
> done for suspend and resume.

Okay. I dropped it from here.

> 
> Regards,
> 
> Tony
> 

Sebastian
