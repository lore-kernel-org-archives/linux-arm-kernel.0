From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 19 Jun 2017 11:48:05 +0200
Subject: [PATCH v15 2/7] power: add power sequence library
In-Reply-To: <20170619090259.GA23731@b29397-desktop>
References: <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop>
 <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop>
 <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
 <20170615091131.GB24157@b29397-desktop>
 <CAPDyKFrZoyoYCQA1rnRbz9tmT9vJigzSb+xyTZpJjhd=5eFA5A@mail.gmail.com>
 <20170615100604.GC24157@b29397-desktop>
 <CAPDyKFrSQ7m+yUvKqB9yAMakk8pHZooboZMFdXGU6Xb=TZSGNA@mail.gmail.com>
 <20170619090259.GA23731@b29397-desktop>
Message-ID: <CAPDyKFo0d2FD1U-MgWTExz_cKC8BjB6QQFu1StTyPN1TGBG9eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> >
>> > Unlike the MMC design, there is no dts entry to indicate whether this
>> > device needs pwrseq or not at this design, it will only carry out power
>> > on sequence after matching. So, return -EPROBE_DEFER may not work since
>> > this device may never need pwrseq.
>>
>> Then, how will you really be able to fetch the correct pwrseq library
>> instance for the device node?
>>
>> Suppose their is a *list* of pwrseq library instances available. In
>> pwrseq_find_available_instance() you call of_match_node(table, np).
>> The "table" there corresponds to the compatible for the pwrseq library
>> and the np is the device node provided by the caller of
>> of_pwrseq_on().
>>
>> Why is this match done?
>
> The compatible in table is from the source code, and the compatible in
> np is from the dts. This is the current match way, I comment your
> suggestion below.
>
>>
>> Why can't the match be done before trying to fetch a library instance
>
> How? If there is no pwrseq instance, how can we do match?
>
>> and then in a second step, really try to fetch the instance? If only
>> the second step fails, returning -EPROBE_DEFER can be done, no?
>>
>> BTW, I didn't compatible for the generic pwrseq library being
>> documented in this series.

Seems like you need to update the DT documentation for the below
compatible, which is used for the generic pwrseq library. Perhaps this
is what puzzles me a bit on *why* the match is done.

+static const struct of_device_id generic_id_table[] = {
+       { .compatible = "generic",},
+       { /* sentinel */ }
+};

[...]

>> >
>> > This additional instance is used to store compatible information for
>> > this pwrseq library, it is used for the next matching between device
>> > and pwrseq library, it just likes we need the first pwrseq instance
>> > registered at boot stage.
>>
>> Why can't the compatible information be a static table, known by the
>> pwrseq core library?
>>
>> Then when of_pwrseq_on() is called, that static table is parsed and
>> matched, then a corresponding pwrseq library instance tries to be
>> fetched.
>>
>
> So, you suggest allocating and registering pwrseq instance on the
> demand? Eg, we maintain a power sequence static table, including
> compatible and allocate function.

Yes, something like that.

>
> static const struct pwrseq_match_table pwrseq_match_table_list[] = {
>         { PWRSEQ_DEV(0x0204, 0x6025), .alloc_instance = pwrseq_AA_alloc_instance },
>         { PWRSEQ_DEV(0x0204, 0x6026), .alloc_instance = pwrseq_BB_alloc_instance },
>         { PWRSEQ_DEV(0xffff, 0xffff), .alloc_instance = pwrseq_generic_alloc_instance },

What does the  PWRSEQ_DEV() macro do?

> };
>
> And pwrseq_AA{BB}_alloc_instance are defined at each pwrseq library, and
> are exported.

With "exported", I guess you mean shared via a common pwrseq header?

>
> Since the pwrseq_match_table_list is static, we can always do match, and
> will not return -EPROBE_DEFER anymore, one problem for this is we need
> always compile all pwrseq libraries. Any good suggestions?

You never returned -EPROBE_DEFER in the first case. That's why I complained. :-)

So, in case the OF match doesn't succeed, there are no reason to
propagate an error, but instead just bail out and returning 0 to the
caller.

If the OF match succeeds, it means the device requires a pwrseq
library to be used. Then, pwrseq_XX_alloc_instance() will be called,
on demand and which tries to fetch the resources (clocks, gpios etc).
If any of those attempts fetching a resource fails, its corresponding
error code should be propagated to the caller - including
-EPROBE_DEFER.

Regarding the "always compile all pwrseq libraries"; no we don't need
to do that. Instead we only need a to have a stub function for
pwrseq_XX_alloc_instance, in case its corresponding Kconfig option is
unset. That stub, should of course return an error code.

Kind regards
Uffe
