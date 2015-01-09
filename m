From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 9 Jan 2015 12:44:44 -0800
Subject: [PATCH] reset: sunxi: fix spinlock initialization
In-Reply-To: <54AFE968.4010805@st.com>
References: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
 <54AFC2A8.1010807@st.com> <54AFE968.4010805@st.com>
Message-ID: <CANMBJr5VzdvSyh4e6yk0wCznVmEgHBEi_MqdgcBpR=Nbf0=WvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 9 January 2015 at 06:44, Maxime Coquelin <maxime.coquelin@st.com> wrote:
> With Maxime in the To: list.
>
>
>
> On 01/09/2015 12:59 PM, Maxime Coquelin wrote:
>>
>> Hi Tyler, Maxime,
>>
>> On 01/08/2015 01:54 AM, Tyler Baker wrote:
>>>
>>> Call spin_lock_init() before the spinlocks are used, preventing a lockdep
>>> splat.
>>>
>>> I have been observing lockdep complaining [1] during boot on my a80
>>> optimus [2]
>>> when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the
>>> splat,
>>> and has been tested on a few other sunxi platforms without issue.
>>>
>>> [1]
>>> http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
>>> [2] http://kernelci.org/boot/?a80-optimus
>>>
>>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>>> ---
>>> This patch was tested on 3.19.0-rc3
>>>
>>>   drivers/reset/reset-sunxi.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
>>> index eebc52c..e37250c 100644
>>> --- a/drivers/reset/reset-sunxi.c
>>> +++ b/drivers/reset/reset-sunxi.c
>>> @@ -157,6 +157,8 @@ static int sunxi_reset_probe(struct platform_device
>>> *pdev)
>>>       if (IS_ERR(data->membase))
>>>           return PTR_ERR(data->membase);
>>>   +    spin_lock_init(&data->lock);
>>> +
>>
>> Shouldn't the lock be initialized also in early init function
>> (sunxi_reset_init) ?

Thanks for pointing this out. It seems reasonable to me to add this
for the sun6i platforms that use the early init function. Currently
trying to track down a sun6i platform so I can run a few locking
validation tests.

>>
>> Regards,
>> Maxime
>>>
>>>       data->rcdev.owner = THIS_MODULE;
>>>       data->rcdev.nr_resets = resource_size(res) * 32;
>>>       data->rcdev.ops = &sunxi_reset_ops;
>>
>>
>



-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
