From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Sep 2014 13:33:03 -0700
Subject: [PATCH v2] clocksource: arch_timer: Allow the device tree to
 specify the physical timer
In-Reply-To: <20140915111055.GD1577@arm.com>
References: <1410452204-7277-1-git-send-email-dianders@chromium.org>
 <20140911164710.GW6158@arm.com> <5411D528.4050605@arm.com>
 <CAD=FV=XMmizxJFPj0FEhJ7Gk4ZcQaUJDxf_Qq5kGKSvxDFVmzg@mail.gmail.com>
 <5411DA67.2040402@arm.com>
 <CAD=FV=UQfo4J3P4wGjOhQZQ5KXKgYAdjPsi1ykKZxQw-FwJz8w@mail.gmail.com>
 <5411DF5D.8060906@arm.com> <5412DC48.7030708@codeaurora.org>
 <5412E3BB.9030800@arm.com> <54134291.3040700@codeaurora.org>
 <20140915111055.GD1577@arm.com>
Message-ID: <54174CFF.7050504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/14 04:10, Catalin Marinas wrote:
> On Fri, Sep 12, 2014 at 07:59:29PM +0100, Stephen Boyd wrote:
>> On 09/12/14 05:14, Marc Zyngier wrote:
>>> We surely can handle the UNDEF and do something there. We just can't do
>>> it the way Doug described it above.
>> I suggested doing that for something else a while ago and Will and Dave
>> we're not thrilled[1]. The suggestion back then was to use DT to
>> indicate what mode the kernel is running in.
>>
>> [1]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/105321.html
> I think the context was slightly different. As I re-read the thread, it
> seems that the discussion was around whether to use some SMC interface
> or not based on whether the kernel is running secure or non-secure. The
> argument made by Will was to actually specify the type of the firmware
> SMC interface in the DT and use it in the kernel (and probably assume
> the kernel is running in secure mode if no smc interface is specified in
> the DT; you could have both though, running in secure mode and also
> having firmware).
>
> In this arch timer case, we need to work around a firmware bug (or
> feature as 32-bit ARM kernels never required CNTVOFF initialisation by
> firmware, no matter how small such firmware is). We don't expect a
> specific SMC call to initialise CNTVOFF, so we can't describe it in the
> DT.

Agreed, we can't described SMC calls that don't exist. From my
perspective it's just another part of the cpu boot sequence that needs
to be handled in the kernel, so describing the requirement via the
cpu-boot method seems appropriate. It seems like we're making it harder
than it should be by handling the undef when we could have slightly
different SMP boot code (and suspend/resume code) depending on the boot
method property.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
