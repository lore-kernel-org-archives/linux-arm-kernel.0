From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 15:20:24 +0200
Subject: [PATCHv2 1/5] clk: samsung: exynos5410: Add NULL pointer checks
 in clock init
In-Reply-To: <CAEe5pB-FnkY8E9qPjy+6R5ausEEx-pO2wupWYZO8Lscb2BAwiw@mail.gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-2-git-send-email-hsnaves@gmail.com>
 <53DA37EA.7010306@gmail.com>
 <CAEe5pB-FnkY8E9qPjy+6R5ausEEx-pO2wupWYZO8Lscb2BAwiw@mail.gmail.com>
Message-ID: <53DA4298.5090900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2014 15:13, Humberto Naves wrote:
> Hi,
> 
> I am bit confused by your response: first you mentioned that I should
> remove the NULL check for variable np, but later on you suggested that
> I should rearrange the conditional statement to avoid adding more
> indentation.

That was just a side note.

> My guess is that I should remove that if statement
> altogether?

Yes, that was my intention.

> 
> Regarding the ctx variable, should I still remove the NULL check? As
> you said, in the near future samsung_clk_init() won't panic anymore,
> and keeping the check in place won't hurt anybody.

The rule of thumb for kernel patches is that we want a patch if we know
that it is something we need. We don't know yet when and how (which
error returning convention, NULL or ERR_PTR() or maybe something else?)
samsung_clk_init() gets changed, so right now we shouldn't change its
callers.

Of course a patch changing samsung_clk_init() and all its callers in one
go will be welcome.

By the way, please avoid top posting. Here's a good read on Linux
mailing lists netiquette: http://www.tux.org/lkml/#s3 .

Best regards,
Tomasz

> 
> Best,
> Humberto
> 
> On Thu, Jul 31, 2014 at 2:34 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Humberto,
>>
>> Please see my comments inline.
>>
>> On 31.07.2014 13:22, Humberto Silva Naves wrote:
>>> Added NULL pointer checks for device_node input parameter and
>>> for the samsung_clk_provider context returned by samsung_clk_init.
>>> Even though the *current* samsung_clk_init function never returns
>>> a NULL pointer, it is good to keep this check in place to avoid
>>> possible problems in the future due to changes in implementation.
>>> That way, we also improve the consistency of the code that performs
>>> clock initialization across the different SoCs.
>>>
>>> Signed-off-by: Humberto Silva Naves <hsnaves@gmail.com>
>>> ---
>>>  drivers/clk/samsung/clk-exynos5410.c |   12 +++++++++---
>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
>>> index 231475b..bf57c80 100644
>>> --- a/drivers/clk/samsung/clk-exynos5410.c
>>> +++ b/drivers/clk/samsung/clk-exynos5410.c
>>> @@ -188,11 +188,17 @@ static void __init exynos5410_clk_init(struct device_node *np)
>>>       struct samsung_clk_provider *ctx;
>>>       void __iomem *reg_base;
>>>
>>> -     reg_base = of_iomap(np, 0);
>>> -     if (!reg_base)
>>> -             panic("%s: failed to map registers\n", __func__);
>>> +     if (np) {
>>
>> Since all Exynos-based boards are always booted using DT, this function
>> will never be called if there is no node for the clock controller and so
>> there is no way this pointer can end up being NULL. I don't see a point
>> in complicating this code with useless checks.
>>
>>> +             reg_base = of_iomap(np, 0);
>>> +             if (!reg_base)
>>> +                     panic("%s: failed to map registers\n", __func__);
>>> +     } else {
>>> +             panic("%s: unable to determine soc\n", __func__);
>>> +     }
>>
>> As a side note, since panic() does not return, the code above could be
>> changed to follow rest of checks in this function:
>>
>>         if (!np)
>>                 panic("%s: unable to determine soc\n", __func__);
>>
>>         reg_base = of_iomap(np, 0);
>>         ...
>>
>> leading to more readable code with less indentation and less changes to
>> existing code.
>>
>>>
>>>       ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
>>> +     if (!ctx)
>>> +             panic("%s: unable to allocate context.\n", __func__);
>>
>> samsung_clk_init() already panics on any error, although now as I think
>> of it, it probably should be changed with a patch to just error out and
>> let the caller handle the error. However callers don't need to be
>> changed before this is done.
>>
>> Best regards,
>> Tomasz
