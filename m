From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 18 Jul 2013 18:45:23 +0800
Subject: [PATCH V2 5/8] serial: at91: support run time switch transfer mode
In-Reply-To: <51E7A756.6010004@atmel.com>
References: <1373942627-7121-1-git-send-email-elen.song@atmel.com>
 <1373942627-7121-6-git-send-email-elen.song@atmel.com>
 <20130718081520.GC16015@ns203013.ovh.net> <51E7A756.6010004@atmel.com>
Message-ID: <288A72E2-2BFD-4D6D-930E-6CE06A8487FC@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jul 18, 2013, at 4:29 PM, elen.song <elen.song@atmel.com> wrote:

> Hi JC:
> On 7/18/2013 4:15 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 10:43 Tue 16 Jul     , Elen Song wrote:
>> 
>>> We will switch to pio mode when request of dma or pdc fail.
>>> But soon or later, when the request is success, the transfer mode can switch to them at
>>> next open serial port action.
>>> So in startup stage, we should get original transfer mode.
>>> 
>> You need to update the Documentation of the binding to said the driver support
>> dmas bindings for the new IP
>> 
> one question, it seems the document should write like:
>  
> +- use DMA:
> +       usart0: serial at f001c000 {
> +               compatible = "atmel,at91sam9260-usart";
> +               reg = <0xf001c000 0x100>;
> +               interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> +               dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> +                      <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +               dma-names = "tx", "rx";
> +       };
> 
> Should I instead macros with typical values?
> 

Value as MACRO is a linux artefact

Best Regards,
J.


