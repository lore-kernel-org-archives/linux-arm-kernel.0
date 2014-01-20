From: anup@brainfault.org (Anup Patel)
Date: Mon, 20 Jan 2014 17:30:40 +0530
Subject: [RFC PATCH 2/3] arm64: KVM: trap VM system registers until MMU
 and caches are ON
In-Reply-To: <1389970993-19371-3-git-send-email-marc.zyngier@arm.com>
References: <1389970993-19371-1-git-send-email-marc.zyngier@arm.com>
 <1389970993-19371-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAAhSdy1iwc2ZBoPO9KXJzzaEQz-SWpYXkkRvjyRjQPdPe31chQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 8:33 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> In order to be able to detect the point where the guest enables
> its MMU and caches, trap all the VM related system registers.
>
> Once we see the guest enabling both the MMU and the caches, we
> can go back to a saner mode of operation, which is to leave these
> registers in complete control of the guest.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h |  3 ++-
>  arch/arm64/kvm/sys_regs.c        | 58 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index c98ef47..fd0a651 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -62,6 +62,7 @@
>   * RW:         64bit by default, can be overriden for 32bit VMs
>   * TAC:                Trap ACTLR
>   * TSC:                Trap SMC
> + * TVM:                Trap VM ops (until M+C set in SCTLR_EL1)
>   * TSW:                Trap cache operations by set/way
>   * TWE:                Trap WFE
>   * TWI:                Trap WFI
> @@ -74,7 +75,7 @@
>   * SWIO:       Turn set/way invalidates into set/way clean+invalidate
>   */
>  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
> -                        HCR_BSU_IS | HCR_FB | HCR_TAC | \
> +                        HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | \
>                          HCR_AMO | HCR_IMO | HCR_FMO | \
>                          HCR_SWIO | HCR_TIDCP | HCR_RW)
>  #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 02e9d09..5e92b9e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -121,6 +121,42 @@ done:
>  }
>
>  /*
> + * Generic accessor for VM registers. Only called as long as HCR_TVM
> + * is set.
> + */
> +static bool access_vm_reg(struct kvm_vcpu *vcpu,
> +                         const struct sys_reg_params *p,
> +                         const struct sys_reg_desc *r)
> +{
> +       BUG_ON(!p->is_write);
> +
> +       vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
> +       return true;
> +}
> +
> +/*
> + * SCTLR_EL1 accessor. Only called as long as HCR_TVM is set.  If the
> + * guest enables the MMU, we stop trapping the VM sys_regs and leave
> + * it in complete control of the caches.
> + */
> +static bool access_sctlr_el1(struct kvm_vcpu *vcpu,
> +                            const struct sys_reg_params *p,
> +                            const struct sys_reg_desc *r)
> +{
> +       unsigned long val;
> +
> +       BUG_ON(!p->is_write);
> +
> +       val = *vcpu_reg(vcpu, p->Rt);
> +       vcpu_sys_reg(vcpu, r->reg) = val;
> +
> +       if ((val & (0b101)) == 0b101)   /* MMU+Caches enabled? */
> +               vcpu->arch.hcr_el2 &= ~HCR_TVM;
> +
> +       return true;
> +}
> +
> +/*
>   * We could trap ID_DFR0 and tell the guest we don't support performance
>   * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
>   * NAKed, so it will read the PMCR anyway.
> @@ -185,32 +221,32 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>           NULL, reset_mpidr, MPIDR_EL1 },
>         /* SCTLR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b000),
> -         NULL, reset_val, SCTLR_EL1, 0x00C50078 },
> +         access_sctlr_el1, reset_val, SCTLR_EL1, 0x00C50078 },

This patch in its current form breaks Aarch32 VMs on Foundation v8 Model
because encoding for Aarch64 VM registers we get Op0=0b11 and for Aarch32
VM registers we get Op0=0b00 when trapped.

Either its a Foundation v8 Model bug or we need to add more enteries in
sys_reg_desc[] for Aarch32 VM registers with Op0=0b00.

>         /* CPACR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b010),
>           NULL, reset_val, CPACR_EL1, 0 },
>         /* TTBR0_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b000),
> -         NULL, reset_unknown, TTBR0_EL1 },
> +         access_vm_reg, reset_unknown, TTBR0_EL1 },
>         /* TTBR1_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b001),
> -         NULL, reset_unknown, TTBR1_EL1 },
> +         access_vm_reg, reset_unknown, TTBR1_EL1 },
>         /* TCR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b010),
> -         NULL, reset_val, TCR_EL1, 0 },
> +         access_vm_reg, reset_val, TCR_EL1, 0 },
>
>         /* AFSR0_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b000),
> -         NULL, reset_unknown, AFSR0_EL1 },
> +         access_vm_reg, reset_unknown, AFSR0_EL1 },
>         /* AFSR1_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b001),
> -         NULL, reset_unknown, AFSR1_EL1 },
> +         access_vm_reg, reset_unknown, AFSR1_EL1 },
>         /* ESR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0010), Op2(0b000),
> -         NULL, reset_unknown, ESR_EL1 },
> +         access_vm_reg, reset_unknown, ESR_EL1 },
>         /* FAR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0110), CRm(0b0000), Op2(0b000),
> -         NULL, reset_unknown, FAR_EL1 },
> +         access_vm_reg, reset_unknown, FAR_EL1 },
>         /* PAR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b0111), CRm(0b0100), Op2(0b000),
>           NULL, reset_unknown, PAR_EL1 },
> @@ -224,17 +260,17 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>
>         /* MAIR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
> -         NULL, reset_unknown, MAIR_EL1 },
> +         access_vm_reg, reset_unknown, MAIR_EL1 },
>         /* AMAIR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0011), Op2(0b000),
> -         NULL, reset_amair_el1, AMAIR_EL1 },
> +         access_vm_reg, reset_amair_el1, AMAIR_EL1 },
>
>         /* VBAR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
>           NULL, reset_val, VBAR_EL1, 0 },
>         /* CONTEXTIDR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
> -         NULL, reset_val, CONTEXTIDR_EL1, 0 },
> +         access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
>         /* TPIDR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b100),
>           NULL, reset_unknown, TPIDR_EL1 },
> --
> 1.8.3.4
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

Regards,
Anup
