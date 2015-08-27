From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 27 Aug 2015 16:28:12 +0100
Subject: [PATCH] arm: Handle starting up in secure mode
In-Reply-To: <55DDCAFB.60602@codeaurora.org>
References: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
 <20150826103940.GD6281@e103592.cambridge.arm.com>
 <20150826104839.GC21084@n2100.arm.linux.org.uk>
 <55DDCAFB.60602@codeaurora.org>
Message-ID: <20150827152812.GE6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 10:19:39AM -0400, Christopher Covington wrote:
> Hi,
> 
> Thank you for the feedback.
> 
> On 08/26/2015 06:48 AM, Russell King - ARM Linux wrote:
> > On Wed, Aug 26, 2015 at 11:39:42AM +0100, Dave Martin wrote:
> >> On Mon, Aug 24, 2015 at 09:55:26AM -0400, Christopher Covington wrote:
> >>> ARM Linux appears to have never been made aware of the ARMv7 security
> >>> extensions. When CONFIG_ARM_SEC_EXT=y, have it probe for its security
> >>> state by checking whether CNTFRQ is writeable and potentially make
> >>> mode changes based on the information. The most features are available
> >>> from hypervisor (HYP) mode, so switch to it possible. Failing that,
> >>> prefer non-secure supervisor (SVC) mode to secure supervisor mode.
> >>
> >> Up to now we've steered clear of this, since it's a bit of a fig leaf
> >> for broken firmware unless Linux actually has some valid use for the
> >> Security Extensions itself.
> >>
> >> Shouldn't the bootloader or firmware be doing this stuff, and if not,
> >> why not?
> 
> In my opinion, it is sometimes useful, particularly when running on simulators
> or performing bring up, to have as little dependency on firmwares and
> bootloaders as possible. I want to run Linux out of reset, or get as close to

Definitely :)  That's exactly why the bootwrapper exists.

> that as possible. I want an ease of use comparable to QEMU's Linux loader on
> other simulators, like ARM's RTSM/AEM/FVPs, without various different,
> fragmented model plugins or the overhead and noise of the semihosting
> bootwrapper. I have attempted to craft the patches in such a way that the
> enjoyment of sophisticated firmwares and bootloaders remains unhindered.
> 
> >> Some other things that would need to be considered in any case:
> >>
> >>  * SoC-specific setup of the Non-secure view of the system:  This has
> >>    to happen very early, so making it DT aware is going to be hard --
> >>    failing that, we are effectively risking bringing back board files.
> >>    The split in responsibility between firmware/bootloader and kernel
> >>    needs to be clearly defined and (as far as possible) platform-
> >>    independent, otherwise we'll have total chaos.
> 
> My intention was to only perform architecturally defined initialization. All
> implementation defined specifics would remain delegated to firmware, simulator
> reset state hacks, or external debuggers, as the case may be. Note that using
> this code does not preclude running firmware, just that if you want Linux to
> do the exception level/mode transitions, you can omit those instructions from
> firmware. I'll have to refresh my memory--it's been a while since I worked on
> this, I apologize--but I think I used a modified bootwrapper to still perform
> its usual GIC initialization.

This is really just moving what is probably the smallest and simplest
piece of the initialisation problem into the kernel.  Only in trivial
cases that don't involve real hardware is this going to remove the need
for firmware.

In the general case, the S->NS switch cannot be done without platform-
specific knowledge of both the S and NS physical views of the system.
But except for switching to NS, the kernel isn't going to use the knowledge
about the S view.


It would be interesting to see what the amended Documentation/arm/Booting
would look like...

My worry is that this even if this is handy for development, it will
introduce a new kernel boot protocol that is impossible to standardise.
Nonethess, vendors in a hurry will be tempted to use it if it's there.

[...]

Cheers
---Dave

> 
> >>  * Out of reset, generally the CPU state is only fully defined for the
> >>    highest exception level.  You probably need to be doing more setup
> >>    than you're currently doing.
> 
> Agreed. This is just the first step.
> 
> >>  * SMP, secondary boot and suspend/resume -- again involving board-
> >>    specific code.
> 
> I've only tested single core so far, but I was thinking external debuggers and
> simulators may be able to emulate PSCI in a semihosting-like manner, if
> merging holding pen code is as frowned upon as I think it is (that may be an
> AArch64-specific statement, but it'd probably be nice if similar facilities
> were available across A32 and A64).
> 
> >>  * You need to safely "park" the Secure World before running anything
> >>    in Non-Secure.  As a minimum, you would need to quiesce any
> >>    Secure interrupt sources, disable all interrupt traps to Monitor
> >>    mode, and make sure that the Monitor vectors point somewhere
> >>    real, so that executing SMC doesn't send the CPU off into the
> >>    long grass...
> 
> Thanks. I'll work towards support for these aspects in the next version.
> 
> > Another question is: has this been tested with kexec?
> 
> I have not tested it with kexec. My testing was mostly of cold boots performed
> some time back on ARM's AEM/RSTM/FVP using its configurable parameters and
> some simple custom firmwares to simulate entry under all the circumstances I
> could think of. I grepped instruction traces to make sure the initial mode
> after firmware was as intended and then that AArch32 Linux switched into the
> intended mode.
> 
> EL3: not present, AArch64, AArch32
> EL2: not present, AArch64, AArch32
> AArch32 Linux starts in: svc_s, svc_n, hyp_n, mon_s
> 
> By my calculations, there were 36 - 17 = 19 valid combinations.
> 
> Thanks,
> Christopher Covington
> 
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
