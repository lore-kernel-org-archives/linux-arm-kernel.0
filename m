From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 16 Dec 2017 11:44:56 +0800
Subject: [PATCH v8 7/7] arm64: kvm: handle SError Interrupt by
 categorization
In-Reply-To: <5A3419FF.30101@arm.com>
References: <1510343650-23659-1-git-send-email-gengdongjiu@huawei.com>
 <1510343650-23659-8-git-send-email-gengdongjiu@huawei.com>
 <5A0B1334.7060500@arm.com> <4af78739-99da-4056-4db1-f80bfe11081a@huawei.com>
 <5A283F26.3020507@arm.com> <4b37e86d-eee3-c51e-eceb-5d0c7ad12886@huawei.com>
 <5A3419FF.30101@arm.com>
Message-ID: <b98d911d-afc3-115b-3ba0-35b1daf63723@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2017/12/16 2:52, James Morse wrote:
>> signal, it will record the CPER and trigger a IRQ to notify guest, as shown below:
>>
>> SIGBUS_MCEERR_AR trigger Synchronous External Abort.
>> SIGBUS_MCEERR_AO trigger GPIO IRQ.
>>
>> For the SIGBUS_MCEERR_AO and SIGBUS_MCEERR_AR, we have already specify trigger method, which all
>>
>> not involve _trigger_ an SError.
> It's a policy choice. How does your virtual CPU notify RAS errors to its virtual
> software? You could use SError for SIGBUS_MCEERR_AR, it depends on what type of
> CPU you are trying to emulate.
> 
> I'd suggest using NOTIFY_SEA for SIGBUS_MCEERR_AR as it avoids problems where
> the guest doesn't take the SError immediately, instead tries to re-execute the
I agree it is better to use NOTIFY_SEA for SIGBUS_MCEERR_AR in this case.

> code KVM has unmapped from stage2 because its corrupt. (You could detect this
> happening in Qemu and try something else)For something else, using NOTIFY_SEI for SIGBUS_MCEERR_AR? At current implementation,
It seems only have this case that "KVM has unmapped from stage2", do you thing we still have something else?

> 
> 
> Synchronous/asynchronous external abort matters to the CPU, but once the error
> has been notified to software the reasons for this distinction disappear. Once
> the error has been handled, all trace of this distinction is gone.
> 
> CPER records only describe component failures. You are trying to re-create some
> state that disappeared with one of the firmware-first abstractions. Trying to
> re-create this information isn't worth the effort as the distinction doesn't
> matter to linux, only to the CPU.
> 
> 
>> so there is no chance for Qemu to trigger the SError when gets the SIGBUS_MCEERR_A{O,R}.
> You mean there is no reason for Qemu to trigger an SError when it gets a signal
> from the kernel.
> 
> The reasons the CPU might have to generate an SError don't apply to linux and
> KVM user space. User-space will never get a signal for an uncontained error, we
> will always panic(). We can't give user-space a signal for imprecise exceptions,
> as it can't return from the signal. The classes of error that are left are
> covered by polled/irq and NOTIFY_SEA.
> 
> Qemu can decide to generate RAS SErrors for SIGBUS_MCEERR_AR if it really wants
> to, (but I don't think you should, the kernel may have unmapped the page at PC
> from stage2 due to corruption).
yes, you also said you do not want to generate RAS SErrors for SIGBUS_MCEERR_AR,
so Qemu does not know in which condition to generate RAS SErrors.

> 
> I think the problem here is you're applying the CPU->software behaviour and
> choices to software->software. By the time user-space gets the error, the
> behaviour is different.
In the KVM, as a policy choice to reserve this API to specify guest ESR and drive to trigger SError is OK,
At least for Qemu it does not know in which condition to trigger it.
