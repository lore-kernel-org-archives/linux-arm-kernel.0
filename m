From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 May 2013 13:57:26 +0100
Subject: [RFC PATCH V2] ARM: EXYNOS: Fix hotplug when CPUs boot in HYP mode
In-Reply-To: <CAHuqX+GOLO_H81B3bwcqF7Sp0srctBn+6J9mbRF_kbPRTXC-ng@mail.gmail.com>
References: <1367905910-30913-1-git-send-email-giridhar.m@samsung.com>
 <CAHuqX+HUWcX_sTXKCjSQ9pR1K8obLc+T7vYK_zTn_gqO8ULPVQ@mail.gmail.com>
 <5188C18D.10103@arm.com>
 <CAHuqX+GOLO_H81B3bwcqF7Sp0srctBn+6J9mbRF_kbPRTXC-ng@mail.gmail.com>
Message-ID: <518A4BB6.5020801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/13 13:23, Giridhar Maruthy wrote:
> On 7 May 2013 14:25, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 07/05/13 06:54, Giridhar Maruthy wrote:
>>> This patch is a modification from the Christoffer Dall's u-boot
>>> patch. This is required to put the secondary processors in hyp
>>> mode during cpu hotplug when u-boot is no longer alive.
>>>
>>> Marc Zyngier suggested this logic to go into firmware or, u-boot
>>> putting a trampoline code into a page /memreserve/d by DT. But
>>> this seemed to have a problem. Once the cpu is hotplugged in
>>> runtime, the control is in ROM code and waits for event.
>>> Kernel provides a return address in kernel to which the processor
>>> jumps once it gets an event. If the control branches to the
>>> trampoline code here, this trampoline code has no kernel return
>>> address.
>>>
>>> Someone with better logic or better placement of this logic
>>> elsewhere is welcome.
>>
>> What prevents you from writing the kernel address in the memreserved
>> page? Some obvious location, like the last word of the page? You only
>> have to do it once (from the boot CPU, for example).
>>
>> Or did I miss something else?
> 
> Thanks Marc, I think I understand now.
> 
> I guess I also need to put the primary cpu boot mode into a temporary location.

Indeed. You'll need that for your secondaries to enter in the same mode
as the primary.

	M.
-- 
Jazz is not dead. It just smells funny...
