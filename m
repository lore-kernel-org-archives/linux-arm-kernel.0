From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 22 Nov 2018 11:13:51 +0000
Subject: [RFC PATCH v2 11/23] KVM: arm64: Support runtime sysreg filtering
 for KVM_GET_REG_LIST
In-Reply-To: <20181122105344.GF17441@e113682-lin.lund.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-12-git-send-email-Dave.Martin@arm.com>
 <20181102081625.GS12057@e113682-lin.lund.arm.com>
 <20181115172711.GQ3505@e103592.cambridge.arm.com>
 <20181122105344.GF17441@e113682-lin.lund.arm.com>
Message-ID: <CAFEAcA8UEqxM7KJGm81ETgPpsO6ByK7Vc9SuCKr4FZGVU8vxxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2018 at 10:53, Christoffer Dall <christoffer.dall@arm.com> wrote:
> [Adding Peter and Alex for their view on the QEMU side]
>
> On Thu, Nov 15, 2018 at 05:27:11PM +0000, Dave Martin wrote:
>> My expectation is that KVM_ARM_SVE_CONFIG_SET is considered part of
>> creating the vcpu, so that if issued at all for a vcpu, it is issued
>> very soon after KVM_VCPU_INIT.
>>
>> I think this worked OK with the current structure of kvmtool and I
>> seem to remember discussing this with Peter Maydell re qemu -- but
>> it sounds like I should double-check.
>
> QEMU does some thing around enumerating all the system registers exposed
> by KVM and saving/restoring them as part of its startup, but I don't
> remember the exact sequence.

This all happens in kvm_arch_init_vcpu(), which does:
 * KVM_ARM_VCPU_INIT ioctl (with the appropriate kvm_init_features set)
 * read the guest MPIDR with GET_ONE_REG so we know what KVM
   is doing with MPIDR assignment across CPUs
 * check for interesting extensions like KVM_CAP_SET_GUEST_DEBUG
 * get and cache a list of what system registers the vcpu has,
   using KVM_GET_REG_LIST. This is where we do the "size must
   be U32 or U64" sanity check.

So if there's something we can't do by setting kvm_init_features
for KVM_ARM_VCPU_INIT but have to do immediately afterwards,
that is straightforward.

The major requirement for QEMU is that if we don't specifically
enable SVE in the VCPU then we must not see any registers
in the KVM_GET_REG_LIST that are not u32 or u64 -- otherwise
QEMU will refuse to start.

thanks
-- PMM
