From: raghumag@gmail.com (raghu MG)
Date: Wed, 5 Aug 2015 20:32:57 +0530
Subject: Armadaxp GPIO interrupts
In-Reply-To: <20150804153439.GA28673@lunn.ch>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
Message-ID: <CAG1O52XtYJho9M4TggtvzdY8HnXhpjkX79FFKRQMyyw=KhgSgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

The issue I found was  irq_alloc_descs is called twice
1st time inside   mvebu_gpio_probe & 2nd time inside irq_domain_add_simple.

The warning is thrown up when irq_alloc_descs is called 2nd
time(irq_domain_add_simple) & bitmap_find_next_zero_area gives new
value of start which is not equal to irq & the following condition
returns with error.

irq_alloc_descs(....)
.................
....................
..............
start = bitmap_find_next_zero_area(
allocated_irqs, IRQ_BITMAP_BITS,
                                           from, cnt, 0);
ret=-EEXIST;
if (irq >=0 && start != irq){
                goto err;
        }
...........................
................
err:
       mutex_unlock(&sparse_irq_lock);
        return ret;


I could bypass the error/warning by giving calling
irq_domain_add_simple(np, mvchip->chip.ngpio,
                                               0,
                                               &irq_domain_simple_ops,
                                               mvchip);
I  passed zero instead of mvchip->irqbase as first_irq .
The warning is not appearing.& I think driver is registered in kernel.

But driver & gpio entry is not found in /proc/interrupts.

The GPIO ISR is not getting invoked by driver.
But I wrote a simple module where I register simple handler & then
both mvebu_gpio_irq_handler & modules registered handler is called.

My doubt is whether the gpio-driver in the kernel needs bit more
tweaking to suit the board & devices connected to gpio.

I would appreciate bit of guidance here

On Tue, Aug 4, 2015 at 9:04 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Aug 04, 2015 at 08:52:17PM +0530, raghu MG wrote:
>> Hello,
>>
>> I am working on a card which as GPIOs connected to external I/O's. The
>> board consists of ARMADAXP 78460 host cpu.
>>
>> Board currently runs Linux-4.1 with modified  armada-xp-gp.dtb for ArmadaXP.
>> I enabled "orion-gpio" driver to initialize GPIOs as given in
>> armada-xp-mv78460.
>
> What kernel configuration are you using? Do you have the same problem
> with multi_v7_defconfig and mvebu_v7_defconfig?
>
>> The driver while initializing calls irq_domain_add_simple which throws up
>> following warning
>> "irq: Cannot allocate irq_descs @ IRQ47, assuming pre-allocated"
>> The warning repeats for next set(32-63  & 64-66).
>>
>> Also the GPIO IRQs are not getting listed in cat /proc/interrupts
>
> irq_domain_add_simple() returning an error is fatal for the probe. The
> driver will not be loaded, so more than interrupts will be missing,
> all the gpios will be missing.
>
>     Andrew
