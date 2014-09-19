From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 19 Sep 2014 09:22:10 -0400
Subject: [RFC] arm: Handle starting up in secure mode
In-Reply-To: <CAFEAcA-Z_KqCrBRKLxtEaca3jAH35Xx=CqOr36KgAGfFrE91nw@mail.gmail.com>
References: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
 <5418AA80.4090102@codeaurora.org> <54198BDE.8000509@codeaurora.org>
 <CAFEAcA-Z_KqCrBRKLxtEaca3jAH35Xx=CqOr36KgAGfFrE91nw@mail.gmail.com>
Message-ID: <541C2E02.5000303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 09/19/2014 01:56 AM, Peter Maydell wrote:
> On 17 September 2014 06:25, Christopher Covington <cov@codeaurora.org> wrote:
>> On 09/16/2014 05:24 PM, Christopher Covington wrote:
>>> On 09/16/2014 05:09 PM, Christopher Covington wrote:
>>>> ARM Linux currently has the most features available to it in hypervisor
>>>> (HYP) mode, so switch to it when possible. This can also ensure proper
>>>> reset of newer registers such as CNTVOFF.
>>>>
>>>> The permissions on the Non-Secure Access Control Register (NSACR) are
>>>> used to probe what the security setting currently is when in supervisor
>>>> (SVC) mode.
>>>
>>> Sorry, this doesn't work yet. I was misinterpreting my test results. For what
>>> it's worth, my testing and development methodology is to run it after hacked
>>> up versions of the semihosting bootwrapper on the simulator that corresponds
>>> to rtsm_ve-aemv8a.dtb (AEM VE FVP these days?) and examine the instruction traces.
>>
>> Looks like the real problem was that I was hacking up the bootwrapper
>> incorrectly--my start-in-secure-mode bootwrapper variant wasn't setting up the
>> GIC for non-secure access. With that changed, I've tested the following
>> variations using the Image file in a single core configuration.
>>
>> Start in non-secure SVC with non-secure access to GIC configured.
>>
>> Start in secure SVC with non-secure access to GIC configured.
>>
>> Start in secure SVC with non-secure access to GIC configured and hypervisor
>> support disabled in the model (-C cluster.has_el2=0). This required setting
>> the VBAR again in non-secure SVC but with that fix it seems to work. I'll
>> include this change in v2.
> 
> If you're relying on the boot loader to set up the GIC to support
> non-secure access anyway, why not just have it boot the kernel in Hyp
> like the boot protocol document recommends? (The same thing as the GIC
> is going to apply for any other hardware that needs configuration to
> allow NS access; if we need the firmware to deal with this we might as
> well just have it boot us in the right mode too.)

I'd like to get rid of as much of the bootwrapper as possible (having gotten
spoiled by using QEMU's built-in bootloader). I'm just taking it one step at a
time. Handling GIC initialization in the kernel is probably the next step.

> Incidentally, on a v7 CPU without the Security Extensions the VBAR
> doesn't exist at all, so your code is going to UNDEF at an earlier
> point than you think it is...

Thanks for pointing this out. I recently was digging through the ID registers
and figured it would be good idea to guard attempting the SVC_S -> HYP switch
with some PFR checks that Security and Virtualization extensions are
implemented just right: PFR1.Virt_fac == 1 && PFR.Sec_frac == 1. (How to
handle separate secure physical memory, PFR1.Sec_frac > 1, is a challenge I
think I'd like to defer to a later patch).

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
