From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Nov 2015 09:27:19 +0000
Subject: [PATCH] arm64: extract a field correctly in
 cpuid_feature_extract_field()
In-Reply-To: <CAKv+Gu9=zfocXVOsqHQHGu+afZisE_nZWCQ-bN5Fe_X=NacYHg@mail.gmail.com>
References: <1447736739-4131-1-git-send-email-takahiro.akashi@linaro.org>
 <CAKv+Gu9=zfocXVOsqHQHGu+afZisE_nZWCQ-bN5Fe_X=NacYHg@mail.gmail.com>
Message-ID: <564AF2F7.9030106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 07:15, Ard Biesheuvel wrote:
> On 17 November 2015 at 06:05, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> Basically, cpuid_feature_extract_field() does shift-left and then
>> shift-right to extract a specific field in an operand. But
>> a shift-left'ed value is casted to 's64' and so a succeeding shift-right
>> operation results in creating a sign-extended (and bogus) value.
>>
>
> This is intentional. This function was created specifically for
> extracting CPU feature fields, which are signed 4-bit quantities,
> where positive values represent incremental functionality, and
> negative values are reserved. This is poorly documented in the ARM ARM
> though.

Right. Akash's fix could break other pieces (like FP/ASIMD support in IDAA64PFR0
where, 0xf => function not implemented).

>
> Using this function for extracting 4-bit unsigned values is a mistake.
>

I will take a look at this one.

Thanks for pointing it out.

Suzuki
