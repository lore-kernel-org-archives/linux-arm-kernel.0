From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 9 Jan 2015 16:22:46 -0800
Subject: [PATCH] reset: sunxi: fix spinlock initialization
In-Reply-To: <CANMBJr5VzdvSyh4e6yk0wCznVmEgHBEi_MqdgcBpR=Nbf0=WvQ@mail.gmail.com>
References: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
 <54AFC2A8.1010807@st.com> <54AFE968.4010805@st.com>
 <CANMBJr5VzdvSyh4e6yk0wCznVmEgHBEi_MqdgcBpR=Nbf0=WvQ@mail.gmail.com>
Message-ID: <CANMBJr5zzzjA3-zrQb0s3UxP9bfo7bjQRn_zGAyUXXvOW7httQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 12:44, Tyler Baker <tyler.baker@linaro.org> wrote:
> Hi Maxime,
>
> On 9 January 2015 at 06:44, Maxime Coquelin <maxime.coquelin@st.com> wrote:
>> With Maxime in the To: list.
>>
>>
>>
>> On 01/09/2015 12:59 PM, Maxime Coquelin wrote:
>>>
>>> Hi Tyler, Maxime,
>>>
>>> On 01/08/2015 01:54 AM, Tyler Baker wrote:
>>>>
>>>> Call spin_lock_init() before the spinlocks are used, preventing a lockdep
>>>> splat.
>>>>
>>>> I have been observing lockdep complaining [1] during boot on my a80
>>>> optimus [2]
>>>> when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the
>>>> splat,
>>>> and has been tested on a few other sunxi platforms without issue.
>>>>
>>>> [1]
>>>> http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
>>>> [2] http://kernelci.org/boot/?a80-optimus
>>>>
>>>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>>>> ---
>>>> This patch was tested on 3.19.0-rc3
>>>>
>>>>   drivers/reset/reset-sunxi.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
>>>> index eebc52c..e37250c 100644
>>>> --- a/drivers/reset/reset-sunxi.c
>>>> +++ b/drivers/reset/reset-sunxi.c
>>>> @@ -157,6 +157,8 @@ static int sunxi_reset_probe(struct platform_device
>>>> *pdev)
>>>>       if (IS_ERR(data->membase))
>>>>           return PTR_ERR(data->membase);
>>>>   +    spin_lock_init(&data->lock);
>>>> +
>>>
>>> Shouldn't the lock be initialized also in early init function
>>> (sunxi_reset_init) ?
>
> Thanks for pointing this out. It seems reasonable to me to add this
> for the sun6i platforms that use the early init function. Currently
> trying to track down a sun6i platform so I can run a few locking
> validation tests.

Olof was kind enough to volunteer his sun6i platform (colombus) and
provide the results. The results confirms there is a need to also
initialize the lock in sunxi_reset_init as Maxime C. mentioned.

DEBUG: sunxi_reset_init()
DEBUG: sunxi_reset_deassert()
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0-rc3-00039-gccd0de2-dirty #5
Hardware name: Allwinner sun6i (A31) Family
[<c021679c>] (unwind_backtrace) from [<c0212140>] (show_stack+0x10/0x14)
[<c0212140>] (show_stack) from [<c09557c4>] (dump_stack+0x8c/0x9c)
[<c09557c4>] (dump_stack) from [<c028293c>] (__lock_acquire+0x1ef4/0x1f00)
[<c028293c>] (__lock_acquire) from [<c028311c>] (lock_acquire+0x6c/0x8c)
[<c028311c>] (lock_acquire) from [<c095b810>] (_raw_spin_lock_irqsave+0x3c/0x50)
[<c095b810>] (_raw_spin_lock_irqsave) from [<c0542d80>]
(sunxi_reset_deassert+0x2c/0x88)
[<c0542d80>] (sunxi_reset_deassert) from [<c0d39a00>]
(sun5i_timer_init+0xc0/0x1f0)
[<c0d39a00>] (sun5i_timer_init) from [<c0d3897c>]
(clocksource_of_init+0x4c/0x8c)
[<c0d3897c>] (clocksource_of_init) from [<c0cf0b34>] (start_kernel+0x278/0x3c8)
[<c0cf0b34>] (start_kernel) from [<40208074>] (0x40208074)

I'll go ahead and resend an updated patch and cc stable if Philipp and
Maxime R. they agree.

>
>>>
>>> Regards,
>>> Maxime
>>>>
>>>>       data->rcdev.owner = THIS_MODULE;
>>>>       data->rcdev.nr_resets = resource_size(res) * 32;
>>>>       data->rcdev.ops = &sunxi_reset_ops;
>>>
>>>
>>
>
>
>
> --
> Tyler Baker
> Tech Lead, LAVA
> Linaro.org | Open source software for ARM SoCs
> Follow Linaro: http://www.facebook.com/pages/Linaro
> http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog

Cheers,

-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
