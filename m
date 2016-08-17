From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Aug 2016 12:36:21 +0200
Subject: [PATCH] arm64: head.S: get rid of x25 and x26 with 'global' scope
In-Reply-To: <20160817101924.GC30900@leverpostej>
References: <1471374152-23538-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160817101924.GC30900@leverpostej>
Message-ID: <CAKv+Gu9WPZ65K2Y7bum+-c3JJhSD0JzG3oYv2naMK-zPrDVo2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2016 at 12:19, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Aug 16, 2016 at 09:02:32PM +0200, Ard Biesheuvel wrote:
>> Currently, x25 and x26 hold the physical addresses of idmap_pg_dir
>> and swapper_pg_dir, respectively, when running early boot code. But
>> having registers with 'global' scope in files that contain different
>> sections with different lifetimes, and that are called by different
>> CPUs at different times is a bit messy, especially since stashing the
>> values does not buy us anything in terms of code size or clarity.
>>
>> So simply replace each reference to x25 or x26 with an adrp instruction
>> referring to idmap_pg_dir or swapper_pg_dir directly.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Nice! I agree that this makes things clearer, and as far as I can tell
> is correct, so FWIW:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks.

> Was this just for the sake of cleanup, or should we expect more head.S
> patches soon?
>

Well, there are other things that I would like to improve, but this
one was obvious, since x25/x26 were part of the effective prototype of
__enable_mmu.

In general, anything that makes these functions behave more like
ordinary AAPCS-compliant routines would be an improvement, imo. For
example, el2_setup() passing its return value in w20, and
__enable_mmu() taking its second argument in x27. But in these cases,
at least it is obvious (and documented), whereas the x25/x26 case was
not obvious at all.

Similarly, we have 'globals' in x21, x23 and x24 in head.S, but those
are only used on the primary boot path, and not part of the prototype
of any specific routine.

-- 
Ard.
