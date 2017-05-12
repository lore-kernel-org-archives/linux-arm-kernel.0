From: james.morse@arm.com (James Morse)
Date: Fri, 12 May 2017 17:45:16 +0100
Subject: [PATCH V15 06/11] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <9e26f779-5eae-2558-6045-10c1afde9bf2@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-7-git-send-email-tbaicar@codeaurora.org>
 <5910AAB8.8070703@arm.com>
 <9e26f779-5eae-2558-6045-10c1afde9bf2@codeaurora.org>
Message-ID: <5915E69C.5090201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 08/05/17 20:59, Baicar, Tyler wrote:
> On 5/8/2017 11:28 AM, James Morse wrote:
>> I was tidying up the masking/unmasking in entry.S, something I wasn't aware of
>> that leads to a bug:
>> entry.S will unmask interrupts for instruction/data aborts that came from a
>> context with interrupts enabled. This makes sense for get_user() and friends...
>> For do_sea() we pull nmi_enter() as this can interrupt interrupts-masked code,
>> such as APEI, but if we end up in here with interrupts unmasked we can take an
>> IRQ from this 'NMI' context, which will inherit the in_nmi() and could lead to
>> the deadlock we were originally trying to avoid.
>>
>> Teaching entry.S to spot external aborts is messy. I think the two choices are
>> to either mask interrupts when calling nmi_enter() (as these things should be
>> mutually exclusive), or to conditionally call nmi_enter() based on
>> interrupts_enabled(regs). I prefer the second one as it matches the notify_sea()
>> while interruptible that happens when KVM takes one of these.

Thinking about this some more: the KVM case is different as we know it was a
guest that triggered the external abort. Nothing the host kernel does is likely
to trigger either the same error or a related one.

But I can't think of a way this would trip twice on the host... yes your
suggestion looks fine.

(When we add SError/SEI support too we will need to change it as SEA may
interrupt SEI, and nmi_enter() has a BUG_ON(in_nmi()), so this nesting will need
explicitly checking.)


Thanks,

James
