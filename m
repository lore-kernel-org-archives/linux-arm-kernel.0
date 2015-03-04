From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 04 Mar 2015 16:33:51 -0500
Subject: [PATCH v5] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <CAL_Jsq+1ayOsYH+dyexnyiLTuW4=ervVFdU6HL7GLtKQGCt9Ew@mail.gmail.com>
References: <1424969811-11197-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1424969811-11197-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <CAL_Jsq+1ayOsYH+dyexnyiLTuW4=ervVFdU6HL7GLtKQGCt9Ew@mail.gmail.com>
Message-ID: <54F77A3F.5000300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 11:13 AM, Rob Herring wrote:
> On Thu, Feb 26, 2015 at 10:56 AM, Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
>> Fix a race condition that happens when device_initcall(pl011_dma_initicall)
>> is executed before all the devices have been probed - this issue was observed on
>> an hisi_6220 SoC (HiKey board from Linaro).
>>
>> The deferred driver probing framework relies on late_initcall to trigger
>> deferred probes so it is just possible that, even with a valid DMA driver ready
>> to be loaded, we fail to synchronize with it.
>>
>> The proposed implementation delays probing of the DMA until the uart device is
>> opened. As hw_init is invoked on port startup and port resume - but the DMA
>> probe is only required once - we avoid calling multiple times using a new field
>> in uart_amba_port to track this scenario.
>>
>> This commit allows for subsequent attempts to associate an external DMA if the
>> DMA driver was deferred at UART hw_init time.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> You need to send this to Greg KH and linux-serial if you want it applied.
>
> [...]

ok.

