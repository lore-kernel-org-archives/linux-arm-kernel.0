From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Jan 2011 21:00:17 -0800
Subject: [PATCH] arm: mm: Poison freed init memory
In-Reply-To: <20110106090741.GQ8638@n2100.arm.linux.org.uk>
References: <1294256845-29517-1-git-send-email-sboyd@codeaurora.org>
	<20110105202645.GL8638@n2100.arm.linux.org.uk>
	<4D255263.7040106@codeaurora.org>
	<20110106090741.GQ8638@n2100.arm.linux.org.uk>
Message-ID: <4D2BE3E1.5060706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2011 01:07 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 05, 2011 at 09:25:55PM -0800, Stephen Boyd wrote:
>> On 01/05/2011 12:26 PM, Russell King - ARM Linux wrote:
>>> On Wed, Jan 05, 2011 at 11:47:25AM -0800, Stephen Boyd wrote:
>>>> Poisoning __init marked memory can be useful when tracking down
>>>> obscure memory corruption bugs. When a pointer is 0xCCCCCCCC in an
>>>
>>> That's a bad idea for a value.  With a 3GB page offset and 256MB or
>>> more memory, accesses to such an address will always succeed.
>>>
>>> There's two things to be considered when selecting a possible poison
>>> value:
>>>
>>> 1. what value is guaranteed to provoke an undefined instruction exception?
>>> 2. what value when used as an address and dereferenced is mostly always
>>>    going to abort?
>>>
>>> 1 for ARM mode implies an 0xe7fXXXfX value.  For Thumb mode 0xdeXX.  We
>>> use this space for breakpoints.
>>>
>>> 2 unfortunately depends on the platform. 
>>
>> A coworker proposed we use a SWI instruction. We could do that if the
>> poison is 0xEF and then do something in the SWI handler where that
>> number causes us to blow up?
>
> Doesn't work with EABI - the comment field in the SWI instruction is
> ignored on EABI.
>
>> If I'm following correctly, point 1 is about __init functions and point
>> 2 is about __initdata. I'm more concerned about __initdata because
>> __init functions called from non __init marked functions are usually
>> caught with section mismatch checks. Also, if we're jumping to
>> 0xCCCCCCCC we're probably not in the text section of the kernel with a
>
> But, as I pointed out, you don't know that 0xCCCCCCCC isn't a valid
> address _and_ on modern platforms it won't fault.  So it's pointless
> to use it as a poison value.

Ok it seems that 0xcc was chosen by Pavel since it's a breakpoint
instruction (sorry for not noticing that earlier [1]). There was some
discussion about handling initdata with Pavel's patch but it seems that
nothing came of it? I assume that's because we don't differentiate
between the two types of init markings.

How about we use 0xe7fddef0? This seems to satisfy at least your first
point for both ARM and Thumb mode (Thumb will branch to the 0xdef0
instruction).

[1] http://lkml.indiana.edu/hypermail/linux/kernel/0410.0/2040.html for
those interested

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
