From: zhoujiewu@gmail.com (zhoujie wu)
Date: Mon, 23 Sep 2013 15:10:30 +0800
Subject: question about clk notifier in common clock tree
In-Reply-To: <CAPtuhTgvOca7V0a4+fEEBX2ad-FzPQWyuu7zBBNkhaja7rgUGA@mail.gmail.com>
References: <CAAXpJNvPvqr9+Zu1dUMssa0oorEH7Yc=so93i0UJjdNXKyh45A@mail.gmail.com>
 <CAPtuhTgvOca7V0a4+fEEBX2ad-FzPQWyuu7zBBNkhaja7rgUGA@mail.gmail.com>
Message-ID: <CAAXpJNvXvPpMgdZk-z0sWKwAeGrR-J2FcZmJc57ytQnpGvPDvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/9/18 Mike Turquette <mturquette@linaro.org>:
> On Tue, Sep 17, 2013 at 7:17 PM, zhoujie wu <zhoujiewu@gmail.com> wrote:
>> Hi Mike,
>>
>> Now in our platform, we are using clk notifer to adjust voltage before
>> clock rate change or after rate change.
>>
>> But for some clock modules, it even have to adjust voltage when clock
>> enable and disable.
>> For example, when it is working(clock enabled), it requires voltage
>> 1.2V. When it finished its work, it could release it's voltage
>> requirement.
>> Do you think if it is ok we also send out notifier in __clk_prepare
>> and __clk_unprepare as below?
>
> This has come up in the past and my position has been that run-time PM
> should enable regulators when turning on a module or device. One
> question: what is the regulator consumer in your case? Is it the clock
> consuming the regulator or is the device/module consuming the
> regulator? Usually it is the device and not the actual clock that
> needs the regulator to be enabled before it can be used and this is
> best left up to runtime PM.

Hi Mike,
Actually, it is the device running at special clock frequency is
consuming the regulator. Still has relationship has clock frequency.
That is why i want to bind its voltage request(notifier) with clock
enable/disable operation.

For example, GPU in the system has below voltage requirement depend on
the GPU frequency.

GPU frequency  Required voltage
0M                     0V
156M                 1.1V
312M                 1.2V
416M                 1.3V

Now GPU is working at 416M, once it get its work done, GPU will
disable its clock and at the same time release its voltage
requirement.
Later GPU has new work to do, it will enable its clock(rate is still
416M, so we have to increase the voltage before enabling the clock),
and start working.

>
> Regards,
> Mike
>
>>
>> Thanks.
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 54a191c..2f64f1e 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -34,6 +34,9 @@ static HLIST_HEAD(clk_root_list);
>>  static HLIST_HEAD(clk_orphan_list);
>>  static LIST_HEAD(clk_notifier_list);
>>
>> +static int __clk_notify(struct clk *clk, unsigned long msg,
>> + unsigned long old_rate, unsigned long new_rate);
>> +
>>  /***           locking             ***/
>>  static void clk_prepare_lock(void)
>>  {
>> @@ -697,6 +700,9 @@ void __clk_unprepare(struct clk *clk)
>>   if (clk->ops->unprepare)
>>   clk->ops->unprepare(clk->hw);
>>
>> + /* send out notifier for dvfs */
>> + __clk_notify(clk, POST_RATE_CHANGE, clk->rate, 0);
>> +
>>   __clk_unprepare(clk->parent);
>>  }
>>
>> @@ -738,6 +744,9 @@ int __clk_prepare(struct clk *clk)
>>   return ret;
>>   }
>>   }
>> +
>> + /* send out notifier for dvfs */
>> + __clk_notify(clk, PRE_RATE_CHANGE, 0, clk->rate);
>>   }
>>
>>   clk->prepare_count++;
>>
>>
>> --
>> Zhoujie Wu



-- 
Zhoujie Wu
???
