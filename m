From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Nov 2013 10:51:21 -0800
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <20131108165437.GM16735@n2100.arm.linux.org.uk>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqJ9zbJFJePk2FHH8UhrUP2J7fuuiZLb+NhuTovRodqrCA@mail.gmail.com>
 <20131108115004.GH28304@ns203013.ovh.net>
 <20131108165437.GM16735@n2100.arm.linux.org.uk>
Message-ID: <527D32A9.2060603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 08:54, Russell King - ARM Linux wrote:
> On Fri, Nov 08, 2013 at 12:50:04PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 19:34 Thu 07 Nov     , Rob Herring wrote:
>>> On Thu, Nov 7, 2013 at 1:20 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>>> If we're running on a v7 ARM CPU, detect if the CPU supports the
>>>> sdiv/udiv instructions and replace the signed and unsigned
>>>> division library functions with an sdiv/udiv instruction.
>>> [snip]
>>>
>>>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>>>> index bd454b0..6ed6496 100644
>>>> --- a/arch/arm/lib/Makefile
>>>> +++ b/arch/arm/lib/Makefile
>>>> @@ -15,6 +15,9 @@ lib-y         := backtrace.o changebit.o csumipv6.o csumpartial.o   \
>>>>                    io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
>>>>                    call_with_stack.o
>>>>
>>>> +lib-$(CONFIG_CPU_V7) += div-v7.o
>>>> +CFLAGS_div-v7.o := -march=armv7-a
>>> Won't this fail to build if the compiler doesn't have armv7-a support.
>>> Perhaps we don't care about compilers that old.
>> use the propoer compiler to compile a armv7 kernel
> It's probably about time to get rid of the conditionals for this in
> the main arch/arm/Makefile actually - some of those date back some
> 10 or so years.  That's something for the v3.14 merge window.

I'll take that as an endorsement for not falling back to -march=armv5t
-Wa,-march=armv7-a like is done in arch/arm/Makefile.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
