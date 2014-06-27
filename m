From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 27 Jun 2014 12:56:58 -0400
Subject: [PATCHv3 5/5] arm64: add runtime system sanity checks
In-Reply-To: <20140627095635.GB7262@leverpostej>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-6-git-send-email-mark.rutland@arm.com>
 <53AC8296.808@codeaurora.org> <20140627095635.GB7262@leverpostej>
Message-ID: <53ADA25A.4090505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 06/27/2014 05:56 AM, Mark Rutland wrote:
> On Thu, Jun 26, 2014 at 09:29:10PM +0100, Christopher Covington wrote:
>> Hi Mark,
> 
> Hi Chrisopher,
> 
>> On 06/26/2014 11:18 AM, Mark Rutland wrote:
>>> Unexpected variation in certain system register values across CPUs is an
>>> indicator of potential problems with a system. The kernel expects CPUs
>>> to be mostly identical in terms of supported features, even in systems
>>> with heterogeneous CPUs, with uniform instruction set support being
>>> critical for the correct operation of userspace.
>>>
>>> To help detect issues early where hardware violates the expectations of
>>> the kernel, this patch adds simple runtime sanity checks on important ID
>>> registers in the bring up path of each CPU.
>>>
>>> Where CPUs are fundamentally mismatched, set TAINT_CPU_OUT_OF_SPEC.
>>> Given that the kernel assumes CPUs are identical feature wise, let's not
>>> pretend that we expect such configurations to work. Supporting such
>>> configurations would require massive rework, and hopefully they will
>>> never exist.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> ---
>>>  arch/arm64/kernel/cpuinfo.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 92 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>>
>>> +	/* If different, timekeeping will be broken (especially with KVM) */
>>> +	diff |= CHECK(cntfrq, boot, cur, cpu);
>>
>> You're calling this a "CPU feature" but I thought this was purely a firmware
>> setting. Does the architecture even allow hardware to program this register?
> 
> The CNTFRQ register must be set by the firmware/bootloader on each CPU.
> While we can argue over whether this makes sense or not, it's simply the
> way the architecture works.
> 
> Feature registers can vary depending on how more prvileged levels of the
> stack have configured the CPU, and/or implementation defined signal out
> of reset.

Is this really the general case? It appears to me as though all of registers
you're checking, except for CNTFRQ, are read only at every exception level,
although I haven't checked for indirect writes.

If a field is configurable by software, I don't think TAINT_CPU_OUT_OF_SPEC is
appropriate.

> In both cases what we care about its a (mostly) uniform view of
> hardware. Perhaps "Feature" is not the correct word, but I'm having
> difficulty finding a better way of expressing the requirement.

It's the CPU part of "CPU feature" that I object to. Calling CNTFRQ a firmware
feature would be fine.

>> Additionally, in arch_timer_detect_rate it appears that a device tree setting
>> takes precedence, but you're not checking that.
> 
> While that property exists, it's a half-baked workaround and a source of
> further problems (e.g. guests seeing the wrong view of time). If
> anything I'd like to disable it for arm64; so far systems have been sane
> and there's no need to encourage new systems to be broken for no good
> reason.

Perhaps checking CNTFRQ should be moved there and TAINT_FIRMWARE_WORKAROUND used.

> This series should help people to spot and fix these issues at bringup
> time so we never have to see them out in the wild.

This is excellent.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
