From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 25 Nov 2010 15:04:42 +0800
Subject: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
In-Reply-To: <4CEE05A4.6030201@compulab.co.il>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-7-git-send-email-bigeasy@linutronix.de>
	<AANLkTikvN+==eTkoh7CTQyN0mbfvPhH6Uh9NX5QW7WFx@mail.gmail.com>
	<AANLkTi=8Xy3M7QGO54nt_r0_12z3+o8G5fAqQmxkTH4o@mail.gmail.com>
	<4CEE05A4.6030201@compulab.co.il>
Message-ID: <AANLkTi=1CkW=uw8i53kQX8j1Lp5y-cPb72VrYkcTynJ2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 2:43 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> ?Hi,
>
> On 11/25/10 04:49, Haojian Zhuang wrote:
>> On Thu, Nov 25, 2010 at 10:30 AM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>>> On Thu, Nov 25, 2010 at 5:20 AM, Sebastian Andrzej Siewior
>>> <bigeasy@linutronix.de> wrote:
>>>> I haven't seen this (yet) during a normal transfer but starting
>>>> i2cdetect seems to hang the bus. On my Sodaville board, i2cdetect runs
>>>> fine on bus zero and runs into timeouts on bus one and two. The chip
>>>> never recovers from this condition. The following transfers hang as
>>>> well. The ISR_UB never disappears.
>>>> Issuing a chip reset fixes the timeout and following transfer succeed.
>>>>
>>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
>>>> ---
>>>> ?drivers/i2c/busses/i2c-pxa.c | ? 35 +++++++++++++++++++----------------
>>>> ?1 files changed, 19 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>>>> index bd4b885..1a48470 100644
>>>> --- a/drivers/i2c/busses/i2c-pxa.c
>>>> +++ b/drivers/i2c/busses/i2c-pxa.c
>>>> @@ -257,23 +257,7 @@ static void i2c_pxa_abort(struct pxa_i2c *i2c)
>>>> ? ? ? ? ? ? ? _ICR(i2c));
>>>> ?}
>>>>
>>>> -static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>>> -{
>>>> - ? ? ? int timeout = DEF_TIMEOUT;
>>>>
>>>> - ? ? ? while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
>>>> - ? ? ? ? ? ? ? if ((readl(_ISR(i2c)) & ISR_SAD) != 0)
>>>> - ? ? ? ? ? ? ? ? ? ? ? timeout += 4;
>>>> -
>>>> - ? ? ? ? ? ? ? msleep(2);
>>>> - ? ? ? ? ? ? ? show_state(i2c);
>>>> - ? ? ? }
>>>> -
>>>> - ? ? ? if (timeout < 0)
>>>> - ? ? ? ? ? ? ? show_state(i2c);
>>>> -
>>>> - ? ? ? return timeout < 0 ? I2C_RETRY : 0;
>>>> -}
>>>>
>>>> ?static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
>>>> ?{
>>>> @@ -425,6 +409,25 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>>> ? ? ? ?udelay(100);
>>>> ?}
>>>>
>>>> +static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>>> +{
>>>> + ? ? ? int timeout = DEF_TIMEOUT;
>>>> +
>>>> + ? ? ? while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
>>>> + ? ? ? ? ? ? ? if ((readl(_ISR(i2c)) & ISR_SAD) != 0)
>>>> + ? ? ? ? ? ? ? ? ? ? ? timeout += 4;
>>>> +
>>>> + ? ? ? ? ? ? ? msleep(2);
>>>> + ? ? ? ? ? ? ? show_state(i2c);
>>>> + ? ? ? }
>>>> +
>>>> + ? ? ? if (timeout < 0) {
>>>> + ? ? ? ? ? ? ? show_state(i2c);
>>>> + ? ? ? ? ? ? ? i2c_pxa_reset(i2c);
>>>> + ? ? ? }
>>> Even you reset I2C controller, it shouldn't help you since bus isn't
>>> free. I thinkt that you should reset I2C bus before you reseting I2C
>>> controller.
>>>
>> Excuse me that my previous comments are for PXA master mode.
>>
>> I think that you're focused on pxa working on slave mode. But if pxa
>> is working in master mode, it seems that we needn't reset I2C
>> controller since it doesn't help.
>
> As for PXA3xx, the Developer Manual states:
> "Software must ensure that the TWSI unit is not busy (ISR[UB] = 0)
> before it asserts a reset. Software must also ensure that the TWSI bus is idle (ISR[IBB] = 0)
> when the unit is enabled after reset."
>
> From my experience, in master mode resetting the controller
> does not help and if the bus is busy for too much time,
> there always was a h/w problem involved.
>

Yes, it's true. Actually there's some not smart firmware on some I2C
client devices that they may fetch wrong data as slave address and
command. There're two solutions for this bus busy issue. One is _not_
using this kind of client device. The other one is sending enough dump
clock to push these client device back to idle state.

>>>> +
>>>> + ? ? ? return timeout < 0 ? I2C_RETRY : 0;
>>>> +}
>>>>
>>>> ?#ifdef CONFIG_I2C_PXA_SLAVE
>>>> ?/*
>>>> --
>>>> 1.7.3.2
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Regards,
> Igor.
>
>
