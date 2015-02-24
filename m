From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 09:29:54 +0100
Subject: [PATCH] drivers/tty: amba-pl011: defer driver probing if external
 dma is not ready.
In-Reply-To: <1424749613-24765-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424749613-24765-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <17223432.USFTMF6ThS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 February 2015 22:46:53 Jorge Ramirez-Ortiz wrote:
> This patch addresses a race condition that happens when
> device_initcall(pl011_dma_initicall) is executed before all the devices have been
> probed - this issue was observed on an hisi_6220 SoC (HiKey board from Linaro).

How do you want to handle the case where there is a DMA channel in DT, but
no driver for it built into the kernel?

> @@ -275,15 +277,23 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>         struct dma_chan *chan;
>         dma_cap_mask_t mask;
>  
> -       chan = dma_request_slave_channel(dev, "tx");
> +       if (queue_dma_probe && plat && plat->dma_filter) {
> +               (*queue_dma_probe)(dev, uap);
> +               return 0;
> +       }
> +
> +       chan = dma_request_slave_channel_reason(dev, "tx");
> +       if (IS_ERR(chan)) {
> +
> +               /* the dma driver has not been initialized yet */
> +               if (PTR_ERR(chan) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
>  
> -       if (!chan) {
>                 /* We need platform data */
>                 if (!plat || !plat->dma_filter) {
>                         dev_info(uap->port.dev, "no DMA platform data\n");
> -                       return;
> +                       return 0;
>                 }

It would be nice to print the error code here now that you know it
and can tell the difference between no DMA channel being supplied
and the DMA channel from the DT properties being unavailable.

>                 /* Try to acquire a generic DMA engine slave TX channel */
>                 dma_cap_zero(mask);
>                 dma_cap_set(DMA_SLAVE, mask);
> @@ -292,7 +302,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>                                                 plat->dma_tx_param);
>                 if (!chan) {
>                         dev_err(uap->port.dev, "no TX DMA channel!\n");
> -                       return;
> +                       return 0;
>                 }
>         }
>  
> @@ -310,7 +320,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>  
>                 if (!chan) {
>                         dev_err(uap->port.dev, "no RX DMA channel!\n");
> -                       return;
> +                       return 0;
>                 }
>         }

I think the condition is wrong now that 'chan' contains a ERR_PTR
value in case of failure.

	Arnd
