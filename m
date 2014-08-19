From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 19 Aug 2014 07:58:21 -0400
Subject: [PATCH v9 12/16] serial: amba-pl011: Pass FIQ information to KGDB.
In-Reply-To: <53F313F2.6090103@linaro.org>
References: <1404979427-12943-1-git-send-email-daniel.thompson@linaro.org>
 <1408372091-12689-13-git-send-email-daniel.thompson@linaro.org>
 <53F24660.2030404@hurleysoftware.com> <53F313F2.6090103@linaro.org>
Message-ID: <53F33BDD.8050705@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2014 05:08 AM, Daniel Thompson wrote:
> On 18/08/14 19:30, Peter Hurley wrote:

[cut]
  
>>> +static int pl011_poll_init(struct uart_port *port)
>>> +{
>>> +	struct uart_amba_port *uap = (struct uart_amba_port *)port;
>>
>> Please use container_of() in new code.
> 
> Ok.
> 
> Personally I dislike a file that mixes casts and conatiner_of but I
> guess I can make both of us happy by switching the whole driver to
> container_of. Separate patch again?

The change below makes the uap local unnecessary, so you can skip the
container_of() change, if you'd prefer.

>>> +	int retval;
>>> +
>>> +	retval = pl011_hwinit(port);
>>> +
>>> +#ifdef CONFIG_KGDB_FIQ
>>> +	if (retval == 0)
>>> +		kgdb_register_fiq(uap->port.irq);
>>
>> The uap->port dereference is unnecessary since the port parameter
>> is the same thing.
>>
>> 		kgdb_register_fiq(port->irq);
> 
> Ok.

Thanks,
Peter Hurley
