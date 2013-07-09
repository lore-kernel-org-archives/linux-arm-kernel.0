From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 9 Jul 2013 11:57:04 +0200
Subject: [PATCH 2/7] serial: at91: add tx dma support
In-Reply-To: <1373351626-30143-3-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-3-git-send-email-elen.song@atmel.com>
Message-ID: <20130709095704.GE4013@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 02:33:41PM +0800, Elen Song wrote:

[...]
  
> @@ -977,6 +1172,8 @@ static int atmel_startup(struct uart_port *port)
>  		pdc->ofs = 0;
>  	}
>  
> +	atmel_tx_request_dma(atmel_port);
> +
>  	/*
>  	 * If there is a specific "open" function (to register
>  	 * control line interrupts)

Here we can have both use_pdc_tx and use_dma_tx set to true. To avoid this, we
can do:

if (atmel_use_pdc_tx(port)) {

} else {
	atmel_tx_request_dma(atmel_port);
}

or force use_pdc_tx to 0 in atmel_tx_request_dma function when we set
use_dma_tx to 1.

I prefer the second one since using dma has a higher priority than using pdc
contrary to the first one.


Regards

Ludovic
