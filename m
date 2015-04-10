From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 10 Apr 2015 14:06:33 -0500
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
 <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
Message-ID: <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 10, 2015, at 11:10 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Fri, Apr 10, 2015 at 10:24:46AM -0500, Kumar Gala wrote:
>> On Apr 10, 2015, at 5:05 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> On Thu, Apr 09, 2015 at 12:37:06PM -0500, Kumar Gala wrote:
>>>> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
>>>> 
>>>> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
>>>> setup the boot/release addresses for the secondary CPUs.  In addition we need
>>>> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
>>>> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
>>>> firmware that does not support those methods.
>>> 
>>> And the reason is? Some guesses:
>>> 
>>> a) QC doesn't think boot interface (and cpuidle) standardisation is
>>>  worth the effort (to put it nicely)
>>> b) The hardware was available before we even mentioned PSCI
>>> c) PSCI is not suitable for the QC's SCM interface
>>> d) Any combination of the above
>>> 
>>> I strongly suspect it's point (a). Should we expect future QC hardware
>>> to do the same?
>>> 
>>> You could argue the reason was (b), though we've been discussing PSCI
>>> for at least two years and, according to QC press releases, MSM8916
>>> started sampling in 2014.
>>> 
>>> The only valid reason is (c) and if that's the case, I would expect a
>>> proposal for a new firmware interface protocol (it could be PSCI-based),
>>> well documented, that can be shared with others that may encounter the
>>> same shortcomings.
>> 
>> Does it matter?  I?ve always felt the kernel was a place of inclusion.
>> Qualcomm choose for whatever reason to not use PSCI or spin table.
>> You don?t like it, I might not like it, but it is what it is.
> 
> Yes, it matters, but only if Qualcomm wants the SoC support in mainline.
> Just because Qualcomm Inc does not want to invest in implementing a
> standard firmware interface is not a good enough reason to merge the
> kernel code.

The reason to merge the code upstream it expands functionality for a platform.  There is nothing that says when someone licenses an ARM core that they must also implement this standard.  Qualcomm choose for whatever reasons to not implement it.  There are examples on other architectures supporting non-standard platforms all the time (x86 supported Voyager and SGI VIS for a long time).  As far as I can tell you are just wanting uniformity to impose this rule.

> What if Qualcomm decides that it doesn't like DT, nor ACPI but comes up
> with yet another way to describe hardware because that's what the
> firmware provides? Should the kernel community take it? You could argue
> that this is a significant change but it's about the principle. And each
> SoC with its own non-standard boot protocol for no good reason is
> significant.

I wouldn?t argue that because we are talking about something that has an extremely small impact on the maintainability or changes to how the kernel actually functions.  Also, if Qualcomm did come up with some other means to replace DT or ACPI and felt it was worth trying to get accepted upstream, I would hope the upstream would look at it before just saying it was not using some standard.

> It's not Qualcomm Inc maintaining the kernel code but individuals like
> you and me who may or may not be sponsored by Qualcomm. And being
> sponsored by a company to do kernel maintenance work does not mean that
> said company decides what gets merged (on my side, ARM Ltd management is
> aware of this, though it's not always easy for the parties involved).

Fair enough, but you?ve not given any reasons the code isn?t maintainable.  You?ve only said you don?t like it because it doesn?t use one of the defacto ?standards?.

As you say, its individual doing the maintenance, so those individuals are not likely to have access to change firmware on a given device.  So saying go change firmware is pretty much saying we don?t want to support your platform or code upstream.

> We haven't really asked for anything difficult like hardware changes,
> such decisions are left with Qualcomm. We asked for a standard secure
> firmware interface, either an existing one or, if not suitable (with
> good arguments), to come up with a proposal for an alternative
> _standard_ interface. I don't even have the certitude that the firmware
> interface used in these patches would be consistent across Qualcomm
> SoCs, let alone being properly documented.

If and when those issues arise we can accept or reject that code.  Right now when I look at the impact to supporting this to generic arch/arm64 kernel it is either non-existant if we use the CPU_OF_TABLES or extremely minor if we just add an entry to the supported_cpu_ops struct.

> So please come up with proper technical arguments rather than the kernel
> should take whatever SoC vendors dreamt of.

There is no technical argument to be made.  This is about the community and you as maintainer wanting to accept code that complies to your decision or not.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
