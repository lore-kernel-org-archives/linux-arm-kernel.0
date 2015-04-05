From: stefan@agner.ch (Stefan Agner)
Date: Mon, 06 Apr 2015 01:50:17 +0200
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <20150405224455.GB12732@n2100.arm.linux.org.uk>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
 <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
 <20150405224455.GB12732@n2100.arm.linux.org.uk>
Message-ID: <58bb3fd4f9e9b3acc7f8b83bd6664177@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-06 00:44, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 12:19:43AM +0200, Stefan Agner wrote:
>> On 2015-04-05 18:10, Russell King - ARM Linux wrote:
>> > config ARM_SINGLE_ARMV7M
>> > 	bool "ARM architecture v7M compliant (Cortex-M0/M3/M4) SoC"
>> > 	depends on !MMU
>> > 	select ARM_NVIC
>> > 	... etc ...
>>
>> I guess that would be ARCH_SINGLE_ARMV7M?
> 
> No, I meant ARM_SINGLE_xxx
> 
>> > which then allows a /multiplatform/ v7M kernel to be built, allowing the
>> > selection of EFM32, SOC_VF610, and any other v7M compliant SoC.
>>
>> In my view, that wouldn't end up being much different than what that
>> patchset is doing:
> 
> It's different.  It's different because we are _not_ enabling multiplatform.
> Multiplatform brings with it all the MMU-full stuff that we don't want on
> !MMU.

You mean config symbols? There are 2-3 config symbols we don't want with
ARCH_MULTI_V7M and we have to exclude. But there would be also a
duplication of some already given by multiplatform when creating a new
top level config symbol...
 
> You're thinking far too specifically about V7M here.  We have other !MMU
> CPUs, such as ARM946 and ARM940 which are older generation mmuless CPUs.
> 
> The problem with the ARCH_MULTI_V7M approach is that they're V4T and V5
> CPUs, and we _really_ don't want to enable ARCH_MULTI_V4T and
> ARCH_MULTI_V5.  If we did that, we'll allow _every_ V4T and V5
> multiplatform to be selected, whether they're compatible with nommu
> or not - and whether they're compatible with each other or not.

Just from a selection view, ARM946 and ARM940 would still _not_ be
selectable because this change makes ARCH_MULTI_V4T/V5 being dependent
on MMU.

> 
> So, that kind of solution _doesn't_ scale to what we _once_ already
> allowed.
> 
>> As far as I can tell, this is already the case with that patchset.
> 
> What I'm trying to do here is to fix the cockup that the multiplatform
> conversion has created with previous generation noMMU and restore it
> back to where it should be without excluding the newer stuff from it.

Would be a partial revert (remove ARCH_MULTI_* from CPU_ARM940T and
CPU_ARM946E) of dc680b989d51 ("ARM: fix multiplatform allmodcompile") be
the right thing to do then? Given that ARCH_MULTI_V4T/V5 is MMU
dependent, those CPU's will not be selected even when building the
integrator multiplatform image... However, due to the selection
limitations outlined above, this would only be cosmetic anyway.
 
> What you're interested in is just the newer stuff.  You're approaching
> the problem from a different angle and thinking that your solution is
> the best.  I'm saying it has deficiencies.

When keeping the old CPU's out of multiplatform game properly, what
would speak against ARCH_MULTI_V7M? I still think if we allow a
multiplatform v7M image, it is cleaner to align that to the MMU
multiplatform stuff.

Maybe I don't really get the grasp of ARM_SINGLE_ARMV7M. In my
understanding it would be a new top level config symbol which kind of
merges ARCH_MULTIPLATFORM and ARCH_MULTI_V7M.

It is not my goal to enable !MMU on MULTIARCH per se. It's just that
when enabling V7M with ARCH_MULTIPLATFORM, it makes it easier to enable
the Cortex-M4 for the HMP platforms on those multiplatform only SoC's.
When creating a new config symbol on a high level, this advantage is
gone... I then could also create a top level ARCH_MXCV7M, which selects
multiplatform only ARCH_MXC.

--
Stefan
