From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:25:22 +0200
Subject: [PATCH 09/11] gpio: davinci: DT changes for driver
In-Reply-To: <1369206634-6778-10-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-10-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdZH4w_-K617QNCo0Z9jH7LKQyjzoG9K-dj4UbN3h5Bcxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

(...)
> +- interrupts: The Starting IRQ number for GPIO
> +- intc_irq_num: The number of IRQs supported by the Interrupt Controller
(...)

No this is not how you pass a number of IRQs in the device tree.

"interrupts" is an array. Pass every interrupt here for a full
resolution of the IRQs.

Further this looks fishy:

+ interrupts = <42>;

Usually you pass flags with the IRQs, I would rather have expected
an array like this:

interrupts = < 90 0x4 96 0x4 14 0x4 15 0x4 79 0x4>;

0x4 is IRQ_TYPE_LEVEL_HIGH, you can use the dts
#include <dt-bindings/interrupt-controller/irq.h> and
define that symbolically.

Doesn't the DaVinci IRQ controller support *any* IRQ flags?

Since the driver code is not reading out the interrupts but
(I guess?) falling back to platform data IRQ assignment,
this seems wrong.

Yours,
Linus Walleij
