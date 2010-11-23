From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Nov 2010 09:14:58 +0000
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
Message-ID: <AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2010 20:09, Maxim Uvarov <muvarov@gmail.com> wrote:
> 2010/11/22 Catalin Marinas <catalin.marinas@arm.com>:
>> On 22 November 2010 17:03, Per Fransson <per.fransson.ml@gmail.com> wrote:
>>> On the other hand, do we really need to enable the interrupts before
>>> performing an ipi?
>>> The important thing must be for them to be enabled on the
>>> receiving/callee cores. It's not
>>> as if we want the crashing core to be interruptable, is it?
>>
>> That's for the situation when the other core tries to send an IPI at
>> the same time. Unlikely but both cores may deadlock.
>>
>
> Am I right that deadlock can occur only if the same IPI was sent?

Not necessarily. It depends on whether the CPU issuing the IPI needs
to wait for the completion of the cross-call. If you don't need to
wait, you can send the IPI with the interrupts disabled (the platform
smp_cross_call is already called with interrupts disabled).

-- 
Catalin
