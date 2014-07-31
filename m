From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 31 Jul 2014 18:57:39 +0200
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <53DA7583.2030504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 09/07/2014 15:55, Alex Benn?e ha scritto:
> To cleanly restore an SMP VM we need to ensure that the current pause
> state of each vcpu is correctly recorded. Things could get confused if
> the CPU starts running after migration restore completes when it was
> paused before it state was captured.
> 
> I've done this by exposing a register (currently only 1 bit used) via
> the GET/SET_ONE_REG logic to pass the state between KVM and the VM
> controller (e.g. QEMU).
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  arch/arm64/include/uapi/asm/kvm.h |  8 +++++
>  arch/arm64/kvm/guest.c            | 61 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)

Since it's a pseudo register anyway, would it make sense to use the
existing KVM_GET/SET_MP_STATE ioctl interface?

How is this represented within QEMU in TCG mode?  Also, how is KVM/ARM
representing (and passing to QEMU) the halted state of the VCPU?

Paolo
