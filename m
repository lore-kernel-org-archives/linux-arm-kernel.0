From: arno.steffen@googlemail.com (Arno Steffen)
Date: Wed, 9 Mar 2011 15:02:06 +0100
Subject: IRQ handler under load - slow response
Message-ID: <AANLkTinTCfrPPwP6ZnWZTWW8vmR4=Uaw+OmHK7b99-9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, maybe someone of you can give me hint what is wrong with my system.
I do have coded an irq-handler, handling changes at GPIO pins. The
response time (from changing the level at Input until output is set in
IRQ handler) is ok (<100?s)
Then I started with fork another process, which is under heavy load
(consumes a lot of CPU power). From now the response time was quite
jittering and edge changes within 10ms are handled not reliable, so it
misses some input changes.
It seems that IRQ is not responding so fast, probably because of some
kind of process switch???

In application I announce the IRQ with
    sigaction (SIGUSR1, &strSigAction, NULL);
on rising edges.

---------------

Inside the kernel driver the IRQ will be announced with:
  s32Status = request_irq((IH_GPIO_BASE + s32AppRecvGpioNum),
                                     GpioIrqHandler,
                                     0,
                                     "GPIOINTR",
                                     NULL);

The handler looks like

static irqreturn_t GpioIrqHandler (int irq, void *dev_id)
{
    int s32GpioNumber = 0 ;
    s32GpioNumber = irq - IH_GPIO_BASE;
    set_bit (s32GpioNumber , (volatile unsigned long *) &gsts32GpioIrqStatus);
    tasklet_schedule (&GpioTasklet);
    return IRQ_HANDLED;
}

DECLARE_TASKLET(GpioTasklet, GpioIntrTasklet, 0);

------------------

What have I done wrong? Do I have a chance to speed up the response
from changing inputs?

best regards
Steffen
