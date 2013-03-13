From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Mar 2013 18:31:46 -0700
Subject: [PATCH] ARM: proc: Add Krait proc info
In-Reply-To: <20130308064139.GA31156@mudshark.cambridge.arm.com>
References: <1362439299-29617-1-git-send-email-sboyd@codeaurora.org>
 <20130305083421.GA19391@mudshark.cambridge.arm.com>
 <51366B9E.7010502@codeaurora.org> <5136D220.5090904@codeaurora.org>
 <20130308064139.GA31156@mudshark.cambridge.arm.com>
Message-ID: <513FD702.5010408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/13 22:41, Will Deacon wrote:
> On Wed, Mar 06, 2013 at 05:20:32AM +0000, Stephen Boyd wrote:
>> On 03/05/13 14:03, Stephen Boyd wrote:
>>> On 03/05/13 00:34, Will Deacon wrote:
>>>> I was looking at this the other day and wondered whether we could set
>>>> HWCAP_IDIV in __v7_setup, depending on ID_ISAR0[27:24]. I can't immediately
>>>> think why that would be difficult, but similarly there may well be a reason
>>>> why we assign it like this.
>>>>
>>>> Fancy taking a look?
>>> Ok I'll take a look. 
>> Hmm. I wonder if we did it this way because between version B and C of
>> DDI0406 the definition of those bits changed.
>>
>> In DDI0406B we have
>>
>>     0 - no support
>>     1 - support
>>
>> and in DDI0406C we have
>>
>>     0 - no support
>>     1 - support in Thumb
>>     2 - support in Thumb and ARM
> Well spotted, although I think this a documentation error. I've checked both
> A7 and A15 and they both advertise '2' (although r0p0 TRM for A7 also gets
> this wrong, the CPU does the right thing).

What about the Cortex-R7? When I google "ARM ISAR0" the first hit is

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0363e/Bgbfafej.html

and in there it just says 1.

> What about the Qualcomm CPUs?
>

It's set to 1 in some of our earlier Krait CPU designs, but we corrected
it later on to say 2 because the hardware actually supports the
instructions in both ARM and Thumb mode. Unfortunately, we mass produced
some of these chips that say 1 so we still need to do the same kind of
MIDR check. I'm going to send the patchset right now with all this in it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
