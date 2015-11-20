From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Nov 2015 19:32:33 +0000
Subject: [PATCHv2] arm64: efi: correctly map runtime regions
In-Reply-To: <CAKv+Gu8XKpZFdRAGTz2FaptzARN+qDLhxgNQYz+_ypHT9TAOgg@mail.gmail.com>
References: <1448032353-8770-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu8XKpZFdRAGTz2FaptzARN+qDLhxgNQYz+_ypHT9TAOgg@mail.gmail.com>
Message-ID: <20151120193232.GB14942@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 07:31:21PM +0100, Ard Biesheuvel wrote:
> On 20 November 2015 at 16:12, Mark Rutland <mark.rutland@arm.com> wrote:
> > Thus we account for the residue twice, and when the residue is non-zero
> > will cause __create_mapping to map an additional page at the end of the
> > region. Depending on the memory map, this page may be in a region we are
> > not intended/permitted to map, or may clash with a different region that
> > we which to map.
> >
> 
> wish

Whoops; corrected locally.

> It is worth to note that, since the memory map is virtually always
> sorted in ascending order (especially now that we sort it explicitly
> in the stub), this is highly unlikely to cause trouble in practice,
> since the additional page mapping is always at the top, and will be
> corrected as it is overwritten by the subsequent entry.

I agree that in the common case we are extremely likely to overwrite and
correct an erroneous entry (especially given that's how I detected this
in the first place).

I've added a note to that effect.

If there is no next entry, or it's start address is sufficiently far
away, we won't fix up the erroneous entry. It seems either that case is
unlikely, or the region happened to be safe to map regardless.

> The page tables are not active at this stage, so there are no concerns
> regarding break-before-make etc.

Yup.

> >         for_each_efi_memory_desc(&memmap, md) {
> > -               u64 paddr, npages, size;
> > +               u64 size;
> 
> I would have dropped 'size' entirely, and use the expression as the
> function argument directly, but this is also fine by me.

Sure; I've folded that in locally.

> In either case:
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Cheers!

Mark.
