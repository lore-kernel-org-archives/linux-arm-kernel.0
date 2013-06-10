From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 10 Jun 2013 11:45:59 +0000
Subject: [PATCH 09/11] gpio: davinci: DT changes for driver
In-Reply-To: <CACRpkdZH4w_-K617QNCo0Z9jH7LKQyjzoG9K-dj4UbN3h5Bcxw@mail.gmail.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-10-git-send-email-avinashphilip@ti.com>
 <CACRpkdZH4w_-K617QNCo0Z9jH7LKQyjzoG9K-dj4UbN3h5Bcxw@mail.gmail.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAD9928@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 23:55:22, Linus Walleij wrote:
> On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:
> 
> (...)
> > +- interrupts: The Starting IRQ number for GPIO
> > +- intc_irq_num: The number of IRQs supported by the Interrupt Controller
> (...)
> 
> No this is not how you pass a number of IRQs in the device tree.
> 
> "interrupts" is an array. Pass every interrupt here for a full
> resolution of the IRQs.

Correct. I will change.

> 
> Further this looks fishy:
> 
> + interrupts = <42>;
> 
> Usually you pass flags with the IRQs, I would rather have expected
> an array like this:
> 
> interrupts = < 90 0x4 96 0x4 14 0x4 15 0x4 79 0x4>;
> 
> 0x4 is IRQ_TYPE_LEVEL_HIGH, you can use the dts
> #include <dt-bindings/interrupt-controller/irq.h> and
> define that symbolically.
> 
> Doesn't the DaVinci IRQ controller support *any* IRQ flags?

I wasn't sure about it.
But from davinci GPIO driver perspective, GPIO pins are
configured as edge sensitive. So IRQ_TYPE_EDGE_BOTH can be used.

So I will correct Documentation and update DT nodes in next version.

> 
> Since the driver code is not reading out the interrupts but
> (I guess?) falling back to platform data IRQ assignment,
> this seems wrong.

Driver code reads "Starting IRQ number for GPIO" from platform resource
See [PATCH 03/11] gpio: davinci: Modify to platform driver.
Driver requires only starting offset of gpio irq number. GPIO interrupt
Number expected in sequential order for davinci GPIO.

Thanks
Avinash

 
> Yours,
> Linus Walleij
> 
