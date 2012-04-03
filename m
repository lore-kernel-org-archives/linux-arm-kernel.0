From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 03 Apr 2012 22:02:12 +0530
Subject: [PATCHv5 17/18] I2C: OMAP: Do not set the XUDF if the underflow
 is not reached
In-Reply-To: <CAEgRx2ye7VLfTDmpLdsJE=6qKzDngd=zpGK3Xn8UR3moioXYQw@mail.gmail.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>	<1333468957-5999-18-git-send-email-shubhrajyoti@ti.com>
 <CAEgRx2ye7VLfTDmpLdsJE=6qKzDngd=zpGK3Xn8UR3moioXYQw@mail.gmail.com>
Message-ID: <4F7B260C.8070806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moiz,
Thanks for your review.

On Tuesday 03 April 2012 09:41 PM, Sonasath, Moiz wrote:
> Shubhrajyoti,
>
> On Tue, Apr 3, 2012 at 11:02 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>
>> Currently in the 1.153 errata handling while waiting for transmitter
>> underflow if NACK is got the XUDF flag is also set.
>> The flag is set after wait for the condition is over.
>>
>> Cc: Alexander Shishkin <virtuoso@slind.org>
>> Cc: Moiz Sonasath <m-sonasath@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 51576d6..a3160d1 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -763,7 +763,6 @@ static int errata_omap3_1p153(struct omap_i2c_dev
>> *dev, u16 *stat, int *err)
>>                if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
>>                        omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
>>                                                        OMAP_I2C_STAT_XDR));
>> -                       *err |= OMAP_I2C_STAT_XUDF;
>>
> I think we should set the NACK|AL err flag here instead??
On return of negative values there is a goto and  those flags are set there.
Did I miss something?

>
>>                        return -ETIMEDOUT;
>>                }
>>
>> @@ -776,6 +775,7 @@ static int errata_omap3_1p153(struct omap_i2c_dev
>> *dev, u16 *stat, int *err)
>>                return 0;
>>        }
>>
>> +       *err |= OMAP_I2C_STAT_XUDF;
>>
> Ack for this change.
Thanks.