> Best regards
>>  
>> and please use true/false for boolean
>> 
>> and check the white space
>> 
>>> Signed-off-by: Elen Song <elen.song@atmel.com>
>>> 
>>> ---
>>>  drivers/tty/serial/atmel_serial.c |  139 +++++++++++++++++++++----------------
>>>  1 file changed, 80 insertions(+), 59 deletions(-)
>>> 
>>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>>> index 298b58c..ad787fd1 100644
>>> --- a/drivers/tty/serial/atmel_serial.c
>>> +++ b/drivers/tty/serial/atmel_serial.c
>>> @@ -1371,6 +1371,80 @@ static void atmel_tasklet_func(unsigned long data)
>>>  	spin_unlock(&port->lock);
>>>  }
>>>  
>>> +static int atmel_init_property(struct atmel_uart_port *atmel_port,
>>> +				struct platform_device *pdev)
>>> +{
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>>> +
>>> +	if (np) {
>>> +		/* DMA/PDC usage specification */
>>> +		if (of_get_property(np, "atmel,use-dma-rx", NULL)) {
>>> +			if (of_get_property(np, "dmas", NULL)) {
>>> +				atmel_port->use_dma_rx  = 1;
>>> +				atmel_port->use_pdc_rx  = 0;
>>> +			} else {
>>> +				atmel_port->use_dma_rx  = 0;
>>> +				atmel_port->use_pdc_rx  = 1;
>>> +			}
>>> +		} else {
>>> +			atmel_port->use_dma_rx  = 0;
>>> +			atmel_port->use_pdc_rx  = 0;
>>> +		}
>>> +
>>> +		if (of_get_property(np, "atmel,use-dma-tx", NULL)) {
>>> +			if (of_get_property(np, "dmas", NULL)) {
>>> +				atmel_port->use_dma_tx  = 1;
>>> +				atmel_port->use_pdc_tx  = 0;
>>> +			} else {
>>> +				atmel_port->use_dma_tx  = 0;
>>> +				atmel_port->use_pdc_tx  = 1;
>>> +			}
>>> +		} else {
>>> +			atmel_port->use_dma_tx  = 0;
>>> +			atmel_port->use_pdc_tx  = 0;
>>> +		}
>>> +
>>> +	} else {
>>> +		atmel_port->use_pdc_rx  = pdata->use_dma_rx;
>>> +		atmel_port->use_pdc_tx  = pdata->use_dma_tx;
>>> +		atmel_port->use_dma_rx  = 0;
>>> +		atmel_port->use_dma_tx  = 0;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void atmel_init_rs485(struct atmel_uart_port *atmel_port,
>>> +				struct platform_device *pdev)
>>> +{
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>>> +
>>> +	if (np) {
>>> +		u32 rs485_delay[2];
>>> +		/* rs485 properties */
>>> +		if (of_property_read_u32_array(np, "rs485-rts-delay",
>>> +					rs485_delay, 2) == 0) {
>>> +			struct serial_rs485 *rs485conf = &atmel_port->rs485;
>>> +
>>> +			rs485conf->delay_rts_before_send = rs485_delay[0];
>>> +			rs485conf->delay_rts_after_send = rs485_delay[1];
>>> +			rs485conf->flags = 0;
>>> +
>>> +		if (of_get_property(np, "rs485-rx-during-tx", NULL))
>>> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
>>> +
>>> +		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
>>> +								NULL))
>>> +			rs485conf->flags |= SER_RS485_ENABLED;
>>> +		}
>>> +	} else {
>>> +		atmel_port->rs485       = pdata->rs485;
>>> +	}
>>> +
>>> +}
>>> +
>>>  static void atmel_set_ops(struct uart_port *port)
>>>  {
>>>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>>> @@ -1409,6 +1483,7 @@ static void atmel_set_ops(struct uart_port *port)
>>>   */
>>>  static int atmel_startup(struct uart_port *port)
>>>  {
>>> +	struct platform_device *pdev = to_platform_device(port->dev);
>>>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>>>  	struct tty_struct *tty = port->state->port.tty;
>>>  	int retval;
>>> @@ -1433,6 +1508,8 @@ static int atmel_startup(struct uart_port *port)
>>>  	/*
>>>  	 * Initialize DMA (if necessary)
>>>  	 */
>>> +	atmel_init_property(atmel_port, pdev);
>>> +
>>>  	if (atmel_port->prepare_rx) {
>>>  		retval = atmel_port->prepare_rx(port);
>>>  		if (retval < 0)
>>> @@ -1878,55 +1955,6 @@ static struct uart_ops atmel_pops = {
>>>  #endif
>>>  };
>>>  
>>> -static void atmel_of_init_port(struct atmel_uart_port *atmel_port,
>>> -					 struct device_node *np)
>>> -{
>>> -	u32 rs485_delay[2];
>>> -
>>> -	/* DMA/PDC usage specification */
>>> -	if (of_get_property(np, "atmel,use-dma-rx", NULL)) {
>>> -		if (of_get_property(np, "dmas", NULL)) {
>>> -			atmel_port->use_dma_rx	= 1;
>>> -			atmel_port->use_pdc_rx	= 0;
>>> -		} else {
>>> -			atmel_port->use_dma_rx	= 0;
>>> -			atmel_port->use_pdc_rx	= 1;
>>> -		}
>>> -	} else {
>>> -		atmel_port->use_dma_rx	= 0;
>>> -		atmel_port->use_pdc_rx	= 0;
>>> -	}
>>> -
>>> -	if (of_get_property(np, "atmel,use-dma-tx", NULL)) {
>>> -		if (of_get_property(np, "dmas", NULL)) {
>>> -			atmel_port->use_dma_tx	= 1;
>>> -			atmel_port->use_pdc_tx	= 0;
>>> -		} else {
>>> -			atmel_port->use_dma_tx	= 0;
>>> -			atmel_port->use_pdc_tx	= 1;
>>> -		}
>>> -	} else {
>>> -		atmel_port->use_dma_tx	= 0;
>>> -		atmel_port->use_pdc_tx	= 0;
>>> -	}
>>> -
>>> -	/* rs485 properties */
>>> -	if (of_property_read_u32_array(np, "rs485-rts-delay",
>>> -					    rs485_delay, 2) == 0) {
>>> -		struct serial_rs485 *rs485conf = &atmel_port->rs485;
>>> -
>>> -		rs485conf->delay_rts_before_send = rs485_delay[0];
>>> -		rs485conf->delay_rts_after_send = rs485_delay[1];
>>> -		rs485conf->flags = 0;
>>> -
>>> -		if (of_get_property(np, "rs485-rx-during-tx", NULL))
>>> -			rs485conf->flags |= SER_RS485_RX_DURING_TX;
>>> -
>>> -		if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
>>> -			rs485conf->flags |= SER_RS485_ENABLED;
>>> -	}
>>> -}
>>> -
>>>  /*
>>>   * Configure the port from the platform device resource info.
>>>   */
>>> @@ -1936,17 +1964,10 @@ static void atmel_init_port(struct atmel_uart_port *atmel_port,
>>>  	struct uart_port *port = &atmel_port->uart;
>>>  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
>>>  
>>> -	if (pdev->dev.of_node) {
>>> -		atmel_of_init_port(atmel_port, pdev->dev.of_node);
>>> -	} else {
>>> -		atmel_port->use_pdc_rx	= pdata->use_dma_rx;
>>> -		atmel_port->use_pdc_tx	= pdata->use_dma_tx;
>>> -		atmel_port->use_dma_rx	= 0;
>>> -		atmel_port->use_dma_tx	= 0;
>>> -		atmel_port->rs485	= pdata->rs485;
>>> -	}
>>> +	if (!atmel_init_property(atmel_port, pdev))
>>> +		atmel_set_ops(port);
>>>  
>>> -	atmel_set_ops(port);
>>> +	atmel_init_rs485(atmel_port, pdev);
>>>  
>>>  	port->iotype		= UPIO_MEM;
>>>  	port->flags		= UPF_BOOT_AUTOCONF;
>>> -- 
>>> 1.7.9.5
>>> 
>>> 
> 
