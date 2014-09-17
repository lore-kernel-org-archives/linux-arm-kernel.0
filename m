From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 17 Sep 2014 09:25:50 -0400
Subject: [RFC] arm: Handle starting up in secure mode
In-Reply-To: <5418AA80.4090102@codeaurora.org>
References: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
 <5418AA80.4090102@codeaurora.org>
Message-ID: <54198BDE.8000509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 05:24 PM, Christopher Covington wrote:
> On 09/16/2014 05:09 PM, Christopher Covington wrote:
>> ARM Linux currently has the most features available to it in hypervisor
>> (HYP) mode, so switch to it when possible. This can also ensure proper
>> reset of newer registers such as CNTVOFF.
>>
>> The permissions on the Non-Secure Access Control Register (NSACR) are
>> used to probe what the security setting currently is when in supervisor
>> (SVC) mode.
> 
> Sorry, this doesn't work yet. I was misinterpreting my test results. For what
> it's worth, my testing and development methodology is to run it after hacked
> up versions of the semihosting bootwrapper on the simulator that corresponds
> to rtsm_ve-aemv8a.dtb (AEM VE FVP these days?) and examine the instruction traces.

Looks like the real problem was that I was hacking up the bootwrapper
incorrectly--my start-in-secure-mode bootwrapper variant wasn't setting up the
GIC for non-secure access. With that changed, I've tested the following
variations using the Image file in a single core configuration.

Start in non-secure SVC with non-secure access to GIC configured.

Start in secure SVC with non-secure access to GIC configured.

Start in secure SVC with non-secure access to GIC configured and hypervisor
support disabled in the model (-C cluster.has_el2=0). This required setting
the VBAR again in non-secure SVC but with that fix it seems to work. I'll
include this change in v2.

I have not been able to start up the bootwrapper with secure monitor support
disabled in the model (-C cluster.has_el3=0) because of faults during GIC
configuration.

So, any thoughts on the code? I have some questions.

What initialization am I missing?

What's the right ifdefery? I'm thinking a CONFIG_ARM_SEC_EXT that is
independent of CONFIG_ARM_VIRT_EXT.

Are there folks who want to run Linux in secure mode? Would documenting in
Kconfig that they can do this by leaving CONFIG_ARM_SEC_EXT undefined be
sufficient support for this?

Is it fine or bad to leave the CPU in undefined mode when one of the extension
or privileged operations fails? It's only for maybe a dozen instructions until
safe_svcmode_maskall.

How should CPU mode recording be handled? Should the CONFIG_ARM_SEC_EXT code
set __boot_cpu_mode with an extra bit specifying the security setting and then
the CONFIG_ARM_VIRT_EXT code set-if-unset?

What should the secure monitor stub leave behind? Right now it's different
than the hypervisor stub: put the address of the code you want run in monitor
mode into r4, make the secure monitor call, and make sure your code makes an
exception return when finished.

Whatever is left behind, I think it should allow the GIC driver to enable
non-secure access to the hardware if Linux was booted in secure mode.

If this code can be evolved and tested to the point where it's mergeable, then
Linux can finally interact intelligently with the features introduced by the
security extensions and only has to depend on firmware and bootloaders getting
the implementation defined aspects of a system right, taking care of the
architectually specified stuff itself when sufficiently privileged. Among
other things, this should lead towards the bootwrapper no longer being
required to boot Linux on ARM's virtual platforms, which would make my life
easier.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
