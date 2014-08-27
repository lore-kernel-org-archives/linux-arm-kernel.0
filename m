From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Aug 2014 13:20:35 +0200
Subject: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
In-Reply-To: <CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
 <CAPDyKFo9-5=uPqD8RvLGsYtSCynBFnGGeSCpwLZuzDtW+652hA@mail.gmail.com>
 <CAD=FV=VveHTYmiBu42DJeFFGARV2+1bS6Y2CQM995YkX_O9SQA@mail.gmail.com>
 <CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
Message-ID: <CAPDyKFpJCPzvZOXc0XR5PhXC4MZhVbw_H_c-4wrgpnvUbbcuFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2014 13:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Doug,
>
> [snip]
>
>>>>> I think you shall be able use MMC_CAP_NEEDS_POLL, to handle this
>>>>> broken card detect mechanism. We even have a DT binding for that,
>>>>> "broken-cd".
>>>>
>>>> I don't think this is possible, but let me explain why I think so and
>>>> you can correct me.
>>>>
>>>> The voltage domain of the "card detect" pin on the SoC is vqmmc,
>>>> right?  That means that you won't be able to read the pin without
>>>> turning on vqmmc.  Even if you could read the pin without turning on
>>>> vqmmc, the pullup on this line is connected to vqmmc too.  ...so if
>>>> vqmmc is off then there's no pulup and you can't use card detect.
>>>>
>>>> Are you suggesting that we should flip the voltage of vqmmc (and thus
>>>> vmmc to prevent damaging the card) during polling?  That seems ugly.
>>>
>>> I am not sure I follow to understand the problem. All I am saying is:
>>> From your ->set_ios() when you get MMC_POWER_UP, enable vcc and vccq.
>>> From your ->set_ios() when you get MMC_POWER_OFF, disable vccq and vcc.
>>>
>>> The rest is taken care of from mmc core, when trying to initialize the card.
>>
>> We must not be on the same page, so I'll put all my assumptions in
>> super detail and we can see what's different...
>>
>>
>> So if I have "MMC_CAP_NEEDS_POLL" set, the MMC core will poll things,
>> right?  ...and you are suggesting that I could solve my vqmmc vs. card
>> detect problem by using MMC_CAP_NEEDS_POLL, right?
>
> Yes.
>
>>
>>
>> Let's think about the case when no card is inserted.  When no card is
>> inserted the core will call set_ios() with MMC_POWER_OFF, right?
>>
>> ...and we want that to turn off vmmc.
>> ...and if we turn off vmmc, we should turn off vqmmc.
>
> Correct. At MMC_POWER_OFF, all host drivers shall turn off all the
> possible powers that goes to the card. I am just telling this to make
> sure, we don't think this is a dw_mmc specific thing.
>
>>
>> Now we've got vmmc off and vqmmc off and on this board we can't read
>> the card detect line, right?
>
> Got it. :-)
>
>>
>> Now, we've got MMC_CAP_NEEDS_POLL, so dw_mmc will periodically be
>> called to check the card detect line, but with vmmc and vqmmc off.  It
>> will be unable to return a sensible value without actually turning on
>> vmmc and vqmmc.
>
> Currently MMC_CAP_NEEDS_POLL mean the mmc rescan work will reschedule
> itself with HZ interval. This to check for card insert/removal.
>
> Now, mmc_rescan() will, if present, invoke host's ->get_cd() callback
> to check whether it's worth to continue initialization sequence or if
> it should re-schedule itself again.
>
> If your host driver can distinguish whether a card is inserted, which
> in this the are when vccq is turned off, your ->get_cd() callback need

/s /the /case

> to return 0. That will allow mmc_rescan() to continue it's

/s /return 0 /return 1

> initialization sequence and do mmc_power_up().
>
>>
>>
>> ...so with that context, I'll ask my questoin again:
>>
>> Are you suggesting that we should flip the voltage of vqmmc (and thus
>> vmmc to prevent damaging the card) during polling?  That seems ugly.
>
> Nope.
>
> Kind regards
> Uffe
