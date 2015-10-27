From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 16:53:23 +0100
Subject: [PATCH] gpio: zynq: Implement irq_(request|release)_resources
In-Reply-To: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkda4QKEJvwkwGLS7OLTP8Nxu5W05tzbcFXA_FPnBsFtKhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 3:36 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> The driver uses runtime PM to leverage low power techniques. For
> use-cases using GPIO as interrupt the device needs to be in an
> appropriate state.
>
> Reported-by: John Linn <linnj@xilinx.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: John Linn <linnj@xilinx.com>

As pointed out by Grygorii in
commit aca82d1cbb49af34b69ecd4571a0fe48ad9247c1:

    The PM runtime API can't be used in atomic contex on -RT even if
    it's configured as irqsafe. As result, below error report can
    be seen when PM runtime API called from IRQ chip's callbacks
    irq_startup/irq_shutdown/irq_set_type, because they are
    protected by RAW spinlock:
(...)
    The IRQ chip interface defines only two callbacks which are executed in
    non-atomic contex - irq_bus_lock/irq_bus_sync_unlock, so lets move
    PM runtime calls there.

I.e. these calls are atomic context and it's just luck that it works
and this is fragile.

Can you please check if you can move it to
irq_bus_lock()/irq_sync_unlock()
like Grygorii does?

Yours,
Linus Walleij
