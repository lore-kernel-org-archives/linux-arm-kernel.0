From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Mon, 23 Feb 2015 22:33:46 -0500
Subject: [PATCH] drivers/tty: amba-pl011: defer driver probing if external
 dma is not ready.
In-Reply-To: <CAL_JsqJbGCOCCiMn6ok1j=R2EUF7YYRP4Si06wh3Vg0OnuXvag@mail.gmail.com>
References: <1424722599-9215-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <CAL_JsqJbGCOCCiMn6ok1j=R2EUF7YYRP4Si06wh3Vg0OnuXvag@mail.gmail.com>
Message-ID: <54EBF11A.1030806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2015 03:58 PM, Rob Herring wrote:
> +spear maintainers
>
> On Mon, Feb 23, 2015 at 2:16 PM, Jorge Ramirez-Ortiz
> <jorge.ramirez-ortiz@linaro.org> wrote:
>> This patch addresses a race condition that happens when
>> device_initcall(pl011_dma_initicall) is executed before all the devices have been
>> probed - this issue was observed on an hisi_6220 SoC (HiKey board from Linaro).
>>
>> The proposed implementation uses deferred driver probing to wait for the DMA
>> controller to be registered.
> This is going to break implementations using platform data rather than
> DT for the DMA channel resolving. The only user is spear3xx. Ideally,
> we should fix spear3xx to use DT for the DMA channels. That would
> mainly require making the pl08x driver DT enabled and dts updates.
>
> To fix this in the pl011 driver, you are going to need to split up the
> DT and platform data paths keeping the list used for the platform
> data. The platform data is only used for DMA and is mutually exclusive
> with DT, so in probe you can do something like this:
>
> if (pdata)
>   pdata_dma_probe();
> else if (of_dma_probe() == -EPROBE_DEFER)
>   return -EPROBE_DEFER;

thanks Rob. Ok fix on its way. sorry about this.

>
> Rob
>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  drivers/tty/serial/amba-pl011.c | 70 +++++++++++------------------------------
>>  1 file changed, 18 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 8d94c19..40219e5 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -29,6 +29,7 @@
>>   * and hooked into this driver.
>>   */
>>
>> +#define pr_fmt(fmt) "amba-pl011: "fmt
>>
>>  #if defined(CONFIG_SERIAL_AMBA_PL011_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
>>  #define SUPPORT_SYSRQ
>> @@ -261,7 +262,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
>>         }
>>  }
>>
>> -static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
>> +static int pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>>  {
>>         /* DMA is the sole user of the platform data right now */
>>         struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
>> @@ -275,13 +276,17 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>         struct dma_chan *chan;
>>         dma_cap_mask_t mask;
>>
>> -       chan = dma_request_slave_channel(dev, "tx");
>> +       chan = dma_request_slave_channel_reason(dev, "tx");
>> +       if (IS_ERR(chan)) {
>> +
>> +               /* the dma driver has not been initialized yet */
>> +               if (PTR_ERR(chan) == -EPROBE_DEFER)
>> +                       return -EPROBE_DEFER;
>>
>> -       if (!chan) {
>>                 /* We need platform data */
>>                 if (!plat || !plat->dma_filter) {
>>                         dev_info(uap->port.dev, "no DMA platform data\n");
>> -                       return;
>> +                       return 0;
>>                 }
>>
>>                 /* Try to acquire a generic DMA engine slave TX channel */
>> @@ -292,7 +297,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>                                                 plat->dma_tx_param);
>>                 if (!chan) {
>>                         dev_err(uap->port.dev, "no TX DMA channel!\n");
>> -                       return;
>> +                       return 0;
>>                 }
>>         }
>>
>> @@ -310,7 +315,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>
>>                 if (!chan) {
>>                         dev_err(uap->port.dev, "no RX DMA channel!\n");
>> -                       return;
>> +                       return 0;
>>                 }
>>         }
>>
>> @@ -383,54 +388,10 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>>                 dev_info(uap->port.dev, "DMA channel RX %s\n",
>>                          dma_chan_name(uap->dmarx.chan));
>>         }
>> -}
>> -
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
>>
>> -       list_for_each_safe(node, tmp, &pl011_dma_uarts) {
>> -               struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
>> -               pl011_dma_probe_initcall(dmau->dev, dmau->uap);
>> -               list_del(node);
>> -               kfree(dmau);
>> -       }
>>         return 0;
>>  }
>>
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
>> @@ -1142,8 +1103,9 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>>
>>  #else
>>  /* Blank functions if the DMA engine is not available */
>> -static inline void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>> +static int pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
>>  {
>> +       return 0;
>>  }
>>
>>  static inline void pl011_dma_remove(struct uart_amba_port *uap)
>> @@ -2218,7 +2180,11 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>         uap->port.ops = &amba_pl011_pops;
>>         uap->port.flags = UPF_BOOT_AUTOCONF;
>>         uap->port.line = i;
>> -       pl011_dma_probe(&dev->dev, uap);
>> +       ret = pl011_dma_probe(&dev->dev, uap);
>> +       if (ret) {
>> +               devm_kfree(&dev->dev, uap);
>> +               return ret;
>> +       }
>>
>>         /* Ensure interrupts from this UART are masked and cleared */
>>         writew(0, uap->port.membase + UART011_IMSC);
>> --
>> 1.9.1
>>
