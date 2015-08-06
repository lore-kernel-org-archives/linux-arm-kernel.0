From: robh@kernel.org (Rob Herring)
Date: Wed, 5 Aug 2015 22:01:01 -0500
Subject: [PATCH 6/9] ARM: domain: Add platform handlers for CPU PM domains
In-Reply-To: <20150805192341.GB52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqKWekSGiFbZz6++3ibAzY_8Y6+0nOBQinFVw4cBk6JvEw@mail.gmail.com>
 <20150805192341.GB52339@linaro.org>
Message-ID: <CAL_JsqJ_AK6M5WmyFrGVLtpGg=MdAafxX=1873Je_uB_sQkpiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 5, 2015 at 2:23 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Wed, Aug 05 2015 at 08:45 -0600, Rob Herring wrote:
>>
>> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>
>>> In addition to the common power up/down actions of CPU PM domain core,
>>> platforms may have additional configuration before the CPU domain can be
>>> powered off or considered active. Allow platform drivers to register
>>> handlers for CPU PM domains.
>>>
>>> Platform drivers may register their callbacks against a compatible
>>> string defined by their PM domain provider device node in the DT. At
>>> domain init, the platform driver can initialize the platform specific
>>> genpd attributes. The init callback would need to return successfully,
>>> for the platform power_on/off handlers to be registered with the CPU PM
>>> domain.
>>>
>>> The code uses __init section to reduce memory needed for platform
>>> handlers and therefore can be freed after the driver is initialized, a
>>> desirable outcome for single kernel image.
>>
>>
>> [...]
>>
>>> diff --git a/arch/arm/include/asm/arm-pd.h
>>> b/arch/arm/include/asm/arm-pd.h
>>> new file mode 100644
>>> index 0000000..fc44abf
>
>
> [...]
>
>>> +#define ARM_PD_METHOD_OF_DECLARE(_name, _handle, _ops) \
>>> +       static const struct of_arm_pd_method
>>> __arm_pd_method_of_table_##_name \
>>> +       __used __section(__arm_pd_method_of_table)              \
>>> +       = { .handle = _handle, .ops = _ops }
>>
>>
>> AFAICT, you are not using this in this series. You should add it when
>> you have a user.
>>
>> Ideally, we keep some amount of uniformity across various *_OF_DECLARE
>> which is why we have OF_DECLARE_1 and OF_DECLARE_2. This makes all the
>> sections just arrays of struct of_device_id. Not all users follow
>> this, but most do. So instead of putting the ops in here, platforms
>> can provide a function callback which can then set the ops. Then you
>> also don't need the .init() ops function as the callback function can
>> do any initialization too.
>>
> I looked through these and I can switch over to _OF_DECLARE() without any
> issues, but using OF_DECLARE_1 or OF_DECLARE_2 is pretty limiting.

Well yes, but then we only want to use it for things that will never
use the driver model.

> If I could set up my own function type for the .data member, then its a
> lot more easier on the code. Like this -
>
> typedef int (*arm_pd_init)(struct device_node *dn, struct
>                 generic_pm_domain *genpd, struct of_arm_pd_ops *ops);

You alloc the genpd struct just before calling init. You can just as
easily have the platform specific code call an allocation function and
a function to set the ops functions. This is more inline with how a
driver would work when registering with a subsystem. I also don't
think "arm,pd" is a good compatible string to be matching on. I'll
comment on that more in patch 5.

Rob
