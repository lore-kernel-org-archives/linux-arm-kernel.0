From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 16 Dec 2015 13:48:28 +0100
Subject: [PATCH RFC 06/27] PM / Domains: add debugfs 'states' and
 'timings' seq files
In-Reply-To: <567145E1.5040804@baylibre.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-7-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFrOPKc-WDsHNpndkoZa5g6tnnbE2C5JsqZ6DMCX+6hmFw@mail.gmail.com>
 <567145E1.5040804@baylibre.com>
Message-ID: <CAPDyKFqPn5StedOgd-toxKvvcM078NuVvN8yUDByRZSe9HvKbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>
>> A general comment. Static functions in genpd shall start with one of
>> the following prefix.
>>
>> genpd_*
>> _genpd_*
>> __genpd_*
>>
>> Please change accordingly.
>
>
> Many static routines were already prefixed like the exported functions with
> "pm_", shall I make a separate patch for this renaming ?

My point is that I don't want it to becomes worse.

If you follow the above rule for new changes, I am happy.

Whether you want to send a separate patch fixing the other existing
name to be consistent with above rule, I would also be happy. :-)

>
>
>>
>>> ---
>>>   drivers/base/power/domain.c | 115
>>> +++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 107 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index c300293..9a0df09 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -2169,21 +2169,120 @@ static const struct file_operations
>>> pm_genpd_summary_fops = {
>>>          .release = single_release,
>>>   };
>>>
>>> +static int pm_genpd_states_show(struct seq_file *s, void *data)
>>> +{
>>> +       struct generic_pm_domain *genpd;
>>> +
>>> +       seq_puts(s,
>>> +                "\n  Domain             State name        Enter + Exit =
>>> Min_off_on (ns)\n");
>>> +       seq_puts(s,
>>> +
>>> "-----------------------------------------------------------------------\n");
>>> +
>>
>>
>> You must hold the gpd_list_lock while traversing the gpd list.
>>
>>> +       list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>>> +
>>> +               int i;
>>> +
>>> +               for (i = 0; i < genpd->state_count; i++) {
>>
>>
>> To be sure you have valid data, you should hold the genpd lock here.
>>
>
> At some point while testing with calling suspend from the power_off handler,
> the cpu would go to sleep with the lock held, hence using this seq-file
> would not work.

That seems like a bad behaviour during suspend. Why does it hold the lock?

On the other it shouldn't matter as userspace can't access the debugfs
nodes, since its frozen at those times, right!?

>
> while I agree, I think it is not super likely that a
> domain/child/devices/states are added or removed at this point (the DT is
> parsed already), would using list_for_each_entry_safe be safe enough ?

No it's not.

The gpd_list is protected with the gdp_list_lock, which is needed
because new genpds can be added at any point.

You also need the genpd lock here, as otherwise you may print the
latency-values in the middle of when these are being updated.

>
>
>>> +                       seq_printf(s, "%-20s %-20s %lld+%lld=%lld\n",
>>> +                                  genpd->name,
>>> +                                  genpd->states[i].name,
>>> +                                  genpd->states[i].power_on_latency_ns,
>>> +                                  genpd->states[i].power_off_latency_ns,
>>> +                                  genpd->states[i].power_off_latency_ns
>>> +                                  +
>>> genpd->states[i].power_on_latency_ns);
>>> +               }
>>> +
>>> +       }
>>> +
>>> +       seq_puts(s, "\n");
>>> +
>>> +       return 0;
>>> +}
>>> +

[...]

Kind regards
Uffe
