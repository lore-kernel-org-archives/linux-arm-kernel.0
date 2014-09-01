From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 01 Sep 2014 16:48:00 +0200
Subject: [PATCH 03/15] tty: serial: 8250_core: add run time pm
In-Reply-To: <20140820093936.GB20775@ci00147.xsens-tech.local>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-4-git-send-email-bigeasy@linutronix.de>
 <20140820092319.GA20775@ci00147.xsens-tech.local>
 <20140820093936.GB20775@ci00147.xsens-tech.local>
Message-ID: <54048720.9000003@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 11:39 AM, Frans Klaver wrote:

>>>  static int serial8250_get_poll_char(struct uart_port *port)
>>>  {
>>> -	unsigned char lsr = serial_port_in(port, UART_LSR);
>>> +	unsigned char lsr;
>>> +	int status;
>>> +
>>> +	serial8250_rpm_get(up);
>>
>> or up won't be defined below. You probably need 
> 
> Obviously I meant to say that 'up' won't be defined here.

Good catch, thanks. However I wouldn't bet my money it that won't be
defined here. The semaphore code provides up() and down() so it is
makes it kind of defined :) But it doesn't compile due to wrong pointer
types which is good (I run into this myself and looked confused at
first).
I didn't notice this at all because only kgdb uses this
CONFIG_CONSOLE_POLL which I had off. Once again, thank you.

>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> somewhere in there.

Sebastian
