From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 19 Aug 2013 11:46:57 +0530
Subject: [PATCH V2 01/35] cpufreq: Implement light weight ->target_index()
 routine
In-Reply-To: <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <eb988fc9e72b90b7ba99f16405f5dcb072da7840.1376392602.git.viresh.kumar@linaro.org>
 <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
 <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
Message-ID: <CADGdYn4LoFEfZTd2bT=iGKRb5M=7CfpG-suxf3L-V5HXH7QuPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 10:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Amit,
>
> Thanks for your feedback :)
>
> On 18 August 2013 16:11, amit daniel kachhap <amit.daniel@samsung.com> wrote:
>> This new API is fine but I have another idea.
>
> good.
>
>> Say During the registration of the frequency table cpufreq_policy can
>> be registered as SCALE_DIRECT or SCALE_STEPS. With SCALE_DIRECT flag,
>> valid frequency will be requested. With this flags the governor itself
>> can  can figure out if frequency scaling is required or not and very
>> few calls to __cpufreq_driver_target will happen.
>
> Honestly speaking I couldn't get what your idea is :) ... but governor is
> in no position to make this direct call to drivers.. Taking such stuff to
> governors will replicate this code again.. Its better all governors call
> some common part of cpufreq.c which then decides what to do..
I meant that something like 2 policies can be registered SCALE_DIRECT/STEPS.
if SCALE_DIRECT is registered than target will be called with exact
frequency. SCALE_STEPS will behave as currently happening. This way
target_index api may not be needed. But looks like Rafael and others
are fine with your approach so you can ignore this :)
>
>> But i agree that in this approach cpufreq_frequency_table_target is
>> still required but again it can be optimized by binary search as
>> currently the search is linear.
>
> Frequencies in this table aren't required to be in ascending order :)
OK right. Actually I had thought only about the case when opp library
is used to create the cpufreq table and then it creates the table in
ascending order. Anyways not all platform uses opp libraries so it is
not generic enough.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


On Mon, Aug 19, 2013 at 10:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Amit,
>
> Thanks for your feedback :)
>
> On 18 August 2013 16:11, amit daniel kachhap <amit.daniel@samsung.com> wrote:
>> This new API is fine but I have another idea.
>
> good.
>
>> Say During the registration of the frequency table cpufreq_policy can
>> be registered as SCALE_DIRECT or SCALE_STEPS. With SCALE_DIRECT flag,
>> valid frequency will be requested. With this flags the governor itself
>> can  can figure out if frequency scaling is required or not and very
>> few calls to __cpufreq_driver_target will happen.
>
> Honestly speaking I couldn't get what your idea is :) ... but governor is
> in no position to make this direct call to drivers.. Taking such stuff to
> governors will replicate this code again.. Its better all governors call
> some common part of cpufreq.c which then decides what to do..
>
>> But i agree that in this approach cpufreq_frequency_table_target is
>> still required but again it can be optimized by binary search as
>> currently the search is linear.
>
> Frequencies in this table aren't required to be in ascending order :)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
