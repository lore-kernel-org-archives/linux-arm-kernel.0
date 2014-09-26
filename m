From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Fri, 26 Sep 2014 15:23:59 +0200
Subject: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2.2c)
In-Reply-To: <20140926131117.GR5182@n2100.arm.linux.org.uk>
References: <1411150399-30902-1-git-send-email-j.uzycki@elproma.com.pl>
 <54256326.3080202@elproma.com.pl>
 <20140926131117.GR5182@n2100.arm.linux.org.uk>
Message-ID: <542568EF.1040103@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-09-26 15:11, Russell King - ARM Linux pisze:
> On Fri, Sep 26, 2014 at 02:59:18PM +0200, Janusz U?ycki wrote:
>> But serial8250_get_mctrl() in 8250_core.c calls serial8250_modem_status()
>> which calls eg. uart_handle_cts_change() even if enable_ms() wasn't called.
>> This is the difference.
>> The serial8250_modem_status() is also called in the interrupt
>> and, what I don't understand, in serial8250_console_write().
> Reading the MSR register clears the interrupts.  So, whenever MSR is read,
> you have to deal with any state changes which _would_ have been passed
> to the interrupt function.
>
> Plus, it's not quite as you make out above.
>
> If enable_ms() is not called, then UART_IER_MSI will not be set in up->ier.
> Hence, uart_handle_cts_change() will not be called.

Oh, now I understand the condition "up->ier & UART_IER_MSI"
in serial8250_modem_status().
So in case of gpio modem lines interrupt is the only right place like in 
atmel_serial.c.

> The reason for the call in the console function is to account for the
> state changes during console write with CTS flow control - this again
> needs the MSR register to be read, and we have to account for MSR state
> changes after the console write has completed.
It means that gpio modem lines does not support flow control for console
on the moment, right Richard?

best regards
Janusz
