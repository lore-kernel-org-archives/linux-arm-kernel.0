From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 16 Feb 2015 10:09:54 +0000
Subject: [PATCH v2] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <CAKv+Gu8nQ12SKipQC7EuzFwge6NMF3zyAdYJmRUjNWfBoux9Jw@mail.gmail.com>
References: <1423740543-6168-1-git-send-email-ard.biesheuvel@linaro.org>	<54DDA1D2.5010001@linaro.org>	<CAKv+Gu-KErA+NxX2ctZmrjKYTLYLbGvGiqbEXkowvNbCGF65Bw@mail.gmail.com>	<54DDA4FC.6050307@linaro.org>
 <CAKv+Gu8nQ12SKipQC7EuzFwge6NMF3zyAdYJmRUjNWfBoux9Jw@mail.gmail.com>
Message-ID: <54E1C1F2.9030305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 16/02/15 09:37, Ard Biesheuvel wrote:
> On 13 February 2015 at 15:17, Julien Grall <julien.grall@linaro.org> wrote:
>>
>>
>> On 13/02/2015 15:12, Ard Biesheuvel wrote:
>>>
>>> On 13 February 2015 at 15:03, Julien Grall <julien.grall@linaro.org>
>>> wrote:
>>>>
>>>> Hi Ard,
>>>>
>>>>
>>>> On 12/02/2015 19:29, Ard Biesheuvel wrote:
>>>>>
>>>>>
>>>>> This patch registers hvc0 as the preferred console if no console
>>>>> has been specified explicitly on the kernel command line.
>>>>>
>>>>> The purpose is to allow platform agnostic kernels and boot images
>>>>> (such as distro installers) to boot in a Xen/ARM domU without the
>>>>> need to modify the command line by hand.
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> ---
>>>>>    arch/arm/xen/enlighten.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>>>>> index 0abeefa7dbf8..927be1d1bad7 100644
>>>>> --- a/arch/arm/xen/enlighten.c
>>>>> +++ b/arch/arm/xen/enlighten.c
>>>>> @@ -24,6 +24,7 @@
>>>>>    #include <linux/cpuidle.h>
>>>>>    #include <linux/cpufreq.h>
>>>>>    #include <linux/cpu.h>
>>>>> +#include <linux/console.h>
>>>>>
>>>>>    #include <linux/mm.h>
>>>>>
>>>>> @@ -255,6 +256,9 @@ void __init xen_early_init(void)
>>>>>                  xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
>>>>>          else
>>>>>                  xen_start_info->flags &=
>>>>> ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
>>>>> +
>>>>> +       if (!console_set_on_cmdline && !xen_initial_domain())
>>>>> +               add_preferred_console("hvc", 0, NULL);
>>>>
>>>>
>>>>
>>>> Unfortunately, this won't work as expected.
>>>>
>>>
>>> Did you try it?
>>
>>
>> No just looked at the code.
>>
>>>> console_set_on_cmdline is set when Linux parses the early params. The
>>>> parsing is done after setup_arch (the function which call
>>>> xen_early_init).
>>>>
>>>> So we will end up to add the HVC console even if a console has been
>>>> passed
>>>> on the command line.
>>>>
>>>
>>> parse_early_param() is also called by setup_arch(), before
>>> xen_early_init()
>>>
>>> The call to parse_early_param() in generic code is only there for
>>> architectures that don't call it in their setup_arch()
>>
>>
>> Oh, right. Sorry for the noise.
>>
>> So:
>>
>> Reviewed-by: Julien Grall <julien.grall@linaro.org>
>>
> 
> Would it make sense to roll this into your xen_early_init() series as #3?

The xen_early_init has been created in order to support preferred
console. I don't mind to carry this patch in the next version.

Regards,

-- 
Julien Grall
