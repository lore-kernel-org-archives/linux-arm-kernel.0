From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Nov 2015 08:26:23 +0100
Subject: [PATCH] arm64: extract a field correctly in
 cpuid_feature_extract_field()
In-Reply-To: <564C2311.3040904@linaro.org>
References: <1447736739-4131-1-git-send-email-takahiro.akashi@linaro.org>
 <CAKv+Gu9=zfocXVOsqHQHGu+afZisE_nZWCQ-bN5Fe_X=NacYHg@mail.gmail.com>
 <564AF2F7.9030106@arm.com> <564C2311.3040904@linaro.org>
Message-ID: <CAKv+Gu9wiUXt3R0psPjye0Tzn2FRNkffXyutph3PiuVtp58VsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Steve)

On 18 November 2015 at 08:04, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On 11/17/2015 06:27 PM, Suzuki K. Poulose wrote:
>>
>> On 17/11/15 07:15, Ard Biesheuvel wrote:
>>>
>>> On 17 November 2015 at 06:05, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>>>
>>>> Basically, cpuid_feature_extract_field() does shift-left and then
>>>> shift-right to extract a specific field in an operand. But
>>>> a shift-left'ed value is casted to 's64' and so a succeeding shift-right
>>>> operation results in creating a sign-extended (and bogus) value.
>>>>
>>>
>>> This is intentional. This function was created specifically for
>>> extracting CPU feature fields, which are signed 4-bit quantities,
>>> where positive values represent incremental functionality, and
>>> negative values are reserved. This is poorly documented in the ARM ARM
>>> though.
>
>
> Good. So please take my patch as a bug report because perf record -e
> mem:XXX:x
> doesn't work with v4.4-rc1 (if # of hw breakpoints is over 0x7, e.g. default
> case on fast model.)
>
>> Right. Akash's fix could break other pieces (like FP/ASIMD support in
>> IDAA64PFR0
>> where, 0xf => function not implemented).
>
>
> IMO, 0xf is 0xf, not -1.
> (I don't think "All other values are reserved." means that the value is
> *signed*.)
>

It does, but the ARM ARM does not explicitly say so. That is why I
said it is poorly documented.

If we ignore all values except the documented ones, we defeat the
purpose of describing incremental functionality, and we break forward
compatibility.
For instance, bits [7:4] of ID_AA64ISAR0_EL1 are currently defined as

"""
0000 No AES instructions implemented.
0001 AESE, AESD, AESMC, and AESIMC instructions implemented.
0010 As for 0001 , plus PMULL/PMULL2 instructions operating on 64-bit
data quantities.
All other values are reserved.
"""

but in the future, values up to 0b0111 may be defined that each imply
all the preceding ones. If we don't take that into account now, older
kernels on newer versions of the architecture may lose the ability to
use AES and PMULL instructions if this field is extended.

That is why I said using cpuid_feature_extract_field() for other 4-bit
fields is a mistake. It should only be used for fields that describe
incremental functionality.

-- 
Ard.
