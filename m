From: lersek@redhat.com (Laszlo Ersek)
Date: Mon, 08 Sep 2014 22:52:06 +0200
Subject: [PATCH] ARM/arm64: KVM: fix use of WnR bit in kvm_is_write_fault()
In-Reply-To: <1410208167-32532-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1410208167-32532-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <540E16F6.5000008@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/14 22:29, Ard Biesheuvel wrote:
> The ISS encoding for an exception from a Data Abort has a WnR
> bit[6] that indicates whether the Data Abort was caused by a
> read or a write instruction. While there are several fields
> in the encoding that are only valid if the ISV bit[24] is set,
> WnR is not one of them, so we can read it unconditionally.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This fixes an issue I observed with UEFI running under QEMU/KVM using
> NOR flash emulation and the upcoming KVM_CAP_READONLY_MEM support, where
> NOR flash reads were mistaken for NOR flash writes, resulting in all read
> accesses to go through the MMIO emulation layer.
> 
>  arch/arm/include/asm/kvm_mmu.h   | 5 +----
>  arch/arm64/include/asm/kvm_mmu.h | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 5cc0b0f5f72f..fad5648980ad 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -83,10 +83,7 @@ static inline bool kvm_is_write_fault(unsigned long hsr)
>  	unsigned long hsr_ec = hsr >> HSR_EC_SHIFT;
>  	if (hsr_ec == HSR_EC_IABT)
>  		return false;
> -	else if ((hsr & HSR_ISV) && !(hsr & HSR_WNR))
> -		return false;
> -	else
> -		return true;
> +	return hsr & HSR_WNR;
>  }
>  
>  static inline void kvm_clean_pgd(pgd_t *pgd)
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 8e138c7c53ac..09fd9e4c13d8 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -100,10 +100,7 @@ static inline bool kvm_is_write_fault(unsigned long esr)
>  	if (esr_ec == ESR_EL2_EC_IABT)
>  		return false;
>  
> -	if ((esr & ESR_EL2_ISV) && !(esr & ESR_EL2_WNR))
> -		return false;
> -
> -	return true;
> +	return esr & ESR_EL2_WNR;
>  }
>  
>  static inline void kvm_clean_pgd(pgd_t *pgd) {}
> 

No clue about the 32-bit case, but the 64-bit change checks out against
the ARM ARM. The ISV (ISS[24]) is documented to determine the validity
of bits ISS[23:14], but WnR is ISS[6], hence it appears independent indeed.

The pre-patch code only considered a clear WnR meaningful /
consequential only if the ISV was set -- more precisely, it only even
looked at the WnR then, due to the short-circuit nature of && --, and it
defaulted to "write fault". Synchronous data aborts due to funky
register writeback instructions don't set the ISV, hence the code used
to turn its back on the clear WnR. (Apologies for explaining it to
myself publicly.) We now ignore the ISV and key off the WnR only.

You're awesome, Ard. (And now you can drop a few patches from your
linaro-topic-virt-post-v7-roundup branch! :))

Acked-by: Laszlo Ersek <lersek@redhat.com>

Cheers
Laszlo
