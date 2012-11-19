From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 15:01:05 +0000
Subject: [PATCH v4 09/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <20121110154313.2836.2851.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154313.2836.2851.stgit@chazy-air>
Message-ID: <20121119150105.GB3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:43:13PM +0000, Christoffer Dall wrote:
> Adds a new important function in the main KVM/ARM code called
> handle_exit() which is called from kvm_arch_vcpu_ioctl_run() on returns
> from guest execution. This function examines the Hyp-Syndrome-Register
> (HSR), which contains information telling KVM what caused the exit from
> the guest.
> 
> Some of the reasons for an exit are CP15 accesses, which are
> not allowed from the guest and this commit handles these exits by
> emulating the intended operation in software and skipping the guest
> instruction.
> 
> Minor notes about the coproc register reset:
> 1) We reserve a value of 0 as an invalid cp15 offset, to catch bugs in our
>    table, at cost of 4 bytes per vcpu.
> 
> 2) Added comments on the table indicating how we handle each register, for
>    simplicity of understanding.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

[...]

> diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
> new file mode 100644
> index 0000000..55cb4a3
> --- /dev/null
> +++ b/arch/arm/kvm/coproc_a15.c
> @@ -0,0 +1,164 @@
> +/*
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Authors: Rusty Russell <rusty@rustcorp.au>
> + *          Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +#include <linux/kvm_host.h>
> +#include <asm/cputype.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_host.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_coproc.h>
> +#include <linux/init.h>
> +
> +#define MPIDR_CPUID    0x3

This should probably be 0xff and also use the macros that Lorenzo is
introducing:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132977.html

> +
> +static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
> +{
> +       /*
> +        * Compute guest MPIDR:
> +        * (Even if we present only one VCPU to the guest on an SMP
> +        * host we don't set the U bit in the MPIDR, or vice versa, as
> +        * revealing the underlying hardware properties is likely to
> +        * be the best choice).
> +        */
> +       vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_CPUID)
> +               | (vcpu->vcpu_id & MPIDR_CPUID);
> +}
> +
> +#include "coproc.h"
> +
> +/* A15 TRM 4.3.28: RO WI */
> +static bool access_actlr(struct kvm_vcpu *vcpu,
> +                        const struct coproc_params *p,
> +                        const struct coproc_reg *r)
> +{
> +       if (p->is_write)
> +               return ignore_write(vcpu, p);
> +
> +       *vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c1_ACTLR];
> +       return true;
> +}
> +
> +/* A15 TRM 4.3.60: R/O. */
> +static bool access_cbar(struct kvm_vcpu *vcpu,
> +                       const struct coproc_params *p,
> +                       const struct coproc_reg *r)
> +{
> +       if (p->is_write)
> +               return write_to_read_only(vcpu, p);
> +       return read_zero(vcpu, p);
> +}
> +
> +/* A15 TRM 4.3.48: R/O WI. */
> +static bool access_l2ctlr(struct kvm_vcpu *vcpu,
> +                         const struct coproc_params *p,
> +                         const struct coproc_reg *r)
> +{
> +       if (p->is_write)
> +               return ignore_write(vcpu, p);
> +
> +       *vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c9_L2CTLR];
> +       return true;
> +}
> +
> +static void reset_l2ctlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
> +{
> +       u32 l2ctlr, ncores;
> +
> +       asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> +       l2ctlr &= ~(3 << 24);
> +       ncores = atomic_read(&vcpu->kvm->online_vcpus) - 1;
> +       l2ctlr |= (ncores & 3) << 24;
> +
> +       vcpu->arch.cp15[c9_L2CTLR] = l2ctlr;
> +}
> +
> +static void reset_actlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
> +{
> +       u32 actlr;
> +
> +       /* ACTLR contains SMP bit: make sure you create all cpus first! */
> +       asm volatile("mrc p15, 0, %0, c1, c0, 1\n" : "=r" (actlr));
> +       /* Make the SMP bit consistent with the guest configuration */
> +       if (atomic_read(&vcpu->kvm->online_vcpus) > 1)
> +               actlr |= 1U << 6;
> +       else
> +               actlr &= ~(1U << 6);
> +
> +       vcpu->arch.cp15[c1_ACTLR] = actlr;
> +}
> +
> +/* A15 TRM 4.3.49: R/O WI (even if NSACR.NS_L2ERR, a write of 1 is ignored). */
> +static bool access_l2ectlr(struct kvm_vcpu *vcpu,
> +                          const struct coproc_params *p,
> +                          const struct coproc_reg *r)
> +{
> +       if (p->is_write)
> +               return ignore_write(vcpu, p);
> +
> +       *vcpu_reg(vcpu, p->Rt1) = 0;
> +       return true;
> +}
> +
> +/*
> + * A15-specific CP15 registers.
> + * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
> + */
> +static const struct coproc_reg a15_regs[] = {
> +       /* MPIDR: we use VMPIDR for guest access. */
> +       { CRn( 0), CRm( 0), Op1( 0), Op2( 5), is32,
> +                       NULL, reset_mpidr, c0_MPIDR },
> +
> +       /* SCTLR: swapped by interrupt.S. */
> +       { CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
> +                       NULL, reset_val, c1_SCTLR, 0x00C50078 },

Why is the SCTLR included here as an A15-specific register?

Will
