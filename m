From: olivier.martin@arm.com (Olivier Martin)
Date: Tue, 8 Jul 2014 16:33:32 +0100
Subject: [PATCH v2 0/2] efi: preserve NEON registers on UEFI services calls
In-Reply-To: <CAKv+Gu8yb=H2734e-Wai3npK_qwsq7SWHumn+1gjkmJhF-2QQA@mail.gmail.com>
References: <1403777346-28629-1-git-send-email-ard.biesheuvel@linaro.org>	<20140701132638.GC7539@console-pimps.org>
 <CAKv+Gu8yb=H2734e-Wai3npK_qwsq7SWHumn+1gjkmJhF-2QQA@mail.gmail.com>
Message-ID: <005f01cf9ac1$f9f01460$edd03d20$@martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is correct the UEFI 2.4 spec says 'Floating point and SIMD instructions may be used'. And it is also correct these registers are not preserved in the current UEFI EDK2 implementation.
I will keep track in ARM UEFI todo list.

Acked-by: Olivier Martin <olivier.martin@arm.com>

Thanks Ard for your patch,
Olivier

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> Sent: 01 July 2014 14:46
> To: Matt Fleming
> Cc: Matt Fleming; x86 at kernel.org; Catalin Marinas; linux-
> efi at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> hpa at zytor.com; Leif Lindholm; Roy Franz; msalter at redhat.com; Olivier
> Martin
> Subject: Re: [PATCH v2 0/2] efi: preserve NEON registers on UEFI
> services calls
> 
> On 1 July 2014 15:26, Matt Fleming <matt@console-pimps.org> wrote:
> > On Thu, 26 Jun, at 12:09:04PM, Ard Biesheuvel wrote:
> >> The current UEFI implementation for arm64 fails to preserve/restore
> the contents
> >> of the NEON register file, which may result in data corruption,
> especially now
> >> that those contents are lazily restored for user processes.
> >>
> >> This series proposes to fix this by wrapping all runtime services
> calls, and
> >> adding kernel_neon_begin()/kernel_neon_end() pairs to the wrappers.
> >>
> >> The first patch moves the existing x86 versions of those wrappers to
> generic
> >> code, so that the second patch can easily enable them by supplying a
> definition
> >> for efi_call_virt and adding a call to efi_native_runtime_setup().
> >>
> >> Changes since v1:
> >> - rename runtime.c -> runtime-wrappers.c
> >> - make build depend on new Kconfig symbol EFI_RUNTIME_WRAPPERS to
> fix ia64
> >>   breakage
> >> - remove default #defines for efi_call_virt()/__efi_call_virt(),
> they are not
> >>   needed anymore now that it is built conditionally
> >> - add references to applicable UEFI/AAPCS spec sections
> >>
> >> Ard Biesheuvel (2):
> >>   efi/x86: move UEFI Runtime Services wrappers to generic code
> >>   efi/arm64: preserve FP/SIMD registers on UEFI runtime services
> calls
> >
> > Thanks Ard. These patches look OK to me, and I've now pulled them
> into
> > my 'next' branch.
> >
> > It'd be nice if we could get some ACKs from other people since this
> is
> > an ABI issue.
> 
> Yes, they have been awfully quiet, haven't they?
> 
> At least Roy has volunteered to get involved in the USWG to get the
> spec clarified.
> 
> @Leif, Catalin, Olivier: care to chime in?
> 
> --
> Ard.
