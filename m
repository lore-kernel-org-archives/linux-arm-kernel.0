From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Dec 2014 17:31:15 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <5490B876.50101@linaro.org>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <5490B876.50101@linaro.org>
Message-ID: <20141217173115.GK9475@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 10:55:50PM +0000, Al Stone wrote:
> > On Monday 15 December 2014 19:18:16 Al Stone wrote:
> >> 2. Linux must choose DT booting by default when offered both ACPI and
> >>    DT on arm64
> >>    * DONE
> 
> I've asked Hanjun to re-examine the patch we have.  If the setup_arch()
> code for arm64 goes something like this:
> 
>    If acpi=force (or =on?)

acpi=force is already defined, we could use that. But I don't have a
problem with introducing =on either.

>       If ACPI tables exist
>          use ACPI
>       Else if a DT exists
>          use DT, but issue a warning that ACPI tables are missing
>       Else
>          panic, 'cause we got nothin'

While this panic is still needed here to stop the kernel from booting,
the problem with it is that it doesn't go anywhere, you could not
retrieve any console information. Anyway, it's not worse than what we
currently have but in the presence of EFI_STUB, maybe we could also
report such error before existing boot services (like "no DT nor ACPI
found").

>       Endif
>    Else
>       If a DT exists
>          use DT
>       Else if ACPI tables exist
>          use ACPI, but issue a warning that the DT is missing

Why? Maybe this could be temporary but longer term we should treat ACPI
and DT as equal citizens, with DT having priority if both are present. I
don't think we should require that ACPI tables are always accompanied by
DT counterparts.

>       Else
>          panic, 'cause we got nothin'

Same here with the panic.

>       Endif
>    Endif
> 
> ...is that better?  Or worse?  Or just far too kind to people trying
> to boot a kernel :)?

Maybe the kernel should prompt the user: "Are you really sure you want
to use ACPI?" ;)

-- 
Catalin
