From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 7 Nov 2014 16:07:22 +0100
Subject: [PATCH v3 17/19] arm64: KVM: add SGI system register trapping
In-Reply-To: <1414776414-13426-18-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-18-git-send-email-andre.przywara@arm.com>
Message-ID: <20141107150722.GS16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:52PM +0000, Andre Przywara wrote:
> While the injection of a (virtual) inter-processor interrupt (SGI)
> on a GICv2 works by writing to a MMIO register, GICv3 uses system
> registers to trigger them.
> Trap the appropriate registers on ARM64 hosts and call the SGI

Are you actually enabling the trapping here or just putting the trap
handler in place?  As I understood so far, we still configure the guest
at this point to raise an unexpected exception in the guest if it tries
to eaccess the system registers; did I get this wrong?

> handler function in the vGICv3 emulation code.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index dcc5867..cf0452e 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -165,6 +165,27 @@ static bool access_sctlr(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +/*
> + * Trapping on the GICv3 SGI system register.

Use the architecture name for the register here.

> + * Forward the request to the VGIC emulation.
> + * The cp15_64 code makes sure this automatically works
> + * for both AArch64 and AArch32 accesses.
> + */
> +static bool access_gic_sgi(struct kvm_vcpu *vcpu,
> +			   const struct sys_reg_params *p,
> +			   const struct sys_reg_desc *r)
> +{
> +	u64 val;
> +
> +	if (!p->is_write)
> +		return read_from_write_only(vcpu, p);
> +
> +	val = *vcpu_reg(vcpu, p->Rt);
> +	vgic_v3_dispatch_sgi(vcpu, val);

So do we guarantee somehow that we'll never get here if userspace didn't
successfully create a virtual GICv3?

> +
> +	return true;
> +}
> +
>  static bool trap_raz_wi(struct kvm_vcpu *vcpu,
>  			const struct sys_reg_params *p,
>  			const struct sys_reg_desc *r)
> @@ -431,6 +452,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	/* VBAR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
>  	  NULL, reset_val, VBAR_EL1, 0 },
> +	/* ICC_SGI1R_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1011), Op2(0b101),
> +	  access_gic_sgi },
>  	/* CONTEXTIDR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
>  	  access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
> @@ -659,6 +683,8 @@ static const struct sys_reg_desc cp14_64_regs[] = {
>   * register).
>   */
>  static const struct sys_reg_desc cp15_regs[] = {
> +	{ Op1( 0), CRn( 0), CRm(12), Op2( 0), access_gic_sgi },
> +
>  	{ Op1( 0), CRn( 1), CRm( 0), Op2( 0), access_sctlr, NULL, c1_SCTLR },
>  	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), access_vm_reg, NULL, c2_TTBR0 },
>  	{ Op1( 0), CRn( 2), CRm( 0), Op2( 1), access_vm_reg, NULL, c2_TTBR1 },
> -- 
> 1.7.9.5
> 
