From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 7 Dec 2016 10:27:19 -0600
Subject: [PATCH] i2c: rk3x: keep i2c irq ON in suspend
In-Reply-To: <a6694d7d-6fca-e5ef-7bbd-9956562132a2@rock-chips.com>
References: <1480924979-13450-1-git-send-email-david.wu@rock-chips.com>
 <1737869.ycGphUXI8X@phil>
 <1d570232-af87-467e-e6f4-5b514d583a02@rock-chips.com>
 <CAD=FV=VgGy5hA4+7nvLs4NPNRuopak+bTW34S6X6S_vWgtnkjg@mail.gmail.com>
 <a6694d7d-6fca-e5ef-7bbd-9956562132a2@rock-chips.com>
Message-ID: <e34bab0d-b4b1-ff0d-3a27-c3701b8206c1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/2016 09:37 PM, David.Wu wrote:
> Hi Doug,
> 
> ? 2016/12/7 0:31, Doug Anderson ??:
>> Hi,
>>
>> On Tue, Dec 6, 2016 at 12:12 AM, David.Wu <david.wu@rock-chips.com>
>> wrote:
>>> Hi Heiko,
>>>
>>> ? 2016/12/5 18:54, Heiko Stuebner ??:
>>>>
>>>> Hi David,
>>>>
>>>> Am Montag, 5. Dezember 2016, 16:02:59 CET schrieb David Wu:
>>>>>
>>>>> During suspend there may still be some i2c access happening.
>>>>> And if we don't keep i2c irq ON, there may be i2c access timeout if
>>>>> i2c is in irq mode of operation.
>>>>
>>>>
>>>> can you describe the issue you're trying to fix a bit more please?
>>>
>>>
>>> Sometimes we could see the i2c timeout errors during suspend/resume,
>>> which
>>> makes the duration of suspend/resume too longer.
>>>
>>> [  484.171541] CPU4: Booted secondary processor [410fd082]
>>> [  485.172777] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
>>> [  486.172760] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
>>> [  487.172759] rk3x-i2c ff3c0000.i2c: timeout, ipd: 0x10, state: 1
>>> [  487.172840] cpu cpu4: _set_opp_voltage: failed to set voltage (800000
>>> 800000 800000 mV): -110
>>> [  487.172874] cpu cpu4: failed to set volt 800000
>>>
>>>>
>>>> I.e. I'd think the i2c-core does suspend i2c-client devices first,
>>>> so that
>>>> these should be able to finish up their ongoing transfers and not start
>>>> any
>>>> new ones instead?
>>>>
>>>> Your irq can still happen slightly after the system started going to
>>>> actually
>>>> sleep, so to me it looks like you just widened the window where irqs
>>>> can
>>>> be
>>>> handled. Especially as your irq could also just simply stem from the
>>>> start
>>>> state, so you cannot even be sure if your transaction actually is
>>>> finished.
>>>
>>>
>>> Okay, you are right. I want to give it a double insurance at first,
>>> but it
>>> may hide the unhappend issue.
>>>
>>>>
>>>> So to me it looks like the i2c-connected device driver should be fixed
>>>> instead?
>>>
>>>
>>> I tell them to fix it in rk808 driver.
>>
>> To me it seems like perhaps cpufreq should not be changing frequencies
>> until it is resumed properly.  Presumably if all the ordering is done
>> right then cpufreq should be resumed _after_ the i2c regulator so you
>> should be OK.  ...or am I somehow confused about that?
> 
> yes?the cpufreq and regulator should start i2c job after they resume
> properly.
> 
>>
>> Also note that previous i2c busses I worked with simply returned -EIO
>> in the case where they were called when suspended.  See
>> "i2c-exynos5.c" and "i2c-s3c2410.c".
> 
> In "i2c-exynos5.c", it seems that using the "i2c->suspended" to protect
> i2c transfer works most of the time. Of course it could prevent the next
> new i2c transfer to start. But in one case, if the current i2c job was
> not finished until the i2c irq was disabled by system suspend, the i2c
> timeout error would also happen, as the current i2c job may have a large
> data to transfer and it lasts from a long time.

And this means you have bug in some of I2C client drivers which do not stop
their activities during suspend properly (most usual case - driver uses work
and this work still active during suspend and can run on one CPU while suspend
runs on another).

At the moment .suspend_noirq() callback is called there should be no active
I2C transactions in general.

> 
> So is it necessary to add a mutex lock to wait the current job to be
> finished before the "i2c->suspended" is changed in i2c_suspend_noirq()?
> 

You need to catch and fix all driver who will try to access I2C after your
I2C bus driver passes suspend_noirq stage. Smth, like [1], uses i2c_lock_adapter().
 

[1] https://git.ti.com/android-sdk/kernel-omap/commit/125ef8f7016e7b205886f93862288a45a312b1d8

-- 
regards,
-grygorii
