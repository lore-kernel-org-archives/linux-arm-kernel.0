From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jan 2015 14:22:53 +0000
Subject: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
In-Reply-To: <CAKv+Gu_KmJOHM5-QHQFHc5eDtUMQjmf=7jD4+e32aq0JerTcLg@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <20150119114255.GF11835@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
 <20150119135144.GI11835@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_KmJOHM5-QHQFHc5eDtUMQjmf=7jD4+e32aq0JerTcLg@mail.gmail.com>
Message-ID: <20150119142253.GJ11835@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 02:00:24PM +0000, Ard Biesheuvel wrote:
> On 19 January 2015 at 13:51, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Jan 19, 2015 at 11:55:32AM +0000, Ard Biesheuvel wrote:
> >> On 19 January 2015 at 11:42, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Wed, Jan 14, 2015 at 03:04:52PM +0000, Hanjun Guo wrote:
> >> >> From: Al Stone <al.stone@linaro.org>
> >> >>
> >> >> Introduce one early parameters "off" and "force" for "acpi", acpi=off
> >> >> will be the default behavior for ARM64, so introduce acpi=force to
> >> >> enable ACPI on ARM64.
> >> >>
> >> >> Disable ACPI before early parameters parsed, and enable it to pass
> >> >> "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> >> >> the prefer one if ACPI table and DT both are provided at this moment.
> >> > [...]
> >> >> --- a/arch/arm64/kernel/setup.c
> >> >> +++ b/arch/arm64/kernel/setup.c
> >> >> @@ -62,6 +62,7 @@
> >> >>  #include <asm/memblock.h>
> >> >>  #include <asm/psci.h>
> >> >>  #include <asm/efi.h>
> >> >> +#include <asm/acpi.h>
> >> >>
> >> >>  unsigned int processor_id;
> >> >>  EXPORT_SYMBOL(processor_id);
> >> >> @@ -388,6 +389,8 @@ void __init setup_arch(char **cmdline_p)
> >> >>       early_fixmap_init();
> >> >>       early_ioremap_init();
> >> >>
> >> >> +     disable_acpi();
> >> >> +
> >> >>       parse_early_param();
> >> >>
> >> >>       /*
> >> >
> >> > Did we get to any conclusion here? DT being the preferred one is fine
> >> > when both DT and ACPI are present but do we still want the kernel to
> >> > ignore ACPI altogether if DT is not present? It's a bit harder to detect
> >> > the presence of DT at this point since the EFI_STUB added one already. I
> >> > guess we could move the "acpi=force" argument passing to EFI_STUB if no
> >> > DT is present at boot.
> >>
> >> Since the EFI stub populates the /chosen node in DT, I would prefer
> >> for it to add a property there to indicate whether it created the DT
> >> from scratch rather than adding ACPI specific stuff in there (even if
> >> it is just a string to concatenate)
> >
> > This works for me. So we could pass "acpi=force" in EFI stub if it
> > created the DT from scratch *and* ACPI tables are present (can it detect
> > the latter? And maybe it could print something if none are available).
> > If that works, the actual kernel can assume that ACPI needs to be
> > explicitly enabled via acpi=force, irrespective of how much information
> > it has in DT.
> 
> Erm, that is not at all what I meant. What I meant was, that if it is
> interesting to the kernel proper to know whether the DT was created
> from scratch by the stub rather than received from the firmware, we
> can record that particular fact in the /chosen node, and nothing else.
> How this is interpreted is up to the kernel proper entirely.

That works as well and I agree with you that splitting the decision
between EFI stub and the kernel could cause trouble.

Basically what we need is to know whether DT has platform description or
just the chosen node. There could be many ways to achieve this but EFI
stub passing such information is a good place (and acpi=force went a bit
too far ;)).

> Note that the stub may outlive many subsequent kexec reboots, so
> dividing policy like this across the stub/kernel boundary is asking
> for trouble imo. For instance, booting with a DT via kexec would be
> impossible unless we add special handling for this case, which is
> exactly what I tried to avoid with my latest virtmap series.

I haven't paid much attention to the kexec series yet but I assume a
kexec'ed kernel doesn't go through EFI stub again.

-- 
Catalin
