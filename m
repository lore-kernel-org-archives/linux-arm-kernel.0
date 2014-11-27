From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Thu, 27 Nov 2014 19:59:46 +0800
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <54761BFC.4020705@ti.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-6-git-send-email-chunyan.zhang@spreadtrum.com>
 <54761BFC.4020705@ti.com>
Message-ID: <CAAfSe-uMqy7zwiEK+nDoMPw_oni8L_vq7oW2Me5AY8z8KGpjwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-27 2:29 GMT+08:00 Murali Karicheri <m-karicheri2@ti.com>:
> On 11/25/2014 07:16 AM, Chunyan Zhang wrote:
>>
>> Add a full sc9836-uart driver for SC9836 SoC which is based on the

>> +#include<linux/clk.h>
>
> How about sorting this includes? asm/irq.h go first followed linux/ in
> alphabatical order?

>> +static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
>> +{
>> +       struct uart_port *port = (struct uart_port *)dev_id;
>> +       u32 ims;
>> +
>> +       ims = serial_in(port, SPRD_IMSR);
>> +
>> +       serial_out(port, SPRD_ICLR, ~0);
>> +
>> +       if (ims&  (SPRD_IMSR_RX_FIFO_FULL |
>> +               SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT)) {
>> +               sprd_rx(irq, port);
>> +       }
>> +       if (ims&  SPRD_IMSR_TX_FIFO_EMPTY)
>> +               sprd_tx(irq, port);
>> +
>> +       return IRQ_HANDLED;
>
> You are always returning IRQ_HANDLED and this is registered as a SHARED irq.
> Is there a chance this handler is called and the irq event doesn't
> belong to this device?
>
> Murali

You are right, this is not a SHARED irq. I'll pass 0 for irqflags when
called 'devm_request_irq' in the next version patch.

Thank you,
Chunyan
