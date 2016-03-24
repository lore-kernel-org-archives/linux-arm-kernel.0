From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Thu, 24 Mar 2016 23:17:20 +0900
Subject: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
In-Reply-To: <56F3F11E.9090200@math.uni-bielefeld.de>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
 <56F36D65.6030504@samsung.com> <56F3EE8E.3020308@fivetechno.de>
 <56F3F11E.9090200@math.uni-bielefeld.de>
Message-ID: <CAGTfZH34ojHu3bnGSZpbVamZOJ08vnTjzxM-R3r1V8U19eHyDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tobias,

On Thu, Mar 24, 2016 at 10:52 PM, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello everybody,
>
>
> Markus Reichl wrote:
>> Hi Chanwoo,
>>
>> Am 24.03.2016 um 05:30 schrieb Chanwoo Choi:
>>> Dear Anand and Tobias,
>>>
>>> To Anand,
>>> First of all, thanks to your test on previous patchset.
>>> I removed the your tested-by tag from this version
>>> because I modified the devfreq core using DEVFREQ_TRANSITION_NOTIFIER notifier.
>>> I think that this patch-set need to test with this patchset.
>>> If you possible, could you please test this patch-set? Thanks in advance.
>>>
>>> To Tobias,
>>> I fixed the following issues reported by you. Thanks your test and report.
>>> - RCU locking issue
>>> - debugfs error during kernel booting
>>>
>>> Best Regards,
>>> Chanwoo Choi
>>
>> This set works fine on odroid U3 but gives the following with dmesg |grep devfreq:
>>
>> [    2.066890] devfreq bus_dmc: Couldn't update frequency transition information.
>> [    2.190238] devfreq bus_leftbus: Couldn't update frequency transition information.
> I have yet to test this new iteration of the patchset, but this message
> looks familiar. I already encountered it with the older version applied
> to vanilla-4.5.y.
>
> The messages happen when devfreq_update_status() (in
> drivers/devfreq/devfreq.c) encounters a uninitialized (zero)
> previous_freq. I have currently fixed this in my local tree by just
> skipping (goto out) devfreq_update_status() in that case.

I agree. Your comment is correct.

>
> Maybe it would be more elegant to set previous_freq to something sane on
> probe. IIRC then it is set from initial_freq on probe, but the exynos
> code doesn't set this one.

The devfreq have already this issue before sending my patches.
So, I think that you better to send your fixup patch.

Maybe, the exynos-bus.c read the current frequency in the probe function
and then devfreq core should set the devfreq->previous_freq field.

>
> Maybe this info is helpful?

Your info is very helpful. Thanks.

Best Regards,
Chanwoo Choi
