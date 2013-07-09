From: elen.song@atmel.com (elen.song)
Date: Tue, 9 Jul 2013 18:24:44 +0800
Subject: [PATCH 2/7] serial: at91: add tx dma support
In-Reply-To: <20130709095704.GE4013@ludovic.desroches@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-3-git-send-email-elen.song@atmel.com>
 <20130709095704.GE4013@ludovic.desroches@atmel.com>
Message-ID: <51DBE4EC.9090701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2013 5:57 PM, Ludovic Desroches wrote:
> On Tue, Jul 09, 2013 at 02:33:41PM +0800, Elen Song wrote:
>
> [...]
>    
>> @@ -977,6 +1172,8 @@ static int atmel_startup(struct uart_port *port)
>>   		pdc->ofs = 0;
>>   	}
>>   
>> +	atmel_tx_request_dma(atmel_port);
>> +
>>   	/*
>>   	 * If there is a specific "open" function (to register
>>   	 * control line interrupts)
> Here we can have both use_pdc_tx and use_dma_tx set to true. To avoid this, we
> can do:
>
> if (atmel_use_pdc_tx(port)) {
>
> } else {
> 	atmel_tx_request_dma(atmel_port);
> }
>
> or force use_pdc_tx to 0 in atmel_tx_request_dma function when we set
> use_dma_tx to 1.
>
> I prefer the second one since using dma has a higher priority than using pdc
> contrary to the first one.
>

Well ,yes, I have a better idea:

In atmel_startup:
Move "atmel_tx_request_dma" forward, just before "if 
(atmel_use_pdc_rx(port))",
meanwhile, force use_pdc_tx to 0  when request a dma channel.

In this case, we will not go into "if (atmel_use_pdc_rx(port))" when dma 
and pdc both enable and
dma have higher priority.
> Regards
>
> Ludovic
