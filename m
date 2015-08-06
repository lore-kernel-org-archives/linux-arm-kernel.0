From: raghumag@gmail.com (raghu MG)
Date: Thu, 6 Aug 2015 22:28:12 +0530
Subject: Armadaxp GPIO interrupts
In-Reply-To: <20150806132926.GB19896@lunn.ch>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
 <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
 <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
 <20150805162155.GE32760@lunn.ch>
 <CAG1O52WPFfm+XGk01iUVWLu=-Dm7bcDVmhv3P8iQDH+HHjsLUA@mail.gmail.com>
 <20150806132926.GB19896@lunn.ch>
Message-ID: <CAG1O52XUyPkgTTRKftujZBNK1=n6GBdWgBg_kq6SsC5XMaeU3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok,I think I need to understand more about this gpio driver.

As you said its registering chained handler,but why are they(IRQs) not
visible in cat /proc/interrupts.
What could be the reason.?

Do I need to further initialize marvell GPIO registers to trigger
these events. The driver is unmasking all interrupts in probe function
                writel_relaxed(0, mvchip->membase + GPIO_EDGE_CAUSE_OFF);
                writel_relaxed(0, mvchip->membase + GPIO_EDGE_MASK_OFF);
                writel_relaxed(0, mvchip->membase + GPIO_LEVEL_MASK_OFF);


Do I need to change the polarity in polarity register to suit the
board requirements in probe function.

I will try this in the morning.


Regards
Raghu

On Thu, Aug 6, 2015 at 6:59 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> mvebu_gpio_irq_handler is only called if I register a another handler
>> at irq=82/83/84/85/87/88/89/90/92. I am registering this handler using
>> minimal kernel module.
>
> This is totally wrong. The gpio driver needs these interrupts, and
> will register a chained interrupt handle for these. Don't mess around
> with them. Here is the code in the driver:
>
>         /* Setup the interrupt handlers. Each chip can have up to 4
>          * interrupt handlers, with each handler dealing with 8 GPIO
>          * pins. */
>         for (i = 0; i < 4; i++) {
>                 int irq = platform_get_irq(pdev, i);
>
>                 if (irq < 0)
>                         continue;
>                 irq_set_handler_data(irq, mvchip);
>                 irq_set_chained_handler(irq, mvebu_gpio_irq_handler);
>         }
>
>         Andrew
