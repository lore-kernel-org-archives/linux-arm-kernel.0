From: qnguyen@apm.com (Quan Nguyen)
Date: Thu, 28 Jan 2016 16:30:47 +0700
Subject: [PATCH v4 1/3] gpio: xgene: Enable X-Gene standby GPIO as
 interrupt controller
In-Reply-To: <56A8C1DB.5040606@arm.com>
References: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
 <1453792935-19916-2-git-send-email-qnguyen@apm.com>
 <56A74BD3.40801@arm.com>
 <CAFopSPTz=sdZs_WZrU8ryTRXNtb4GPOMA_sj8HMPMxWBxV2w4A@mail.gmail.com>
 <56A7AF48.8020605@arm.com>
 <CAFopSPR1ZKinH=N29gaAu3M8oc-vfKUnPsFpAu3EUNb3Doi68w@mail.gmail.com>
 <56A8C1DB.5040606@arm.com>
Message-ID: <CAFopSPRW0yOdbyU_MYuXus+hS-DYWAukPRfn8WsQSv4yqrTjpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 8:10 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Quan,
>
> On 27/01/16 12:48, Quan Nguyen wrote:
>> On Wed, Jan 27, 2016 at 12:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 26/01/16 16:27, Quan Nguyen wrote:
>>>> On Tue, Jan 26, 2016 at 5:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>
>>>>> On 26/01/16 07:22, Quan Nguyen wrote:
>>>>>> Enable X-Gene standby GPIO controller as interrupt controller to provide
>>>>>> its own resources. This avoids ambiguity where GIC interrupt resource is
>>>>>> use as X-Gene standby GPIO interrupt resource in user driver.
>>>>>>
>>>>>> Signed-off-by: Y Vo <yvo@apm.com>
>>>>>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>>>>>> ---
>>>>>>  drivers/gpio/gpio-xgene-sb.c | 331 ++++++++++++++++++++++++++++++++++++-------
>>>>>>  1 file changed, 276 insertions(+), 55 deletions(-)
>>>
>>> [...]
>>>>>> @@ -90,6 +301,32 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
>>>>>>       if (IS_ERR(regs))
>>>>>>               return PTR_ERR(regs);
>>>>>>
>>>>>> +     priv->regs = regs;
>>>>>> +
>>>>>> +     of_id = of_match_device(xgene_gpio_sb_of_match, &pdev->dev);
>>>>>> +     if (of_id)
>>>>>> +             priv->flags = (uintptr_t)of_id->data;
>>>>>
>>>>> Wait. Everything is hardcoded? So why do we have to deal with looking
>>>>> into that structure if nothing is actually parametrized?
>>>>
>>>> There will be other instances with difference number of irq pins /gpio
>>>> /start_irq_base etc.
>>>
>>> Then it has to be described in DT right now.
>>>
>>
>> What I was thinking is to have other id to match with difference
>> instances and these code can be use for ACPI also. Let say
>> "apm,xgene2-gpio-sb"
>> Please help correcting me if it is not right.
>
> I still think this is the wrong thing to do. You are hiding magic values
> in the driver, for no good reason. If ACPI has such a broken model that
> it cannot give you the various parameters you need, then this is an ACPI
> problem you can solve in the ACPI-specific code. Alternatively, you
> could also fix your ACPI tables to be less braindead.
>
> But please do not turn the DT code into the same mess for the sake of
> using the lowest common denominator. Have a set of properties describing
> the HW, a compatibility string to nicely identify the revision, and use
> that. You can still hardcode things for ACPI if you desperately need it.
>
>

Thanks, Marc.
I'll try with set of properties describing HW and may utilize _DSD
method for ACPI.

-- Quan Nguyen
