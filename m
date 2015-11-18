From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 18 Nov 2015 16:04:49 +0900
Subject: [PATCH] arm64: extract a field correctly in
 cpuid_feature_extract_field()
In-Reply-To: <564AF2F7.9030106@arm.com>
References: <1447736739-4131-1-git-send-email-takahiro.akashi@linaro.org>
 <CAKv+Gu9=zfocXVOsqHQHGu+afZisE_nZWCQ-bN5Fe_X=NacYHg@mail.gmail.com>
 <564AF2F7.9030106@arm.com>
Message-ID: <564C2311.3040904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2015 06:27 PM, Suzuki K. Poulose wrote:
> On 17/11/15 07:15, Ard Biesheuvel wrote:
>> On 17 November 2015 at 06:05, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>> Basically, cpuid_feature_extract_field() does shift-left and then
>>> shift-right to extract a specific field in an operand. But
>>> a shift-left'ed value is casted to 's64' and so a succeeding shift-right
>>> operation results in creating a sign-extended (and bogus) value.
>>>
>>
>> This is intentional. This function was created specifically for
>> extracting CPU feature fields, which are signed 4-bit quantities,
>> where positive values represent incremental functionality, and
>> negative values are reserved. This is poorly documented in the ARM ARM
>> though.

Good. So please take my patch as a bug report because perf record -e mem:XXX:x
doesn't work with v4.4-rc1 (if # of hw breakpoints is over 0x7, e.g. default
case on fast model.)

> Right. Akash's fix could break other pieces (like FP/ASIMD support in IDAA64PFR0
> where, 0xf => function not implemented).

IMO, 0xf is 0xf, not -1.
(I don't think "All other values are reserved." means that the value is *signed*.)

Thanks,
-Takahiro AKASHI

>>
>> Using this function for extracting 4-bit unsigned values is a mistake.
>>
>
> I will take a look at this one.
>
> Thanks for pointing it out.
>
> Suzuki
>
