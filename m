From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 1 Jun 2018 15:21:11 +0800
Subject: [PATCH v1 2/2] arm64: handle NOTIFY_SEI notification by the APEI
 driver
In-Reply-To: <71afa669-e3c5-979e-da5b-1d9cb7056fd6@arm.com>
References: <1527770506-8076-1-git-send-email-gengdongjiu@huawei.com>
 <1527770506-8076-3-git-send-email-gengdongjiu@huawei.com>
 <20180531110115.uglmicy3nzwfoyx3@lakrids.cambridge.arm.com>
 <71afa669-e3c5-979e-da5b-1d9cb7056fd6@arm.com>
Message-ID: <f000549e-bd9c-323d-bcf9-04c2df029670@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, James,
   Thanks the review.

On 2018/6/1 0:51, James Morse wrote:
> Hi Mark, Dongjiu Geng,
> 
> On 31/05/18 12:01, Mark Rutland wrote:
>> In do_serror() we already handle nmi_{enter,exit}(), so there's no need
>> for that here.
> 
> Even better: nmi_enter() has a BUG_ON(in_nmi()).

There are two places call the arm64_is_fatal_ras_serror():
1. do_serror()
2. kvm_handle_guest_serror()

Yes, the do_serror() already handle nmi_{enter,exit}(), so the arm64_is_fatal_ras_serror() does not need to handle it again.
For the kvm_handle_guest_serror(), it does not handle the nmi_{enter,exit}(), so should we add nmi_{enter,exit}() in  kvm_handle_guest_serror() before calling arm64_is_fatal_ras_serror()?

For the NOTIFY_SEA, I do not know why handle_guest_sea() does not handle the nmi_{enter,exit}(). James, does we miss it in handle_guest_sea()?

> 
> 
>> TBH, I don't understand why do_sea() does that conditionally today.
>> Unless there's some constraint I'm missing, 
> 
> APEI uses a different fixmap entry and locks when in_nmi(). This was because we
> may interrupt the irq-masked region in APEI that was using the regular memory.
> (e.g. the 'polled' notification, or something backed by an interrupt.) But,
> Borislav has spotted other things in here that are broken[0]. I'm working on
> rolling all that into 'v5' of the in_nmi() rework stuff.
> 
> We currently get away with this on arm because 'SEA' is the only NMI-like thing,
> and it occurs synchronously. The problem cases are all also cases where the
> kernel text is corrupt, which we can't possibly hope to handle.
> 
> For NOTIFY_SDEI and NOTIFY_SEI this is the wrong pattern as these are
> asynchronous. do_serror() has already done most of the work for NOTIFY_SEI, but
> we need to use the estatus queue in APEI, which is currently x86 only.
I think this patch can based on you 'v5' of the in_nmi() rework stuff

> 
> 
>> I think it would make more
>> sense to do that regardless of whether the interrupted context had
>> interrupts enabled. James -- does that make sense to you?
>>
>> If you update the prior patch with a stub for !CONFIG_ACPI_APEI_SEI, you
>> can simplify all of the above additions down to:
>>
>> 	if (!ghes_notify_sei())
>> 		return;
>>
>> ... which would look a lot nicer.
> 
> The code that calls ghes_notify_sei() may need calling by KVM too, but its
> default action to an 'unclaimed' SError will be different.
> Because of the race between memory_failure() and return-to-userspace, we may
> need to kick the irq work queue (if we can), as we return from do_serror(). [1]
> and [2] provide an example for NOTIFY_SEA. SDEI does this by returning to the
> kernel through the IRQ handler, (which handles the KVM case too).
I can kick the IRQ work queue as you do for the NOTIFY_SEA and NOTIFY_SDEI.

> 
> 
> I think this series is unsafe until we can use the estatus queue in APEI. Its
> also missing the handling for an SError interrupting a KVM guest.

how about this series is based on your patches that uses the estatus queue in APEI to make it safe?

when an SError interrupting a KVM guest, it will trap to hypervisor, hypervisor will call
below software stack to handle it:
kvm_handle_guest_serror()->arm64_is_fatal_ras_serror()->ghes_notify_sei()

so it already handles the case that an SError interrupting a KVM guest.

> 
> 
> Thanks,
> 
> James
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg653332.html
> [1] https://www.spinics.net/lists/arm-kernel/msg649237.html
> [2] https://www.spinics.net/lists/arm-kernel/msg649239.html
> 
> .
> 
