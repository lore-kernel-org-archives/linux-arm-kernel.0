From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Dec 2016 22:21:39 +0100
Subject: [PATCH v7 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn3sc1F8T_rbSTr6-wBNncNwObeK+c6=_Q0BMahDdHXxQA@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-3-git-send-email-cedric.madianga@gmail.com>
 <20161223090019.a3jkhpb3abgjqi55@pengutronix.de>
 <CAOAejn3sc1F8T_rbSTr6-wBNncNwObeK+c6=_Q0BMahDdHXxQA@mail.gmail.com>
Message-ID: <20161228212139.adkixdgvmtj2ukjs@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Cedric,

On Fri, Dec 23, 2016 at 01:41:15PM +0100, M'boumba Cedric Madianga wrote:
> > I don't understand why DUTY is required to reach 400 kHz. Given a parent
> > freq of 30 MHz, with CCR = 25 and DUTY = 0 we have:
> >
> >         t_high = 25 * 33.333 ns = 833.333 ns
> >         t_low = 2 * 25 * 33.333 ns = 1666.667 ns
> >
> > then t_high and t_low satisfy the i2c bus specification
> > (t_low > 1300 ns, t_high > 600 ns) and we have t_low + t_high = 2500 ns
> > = 1 / 400 kHz.
> >
> > Where is the error?
> Hum ok you are right. I was a bad interpretation of the datasheet.
> So now it is clearer. Thanks for that.
> I will correct and improve my comments in the V8.

The benefit of DUTY=1 is (I think) that you can reach 400 kHz also with
lower parent frequencies. And so it't probably sensible to make use of
it unconditionally for fast mode.

> >> + * So, in order to cover both SCL high/low with Duty = 1,
> >> + * CCR = 16 * SCL period * I2C CLK frequency
> >
> > I don't get that. Actually you need to use low + high, so
> > CCR = parentrate / (25 * 400 kHz), right?
> With your new inputs above, I think I could use a simpler implementation:
> CCR = scl_high_period * parent_rate
> with scl_high_period = 5 ?s in standard mode to reach 100khz
> and scl_high_period = 1 ?s in fast mode to reach 400khz with 1/2 or
> 16/9 duty cycle.
> So, I am wondering if I have to let the customer setting the duty
> cycle in the DT for example with "st,duty=0" or "st,duty=1" property
> (0 for 1/2 and 1 for 16/9).
> Or perhaps the best option it to use a default value. What is your
> feeling regarding this point ?

No, don't add a property to the device tree. Just take pencil and paper
and think a while about the right algorithm to choose the right register
settings.


> >> +     cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> >> +     freq = cr2 & STM32F4_I2C_CR2_FREQ_MASK;
> >> +
> >> +     if (i2c_dev->speed == STM32F4_I2C_SPEED_STANDARD)
> >> +             trise = freq + 1;
> >> +     else
> >> +             trise = freq * 300 / 1000 + 1;
> >
> > if freq is big such that freq * 300 overflows does this result in a
> > wrong result, or does the compiler optimize correctly?
> For sure the compiler will never exceeds u32 max value

If I compile
-------->8--------
#include <stdio.h>

void myfunc(unsigned freq)
{
	unsigned trise = freq * 300 / 1000 + 1;
	printf("trise = %u", trise);
}

-------->8--------

for arm with -O3 I get:

00000000 <myfunc>:
   0:	e3a01f4b 	mov	r1, #300	; 0x12c
   4:	e0010190 	mul	r1, r0, r1
   8:	e59f3010 	ldr	r3, [pc, #16]	; 20 <myfunc+0x20>
   c:	e59f0010 	ldr	r0, [pc, #16]	; 24 <myfunc+0x24>
  10:	e0812193 	umull	r2, r1, r3, r1
  14:	e1a01321 	lsr	r1, r1, #6
  18:	e2811001 	add	r1, r1, #1
  1c:	eafffffe 	b	0 <printf>
  20:	10624dd3 	.word	0x10624dd3
  24:	00000000 	.word	0x00000000

The mul instruction at offset 4 writes the least significant 32 bits of
300 * r0 to r1 and so doesn't handle overflow correctly.

> > This is still not really understandable.
> I have already added some comments from datasheet to explain the
> different cases.
> I don't see how I could be more understandable as it is clearly the
> hardware way of working...

You need to comment the check for the length, something like:

	/*
	 * To end the transfer correctly the foo bit has to be cleared
	 * already on the last but one byte to be transferred.
	 */

and bonus points if you can shrink the number of functions that check
for this stuff.

> > Just do:
> >
> >         if (status & STM32F4_I2C_SR1_SB) {
> >                 ...
> >         }
> >
> >         if (status & ...) {
> >
> >         }
> ok but I would prefer something like that:
> flag = status & possible_status
> if (flag & STM32F4_I2C_SR1_SB) {
> ...
> }
> 
> if (flag & ...) {
> }

Ok, if you really need possible_status.

> > Then it's obvious by reading the code in which order they are handled
> > without the need to check the definitions. Do you really need to jugle
> > with possible_status?
> I think I have to use possible_status as some events could occur
> whereas the corresponding interrupt is disabled.
> For example, for a 2 byte-reception, we don't have to take into accout
> RXNE event so the corresponding interrupt is disabled.

Is it possible to make it more obvious by doing:

	status = read_from_status_register() & read_from_interrupt_enable_register();

at a single place?

> >> +     /* Use __fls() to check error bits first */
> >> +     flag = __fls(status & possible_status);
> >> +
> >> +     switch (1 << flag) {
> >> +     case STM32F4_I2C_SR1_BERR:
> >> +             reg = i2c_dev->base + STM32F4_I2C_SR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_BERR);
> >> +             msg->result = -EIO;
> >> +             break;
> >> +
> >> +     case STM32F4_I2C_SR1_ARLO:
> >> +             reg = i2c_dev->base + STM32F4_I2C_SR1;
> >> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_ARLO);
> >> +             msg->result = -EAGAIN;
> >> +             break;
> >> +
> >> +     case STM32F4_I2C_SR1_AF:
> >> +             reg = i2c_dev->base + STM32F4_I2C_CR1;
> >> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> >> +             msg->result = -EIO;
> >> +             break;
> >> +
> >> +     default:
> >> +             dev_err(i2c_dev->dev,
> >> +                     "err it unhandled: status=0x%08x)\n", status);
> >> +             return IRQ_NONE;
> >> +     }
> >
> > You only check a single irq flag here.
> Yes only the first error could be reported to the i2c clients via
> msg->result that's why I don't check all errors.
> Moreover, as soon as an error occurs, the I2C device is reset.

The the "first" in the comment for __fls is misleading. Also do:

	if (status & MOST_IMPORTANT_ERROR) {
		...
	}

	if (status & SECOND_MOST_IMPORTANT_ERROR) {
		...
	}

(if you need including possible_status stuff).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
