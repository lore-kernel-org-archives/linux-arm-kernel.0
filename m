From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Apr 2015 17:35:07 +0100
Subject: [PATCH v3 05/11] arm64/efi: adapt to relaxed FDT placement
 requirements
In-Reply-To: <CAKv+Gu9CeZonkTVMBRVfXrtALZXXVBxGM+zzWwdYTtBXR1_yVg@mail.gmail.com>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-6-git-send-email-ard.biesheuvel@linaro.org>
 <20150413162019.GJ4076@leverpostej>
 <CAKv+Gu9CeZonkTVMBRVfXrtALZXXVBxGM+zzWwdYTtBXR1_yVg@mail.gmail.com>
Message-ID: <20150413163507.GL4076@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 05:25:55PM +0100, Ard Biesheuvel wrote:
> On 13 April 2015 at 18:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Apr 10, 2015 at 02:53:49PM +0100, Ard Biesheuvel wrote:
> >> With the relaxed FDT placement requirements in place, we can change
> >> the allocation strategy used by the stub to put the FDT image higher
> >> up in memory. At the same time, reduce the minimal alignment to 8 bytes,
> >> and impose a 2 MB size limit, as per the new requirements.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/efi.h            |  8 +++-----
> >>  drivers/firmware/efi/libstub/arm-stub.c |  5 ++---
> >>  drivers/firmware/efi/libstub/efistub.h  |  1 -
> >>  drivers/firmware/efi/libstub/fdt.c      | 23 +++++++++++++----------
> >>  4 files changed, 18 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> >> index ef572206f1c3..bd513dd663b9 100644
> >> --- a/arch/arm64/include/asm/efi.h
> >> +++ b/arch/arm64/include/asm/efi.h
> >> @@ -39,12 +39,10 @@ extern void efi_init(void);
> >>  /* arch specific definitions used by the stub code */
> >>
> >>  /*
> >> - * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
> >> - * start of kernel and may not cross a 2MiB boundary. We set alignment to
> >> - * 2MiB so we know it won't cross a 2MiB boundary.
> >> + * AArch64 requires the DTB to be 8-byte aligned and not exceed 2MiB in size.
> >>   */
> >> -#define EFI_FDT_ALIGN        SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
> >> -#define MAX_FDT_OFFSET       SZ_512M
> >> +#define EFI_FDT_ALIGN                8
> >> +#define EFI_FDT_MAX_SIZE     SZ_2M
> >
> > Is there any way we can organise things so we can share the kernel's
> > MAX_FDT_SIZE definition, so as to keep the stub and kernel in sync?
> >
> 
> I'll put MAX_FDT_SIZE in asm/page.h (unless you can propose a better place)
> That way, both fixmap.h and efi.h can refer to it.

Using page.h feels a little weird, but I can't see that a better header
exists currently.

We could add asm/boot.h for things related to boot protocol that we want
to have shareable with the stub, but I can't see anything else that we'd
want to put in there at the moment. If there are other things we could
deduplicate it would probably make sense, but it seems overkill for a
single definition. :/

Mark.