>
>> @@ -261,10 +262,11 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
>>         }
>>  }
>>
>> -static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
>> +static void pl011_dma_probe(struct uart_amba_port *uap)
>>  {
>>         /* DMA is the sole user of the platform data right now */
>> -       struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
>> +       struct device *const uap_dev = uap->port.dev;
> Call this "dev" so you don't have all the needless renaming.
>
> With that change:
>
> Reviewed-by: Rob Herring <robh@kernel.org>


OK.

while I am at it, you initially suggested to do the probe in pl011_dma_startup.

Instead I probed from pl011_hwinit since it matched the original behaviour of
also probing the DMA when CONFIG_CONSOLE_POLL was enabled.
However, since the CONFIG_CONSOLE_POLL implementation for the amba-pl011 doesn't
use the DMA it actually doesn't help to keep it in pl011_hwinit.

is it ok with you if I move this to pl011_dma_startup as you initially suggested?


>
>> +       struct amba_pl011_data *plat = dev_get_platdata(uap_dev);
>>         struct dma_slave_config tx_conf = {
>>                 .dst_addr = uap->port.mapbase + UART01x_DR,
>>                 .dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
>> @@ -275,12 +277,19 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>         struct dma_chan *chan;
>>         dma_cap_mask_t mask;
>>
>> -       chan = dma_request_slave_channel(dev, "tx");
>> +       uap->dma_probed = true;
>> +
>> +       chan = dma_request_slave_channel_reason(uap_dev, "tx");
>> +       if (IS_ERR(chan)) {
>> +               if (PTR_ERR(chan) == -EPROBE_DEFER) {
>> +                       dev_info(uap_dev, "DMA driver not ready\n");
>> +                       uap->dma_probed = false;
>> +                       return;
>> +               }
>>
>> -       if (!chan) {
>>                 /* We need platform data */
>>                 if (!plat || !plat->dma_filter) {
>> -                       dev_info(uap->port.dev, "no DMA platform data\n");
>> +                       dev_info(uap_dev, "no DMA platform data\n");
>>                         return;
>>                 }amba-pl011.c
>>
>> @@ -291,7 +300,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>                 chan = dma_request_channel(mask, plat->dma_filter,
>>                                                 plat->dma_tx_param);
>>                 if (!chan) {
>> -                       dev_err(uap->port.dev, "no TX DMA channel!\n");
>> +                       dev_err(uap_dev, "no TX DMA channel!\n");
>>                         return;
>>                 }
>>         }
>> @@ -299,17 +308,17 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>         dmaengine_slave_config(chan, &tx_conf);
>>         uap->dmatx.chan = chan;
>>
>> -       dev_info(uap->port.dev, "DMA channel TX %s\n",
>> +       dev_info(uap_dev, "DMA channel TX %s\n",
>>                  dma_chan_name(uap->dmatx.chan));
>>
>>         /* Optionally make use of an RX channel as well */
>> -       chan = dma_request_slave_channel(dev, "rx");
>> +       chan = dma_request_slave_channel(uap_dev, "rx");
>>
>>         if (!chan && plat->dma_rx_param) {
>>                 chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
>>
>>                 if (!chan) {
>> -                       dev_err(uap->port.dev, "no RX DMA channel!\n");
>> +                       dev_err(uap_dev, "no RX DMA channel!\n");
>>                         return;
>>                 }
>>         }
>> @@ -333,7 +342,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>                         if (caps.residue_granularity ==
>>                                         DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
>>                                 dma_release_channel(chan);
>> -                               dev_info(uap->port.dev,
>> +                               dev_info(uap_dev,
>>                                         "RX DMA disabled - no residue processing\n");
>>                                 return;
>>                         }
>> @@ -362,75 +371,29 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>                                         plat->dma_rx_poll_timeout;
>>                         else
>>                                 uap->dmarx.poll_timeout = 3000;
>> -               } else if (!plat && dev->of_node) {
>> +               } else if (!plat && uap_dev->of_node) {
>>                         uap->dmarx.auto_poll_rate = of_property_read_bool(
>> -                                               dev->of_node, "auto-poll");
>> +                                               uap_dev->of_node, "auto-poll");
>>                         if (uap->dmarx.auto_poll_rate) {
>>                                 u32 x;
>>
>> -                               if (0 == of_property_read_u32(dev->of_node,
>> +                               if (0 == of_property_read_u32(uap_dev->of_node,
>>                                                 "poll-rate-ms", &x))
>>                                         uap->dmarx.poll_rate = x;
>>                                 else
>>                                         uap->dmarx.poll_rate = 100;
>> -                               if (0 == of_property_read_u32(dev->of_node,
>> +                               if (0 == of_property_read_u32(uap_dev->of_node,
>>                                                 "poll-timeout-ms", &x))
>>                                         uap->dmarx.poll_timeout = x;
>>                                 else
>>                                         uap->dmarx.poll_timeout = 3000;
>>                         }
>>                 }
>> -               dev_info(uap->port.dev, "DMA channel RX %s\n",
>> +               dev_info(uap_dev, "DMA channel RX %s\n",
>>                          dma_chan_name(uap->dmarx.chan));
>>         }
>>  }
>>
>> -#ifndef MODULE
>> -/*
>> - * Stack up the UARTs and let the above initcall be done at device
>> - * initcall time, because the serial driver is called as an arch
>> - * initcall, and at this time the DMA subsystem is not yet registered.
>> - * At this point the driver will switch over to using DMA where desired.
>> - */
>> -struct dma_uap {
>> -       struct list_head node;
>> -       struct uart_amba_port *uap;
>> -       struct device *dev;
>> -};
>> -
>> -static LIST_HEAD(pl011_dma_uarts);
>> -
>> -static int __init pl011_dma_initcall(void)
>> -{
>> -       struct list_head *node, *tmp;
>> -
>> -       list_for_each_safe(node, tmp, &pl011_dma_uarts) {
>> -               struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
>> -               pl011_dma_probe_initcall(dmau->dev, dmau->uap);
>> -               list_del(node);
>> -               kfree(dmau);
>> -       }
>> -       return 0;
>> -}
>> -
>> -device_initcall(pl011_dma_initcall);
>> -
>> -static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>> -{
>> -       struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
>> -       if (dmau) {
>> -               dmau->uap = uap;
>> -               dmau->dev = dev;
>> -               list_add_tail(&dmau->node, &pl011_dma_uarts);
>> -       }
>> -}
>> -#else
>> -static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>> -{
>> -       pl011_dma_probe_initcall(dev, uap);
>> -}
>> -#endif
>> -
>>  static void pl011_dma_remove(struct uart_amba_port *uap)
>>  {
>>         /* TODO: remove the initcall if it has not yet executed */
>> @@ -1142,7 +1105,7 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>>
>>  #else
>>  /* Blank functions if the DMA engine is not available */
>> -static inline void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>> +static inline void pl011_dma_probe(struct uart_amba_port *uap)
>>  {
>>  }
>>
>> @@ -1548,6 +1511,9 @@ static int pl011_hwinit(struct uart_port *port)
>>         uap->im = readw(uap->port.membase + UART011_IMSC);
>>         writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
>>
>> +       if (!uap->dma_probed)
>> +               pl011_dma_probe(uap);
>> +
>>         if (dev_get_platdata(uap->port.dev)) {
>>                 struct amba_pl011_data *plat;
>>
>> @@ -2218,7 +2184,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>         uap->port.ops = &amba_pl011_pops;
>>         uap->port.flags = UPF_BOOT_AUTOCONF;
>>         uap->port.line = i;
>> -       pl011_dma_probe(&dev->dev, uap);
>>
>>         /* Ensure interrupts from this UART are masked and cleared */
>>         writew(0, uap->port.membase + UART011_IMSC);
>> @@ -2233,7 +2198,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>         if (!amba_reg.state) {
>>                 ret = uart_register_driver(&amba_reg);
>>                 if (ret < 0) {
>> -                       pr_err("Failed to register AMBA-PL011 driver\n");
>> +                       dev_err(&dev->dev,
>> +                               "Failed to register AMBA-PL011 driver\n");
>>                         return ret;
>>                 }
>>         }
>> @@ -2242,7 +2208,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>         if (ret) {
>>                 amba_ports[i] = NULL;
>>                 uart_unregister_driver(&amba_reg);
>> -               pl011_dma_remove(uap);
>>         }
>>
>>         return ret;
>> --
>> 1.9.1
>>
