From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Dec 2016 11:56:49 +0000
Subject: [PATCH 2/2] ARM: soft-reboot into same mode that we entered the
 kernel
In-Reply-To: <E1cH751-0003kk-Ts@rmk-PC.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH751-0003kk-Ts@rmk-PC.armlinux.org.uk>
Message-ID: <20161214115648.GG17982@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 10:46:35AM +0000, Russell King wrote:
> When we soft-reboot (eg, kexec) from one kernel into the next, we need
> to ensure that we enter the new kernel in the same processor mode as
> when we were entered, so that (eg) the new kernel can install its own
> hypervisor - the old kernel's hypervisor will have been overwritten.
> 
> In order to do this, we need to pass a flag to cpu_reset() so it knows
> what to do, and we need to modify the kernel's own hypervisor stub to
> allow it to handle a soft-reboot.
> 
> As we are always guaranteed to install our own hypervisor if we're
> entered in HYP32 mode, and KVM will have moved itself out of the way
> on kexec/normal reboot, we can assume that our hypervisor is in place
> when we want to kexec, so changing our hypervisor API should not be a
> problem.

Just to check, does that also hold true for kdump?

I haven't gone digging yet, but it looks like KVM might still be
installed, rather than the hyp stub, and we might need some logic to
ensure that it's torn down...
 
[...]

> @@ -51,7 +52,9 @@ static void __soft_restart(void *addr)
>  
>  	/* Switch to the identity mapping. */
>  	phys_reset = (phys_reset_t)virt_to_idmap(cpu_reset);
> -	phys_reset((unsigned long)addr);
> +
> +	/* original stub should be restored by kvm */
> +	phys_reset((unsigned long)addr, is_hyp_mode_available());

... otherwise here we'd call into the KVM hyp code in a potentially
confusing manner.

Otherwise, this looks fine to me.

Thanks,
Mark.
