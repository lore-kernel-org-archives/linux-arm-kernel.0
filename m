From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 1 Dec 2011 11:32:43 +0100
Subject: [PATCH] imx: add polled io uart methods
In-Reply-To: <20111019035249.GA20598@lithium.compnerd.org>
References: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>	<1318821721-11965-1-git-send-email-compnerd@compnerd.org>	<1318821721-11965-2-git-send-email-compnerd@compnerd.org>	<20111018072733.GC21504@pengutronix.de>
 <20111019035249.GA20598@lithium.compnerd.org>
Message-ID: <4ED757CB.8030000@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.10.2011 05:52, Saleem Abdulrasool wrote:
> On Tue, 18 Oct 2011, Uwe Kleine-K?nig wrote:
> 
>> On Sun, Oct 16, 2011 at 08:22:01PM -0700, Saleem Abdulrasool wrote:
>>> These methods are invoked if the iMX uart is used in conjuction with kgdb during
>>> early boot.  In order to access the UART without the interrupts, the kernel uses
>>> the basic polling methods for IO with the device.  With these methods
>>> implemented, it is now possible to enable kgdb during early boot over serial.
>>>
>>> Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
>>> ---
>>>  drivers/tty/serial/imx.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 77 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>>> index 7e91b3d..4fcf9ca 100644
>>> --- a/drivers/tty/serial/imx.c
>>> +++ b/drivers/tty/serial/imx.c
>>> @@ -102,6 +102,7 @@
>>>  #define  UCR2_STPB       (1<<6)	 /* Stop */
>>>  #define  UCR2_WS         (1<<5)	 /* Word size */
>>>  #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
>>> +#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
>>>  #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
>>>  #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
>>>  #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
>>> @@ -1075,6 +1076,77 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
>>>  	return ret;
>>>  }
>>>  
>>> +
>> needless newline
> 
> Removed.
> 
>>> +#if defined(CONFIG_CONSOLE_POLL)
>>> +static int imx_poll_get_char(struct uart_port *port)
>>> +{
>>> +	volatile unsigned int status;
>> Why is that volatile?
> 
> It shouldnt be, removed the volatile attribute.  Im not sure why that was there,
> it really doesnt make any sense since there isnt any inline assembler there to
> confuse the compiler.
> 
>>> +	unsigned int cr1, cr2, cr3;
>>> +	unsigned char c;
>>> +
>>> +	/* save control registers */
>>> +	cr1 = readl(port->membase + UCR1);
>>> +	cr2 = readl(port->membase + UCR2);
>>> +	cr3 = readl(port->membase + UCR3);
>>> +
>> Best regards
>> Uwe
> 
> Thanks for the review.  Ive not attached the updated patch since Id like to make
> the changes that Sascha suggested, and I shall post the updated patch
> subsequently.

Any update on this?

Many thanks

Dirk
