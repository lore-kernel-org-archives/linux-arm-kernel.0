From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 05 Dec 2013 18:24:13 +0000
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
In-Reply-To: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
References: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <52A0C4CD.9030106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 05/12/13 15:10, Andre Przywara wrote:
> If a KVM guest accesses memory that is outside its memory map (so no
> MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
> to do an abort() and kill the whole guest. This happens while
> executing dmidecode on ARM, which mmaps /dev/mem and scans the first
> Megabyte of memory for a DMI BIOS signature (sic!).

Arghhh. And of course, I expect they do that using instructions we can't
use for IOs.

Bummer.

> Of course this is silly, but in any case crashing the whole guest
> does not seems appropriate.
> So lets mimic native hardware's behavior in this case and inject a
> Data Abort exception into the guest. In the previous case this will
> crash dmidecode with SIGSEGV, but keeps the guest alive.
> 
> I am not sure if this too coarse grained, but I just wanted to start
> discussion on this.
> 
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
> ---
>  arch/arm/kvm/mmio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
> index 4cb5a93..04a105e 100644
> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  			return ret;
>  	} else {
>  		kvm_err("load/store instruction decoding not implemented\n");
> -		return -ENOSYS;
> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +		return 1;
>  	}
>  
>  	rt = vcpu->arch.mmio_decode.rt;
> 

I agree that killing the whole VM is not the nicest thing in the world.
How about:
- keeping some form of warning
- rate-limit it so we don't flood the host
- inject the data-abort

That should give us a saner behaviour (I agree with you that the current
one is not very good), and yet annoy the luser enough so that they
either fix their software or start merging the emulation code...

	M.
-- 
Jazz is not dead. It just smells funny...
