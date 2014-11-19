From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Nov 2014 09:47:14 +0100
Subject: [PATCH] arm/arm64: KVM: Handle traps of ICC_SRE_EL1 as RAZ/WI
In-Reply-To: <1415822474-17398-1-git-send-email-christoffer.dall@linaro.org>
References: <1415822474-17398-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAKv+Gu8C7KuUpv_UdMvnitb16KhoCHceTuLObrmR7GtQ-a5JDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2014 21:01, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> When running on a system with a GICv3, we currenly don't allow the guest
> to access the system register interface of the GICv3.  We do this by
> clearing the ICC_SRE_EL2.Enable, which causes all guest accesses to
> ICC_SRE_EL1 to trap to EL2 and causes all guest accesses to other ICC_
> registers to cause an undefined exception in the guest.
>
> However, we currently don't handle the trap of guest accesses to
> ICC_SRE_EL1 and will spill out a warning.  The trap just needs to handle
> the access as RAZ/WI, and a guest that tries to prod this register and
> set ICC_SRE_EL1.SRE=1, must read back the value (which Linux already
> does) to see if it succeeded, and will thus observe that ICC_SRE_EL1.SRE
> was not set.
>
> Add the simple trap handler in the sorted table of the system registers.
>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---

Hi,

What is the status of this patch? Will you try to merge it as a bug fix?

-- 
Ard.


>  arch/arm64/kvm/sys_regs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 4cc3b71..8f81945 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -424,6 +424,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>         /* VBAR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
>           NULL, reset_val, VBAR_EL1, 0 },
> +
> +       /* ICC_SRE_EL1 */
> +       { Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b1100), Op2(0b101),
> +         trap_raz_wi },
> +
>         /* CONTEXTIDR_EL1 */
>         { Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
>           access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
> --
> 2.1.2.330.g565301e.dirty
>
