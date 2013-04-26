From: anup@brainfault.org (Anup Patel)
Date: Fri, 26 Apr 2013 11:57:57 +0530
Subject: [PATCH] ARM: KVM: Allow host virtual timer irq number to be
 different from guest virtual timer irq number
In-Reply-To: <7818033767795756654@unknownmsgid>
References: <1366879534-31578-1-git-send-email-anup.patel@linaro.org>
 <CAEDV+gLKwrxxdoB9NDBLb7CSnXL1j=O7f=2Y_ftXmLfGtTBnbA@mail.gmail.com>
 <CAFEAcA_bPHkZX00ccUFg2mUXdmrui3XeBMg-rgxtsE_4-abeiA@mail.gmail.com>
 <7818033767795756654@unknownmsgid>
Message-ID: <CAAhSdy0N4TJYLZWpkKAkvXF560uYzKGKkBe9-8iEDMdjDQKcHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 12:21 AM, Christoffer Dall
<cdall@cs.columbia.edu> wrote:
> On Apr 25, 2013, at 11:20 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 25 April 2013 19:04, Christoffer Dall <cdall@cs.columbia.edu> wrote:
>>> I prefer not hard-coding this stuff in the kernel, but let user space
>>> decide this. If we have good technical arguments not to do that (such
>>> as knowing that this is always defined per-core and not for an SoC
>>> (ARM guys?) then at least the patch should lookup the target processor
>>> and set the irq number accordingly.
>>
>> Well, this is all implementation-defined. The ARM ARM mandates
>> that the generic timers deliver a PPI, and that it must be the
>> same PPI for all processors in an MP implementation, but not which
>> PPI. The A15 and A7 happen to both be hardwired to ID27. You could
>> in theory design a core which let the SoC configure the virtual
>> timer ID (or let the guest arbitrarily program it, for that
>> matter, I suppose), though I'm not sure why you'd want to.
>>
>> I think I'd take the simple approach of saying "the timer PPI
>> is a fixed property of the guest CPU" unless somebody actually
>> builds something where it isn't fixed... (for that CPU we
>> could then define it as a feature argument to KVM_ARM_VCPU_INIT).
>>
>
> Ok, let's not bother with user space injection then, but instead of
> hard defaulting to two specific cores, please make a switch statement
> on the target CPU and log an error on init if it's an unknown core.

I agree about determing guest ppi from KVM_TARGET_xxxx in
kvm_timer_vcpu_init() but kvm_timer_vcpu_init() is called much before
kvm_vcpu_set_target() so in kvm_timer_vcpu_init() we have
vcpu->arch.target = -1 (unknown).

To handle this issue, we need to determine vcpu timer irq number when
we inject the timer irq first timer for that vcpu.

> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

-Anup
