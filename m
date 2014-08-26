From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 14:24:45 +0100
Subject: [PATCH] arm/arm64: KVM: Complete WFI/WFE instructions
In-Reply-To: <1409057387-27458-1-git-send-email-christoffer.dall@linaro.org>
References: <1409057387-27458-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <53FC8A9D.70300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 26/08/14 13:49, Christoffer Dall wrote:
> The architecture specifies that when the processor wakes up from a WFE
> or WFI instruction, the instruction is considered complete, however we
> currrently return to EL1 (or EL0) at the WFI/WFE instruction itself.
> 
> While most guests may not be affected by this because their local
> exception handler performs an exception returning setting the event bit
> or with an interrupt pending, some guests like UEFI will get wedged due
> this little mishap.
> 
> Simply skip the instruction when we have completed the emulation.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> Note that I haven't confirmed exactly how Linux guests survives WFI
> without this fix.  My working hypothesis is that the Linux ISR doesn't
> complete the interrupt, leaving an active interrupt on the LR, which may
> cause the PE to consider it a wake-up event for the WFI despite the EL1
> handler returning to the WFI instruction itself.  Tianocore on the other
> hand may complete the interrupt entirely before returning to the WFI
> instruction.
> 
> Input on this is most welcome and likely to improve the quality of my
> sleep.

Very good catch.

The main reason is that Linux uses WFI in the idle loop, so it doesn't
matter if we come back to WFI or the following instruction (it is likely
to be a branch to WFI...).

Guests that have useful code *after* WFI will be terminally broken.

Anyway, time to run some tests and consider merging this as a fix (with
the equivalent arm64 patch), and possibly Cc stable.

Thanks,

	M.

> 
>  arch/arm/kvm/handle_exit.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
> index 4c979d4..a96a804 100644
> --- a/arch/arm/kvm/handle_exit.c
> +++ b/arch/arm/kvm/handle_exit.c
> @@ -93,6 +93,8 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	else
>  		kvm_vcpu_block(vcpu);
>  
> +	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
> +
>  	return 1;
>  }
>  
> 


-- 
Jazz is not dead. It just smells funny...
