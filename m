From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 31 Jul 2014 18:04:30 +0100
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <53DA7583.2030504@redhat.com>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <53DA7583.2030504@redhat.com>
Message-ID: <CAFEAcA9cT617t8JqOXtuO-wQ5xg5T3Sw_DUHB1fpPD6g3SSNaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 17:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 09/07/2014 15:55, Alex Benn?e ha scritto:
>> To cleanly restore an SMP VM we need to ensure that the current pause
>> state of each vcpu is correctly recorded. Things could get confused if
>> the CPU starts running after migration restore completes when it was
>> paused before it state was captured.
>>
>> I've done this by exposing a register (currently only 1 bit used) via
>> the GET/SET_ONE_REG logic to pass the state between KVM and the VM
>> controller (e.g. QEMU).
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h |  8 +++++
>>  arch/arm64/kvm/guest.c            | 61 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> Since it's a pseudo register anyway, would it make sense to use the
> existing KVM_GET/SET_MP_STATE ioctl interface?

That appears to be an x86-specific thing relating to
IRQ chips.

> How is this represented within QEMU in TCG mode?

We don't implement it in TCG yet; Rob Herring has posted
patches but they had a few minor issues (didn't compile
on non-Linux hosts). The answer will be 'in a "bool powered_off"
flag in struct ARMCPU'.

> Also, how is KVM/ARM
> representing (and passing to QEMU) the halted state of the
> VCPU?

We don't. In ARM the equivalent of x86 HLT (which is
WFI, wait-for-interrupt) is allowed to resume at any time.
So we don't need to care about saving and restoring
whether we were sat in a WFI at point of migration.

thanks
-- PMM
