From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 22 Nov 2018 13:34:24 +0100
Subject: [RFC PATCH v2 11/23] KVM: arm64: Support runtime sysreg
 filtering for KVM_GET_REG_LIST
In-Reply-To: <CAFEAcA8UEqxM7KJGm81ETgPpsO6ByK7Vc9SuCKr4FZGVU8vxxg@mail.gmail.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-12-git-send-email-Dave.Martin@arm.com>
 <20181102081625.GS12057@e113682-lin.lund.arm.com>
 <20181115172711.GQ3505@e103592.cambridge.arm.com>
 <20181122105344.GF17441@e113682-lin.lund.arm.com>
 <CAFEAcA8UEqxM7KJGm81ETgPpsO6ByK7Vc9SuCKr4FZGVU8vxxg@mail.gmail.com>
Message-ID: <20181122123424.GG17441@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 11:13:51AM +0000, Peter Maydell wrote:
> On 22 November 2018 at 10:53, Christoffer Dall <christoffer.dall@arm.com> wrote:
> > [Adding Peter and Alex for their view on the QEMU side]
> >
> > On Thu, Nov 15, 2018 at 05:27:11PM +0000, Dave Martin wrote:
> >> My expectation is that KVM_ARM_SVE_CONFIG_SET is considered part of
> >> creating the vcpu, so that if issued at all for a vcpu, it is issued
> >> very soon after KVM_VCPU_INIT.
> >>
> >> I think this worked OK with the current structure of kvmtool and I
> >> seem to remember discussing this with Peter Maydell re qemu -- but
> >> it sounds like I should double-check.
> >
> > QEMU does some thing around enumerating all the system registers exposed
> > by KVM and saving/restoring them as part of its startup, but I don't
> > remember the exact sequence.
> 
> This all happens in kvm_arch_init_vcpu(), which does:
>  * KVM_ARM_VCPU_INIT ioctl (with the appropriate kvm_init_features set)
>  * read the guest MPIDR with GET_ONE_REG so we know what KVM
>    is doing with MPIDR assignment across CPUs
>  * check for interesting extensions like KVM_CAP_SET_GUEST_DEBUG
>  * get and cache a list of what system registers the vcpu has,
>    using KVM_GET_REG_LIST. This is where we do the "size must
>    be U32 or U64" sanity check.
> 
> So if there's something we can't do by setting kvm_init_features
> for KVM_ARM_VCPU_INIT but have to do immediately afterwards,
> that is straightforward.
> 
> The major requirement for QEMU is that if we don't specifically
> enable SVE in the VCPU then we must not see any registers
> in the KVM_GET_REG_LIST that are not u32 or u64 -- otherwise
> QEMU will refuse to start.
> 

So on migration, will you have the required information for
KVM_ARM_VCPU_INIT before setting the registers from the migration
stream?

(I assume so, because presumably this comes from a command-line switch
or from the machine definition, which must match the source.)

Therefore, I don't think there's an issue with this patch, but from
bitter experience I think we should enforce ordering if possible.


Thanks,

    Christoffer
