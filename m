From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 24 Jun 2014 10:19:15 -0300
Subject: [PATCH 02/10] serial: 8250_dw: support DMA on the OF case
In-Reply-To: <CAGb2v676GgfHnR-XWdQCa-ecYtYRxePS1dgGL6QqbntUkBvi_g@mail.gmail.com>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
 <1402890635-12342-3-git-send-email-emilio@elopez.com.ar>
 <CAGb2v676GgfHnR-XWdQCa-ecYtYRxePS1dgGL6QqbntUkBvi_g@mail.gmail.com>
Message-ID: <53A97AD3.6060804@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 21/06/14 10:56, Chen-Yu Tsai escribi?:
> On Mon, Jun 16, 2014 at 11:50 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> Currently, DMA properties on the DT are ignored when using the 8250_dw
>> driver. With this patch, DMA will be used when available.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>>   drivers/tty/serial/8250/8250_dw.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index ed31135..f75c0bf 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -222,6 +222,8 @@ static int dw8250_probe_of(struct uart_port *p,
>>                             struct dw8250_data *data)
>>   {
>>          struct device_node      *np = p->dev->of_node;
>> +       struct uart_8250_port   *up = container_of(p, struct uart_8250_port,
>> +                                                  port);
>>          u32                     val;
>>          bool has_ucv = true;
>>
>> @@ -254,11 +256,14 @@ static int dw8250_probe_of(struct uart_port *p,
>>                  }
>>          }
>>          if (has_ucv)
>> -               dw8250_setup_port(container_of(p, struct uart_8250_port, port));
>> +               dw8250_setup_port(up);
>>
>>          if (!of_property_read_u32(np, "reg-shift", &val))
>>                  p->regshift = val;
>>
>> +       if (of_get_property(np, "dmas", NULL))
>> +               up->dma = &data->dma;
>> +
>
> I suggest adding a comment here. Looking just at the patch,
> it's not very intuitive. But otherwise the patch looks good.

Sure, I can do that

Thanks!

Emilio
