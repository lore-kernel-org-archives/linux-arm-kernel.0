From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 5 Dec 2013 15:15:39 +0000
Subject: [PATCH] ARM/KVM: inject data abort on unhandled memory access
In-Reply-To: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
References: <1386256221-12294-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <CAFEAcA8tsdMjok8EQe-2ybuuCn_g7ZEYROwSPVcwr5A1VyrOVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2013 15:10, Andre Przywara <andre.przywara@linaro.org> wrote:
> If a KVM guest accesses memory that is outside its memory map (so no
> MMIO and no RAM), KVM will return -ENOSYS to userland, causing QEMU
> to do an abort() and kill the whole guest. This happens while
> executing dmidecode on ARM, which mmaps /dev/mem and scans the first
> Megabyte of memory for a DMI BIOS signature (sic!).
> Of course this is silly, but in any case crashing the whole guest
> does not seems appropriate.
> So lets mimic native hardware's behavior in this case and inject a
> Data Abort exception into the guest. In the previous case this will
> crash dmidecode with SIGSEGV, but keeps the guest alive.

> --- a/arch/arm/kvm/mmio.c
> +++ b/arch/arm/kvm/mmio.c
> @@ -183,7 +183,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                         return ret;
>         } else {
>                 kvm_err("load/store instruction decoding not implemented\n");
> -               return -ENOSYS;
> +               kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +               return 1;
>         }

This seems like it's mixing two different error cases:
 (1) guest tries to access something with nothing backing it at all
 -> should definitely cause a guest Data Abort
 (2) guest tries to access something (whether at a valid device address
 or not) with a "complex" instruction like LDM/STM which we can't deal
 without emulating it

The error message you've removed relates to (2). I think there's a reasonable
case to make for "log and reflect back into guest as a Data Abort"; silently
Data Aborting seems a bit cryptic.

Of course if the guest tries to do a memcpy() on the device memory
(which IIRC is what is happening with dmidecode in this case) then it's
very likely to hit case (2).

Or we could try to get the ldm/stm emulation code upstream :-)

thanks
-- PMM
