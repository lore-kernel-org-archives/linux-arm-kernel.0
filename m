From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Dec 2015 12:24:51 +0000
Subject: arm64 boot requirements
In-Reply-To: <082101d12d07$dd677160$98365420$@cog.systems>
References: <565BAA2E.5090102@cog.systems> <20151201110159.GA4757@leverpostej>
 <CAKv+Gu_2ufc_q5OsGDsGUqfEieCHc++-r2zxrpDpHcMbZyS_aQ@mail.gmail.com>
 <082101d12d07$dd677160$98365420$@cog.systems>
Message-ID: <20151203122450.GC28731@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 12:46:35AM +1100, Carl van Schaik wrote:
> Hi,
> 
> On 1 December 2015 Ard Biesheuvel <ard.biesheuvel@linaro.org> wote:
> > On 1 December 2015 at 12:02, Mark Rutland <mark.rutland@arm.com>
> > wrote:
> > > Hi,
> > >
> > > On Mon, Nov 30, 2015 at 12:45:18PM +1100, Carl van Schaik wrote:
> > >> In commit bd00cd5f8c8c3c282bb1e1eac6a6679a4f808091, the
> > idmap_pg_dir
> > >> and swapper_pg_dir where moved from before the kernel to after it.
> > >>
> > >> The problem is that these symbols fall outside the range covered by
> > >> the ELF file - outside of any section.
> > >>
> > >> A bootloader which loads the kernel ELF file and dynamically
> > >> determines where to place the DTB, may try place it after the
> > >> kernel. We've just run into this problem and the DTB gets
> > >> overwritten as soon as the pagetables are created.
> > 
> > Could you explain why you are using the ELF file and not the binary image
> > file?
> > This is not future proof: currently, the Image is a straight binary
> > objcopy of vmlinux, but that is not guaranteed to remain that way.
> > Things like KASLR may require post build steps that mangle vmlinux or
> > Image afterwards.
> 
> The reason we've been using ELF files is mostly to do with legacy virtualization
> related reasons in our systems, we used to patch symbols in the ELFs for example
> pre device-tree. However, since it hadn't caused problems until now we had
> continued to use it. We haven't yet added Aarch64 Linux boot image header parsing
> but it should be trivial.
> 
> The other area we are looking into is optimized multi-VM static boot images by
> constructing hypervisor-bundle images containing de-duplicated Linux sections,
> allowing an ELF bootloader to populate multiple Linux VMs from a smaller boot
> image - resulting in faster boot.

Ok.

Per Ard's comments, this may get broken in future by KASLR or similar;
we cannot make strong guarantees as to the vmlinux being directly
usable. That's a different discussion, though...

> > >> I'd suggest that the kernel either:
> > >>  A. document this boot requirement for where not to load a DTB
> > >
> > > Do you have any particular suggestion?
> > >
> > > We already describe the Image footprint (including BSS and page tables)
> > > by the image_size in the Image header, which is sufficient. The size of
> > > the BSS and page tables is effectively unbound, so we can't define some
> > > upper bound that will always be true.
> > >
> > > The documentation is written on the assumption that an Image file is
> > > being used rather than a vmlinux. Perhaps that is something to consider.
> > >
> > >>  B. update the vmlinux.lds.S such that these symbols (and _end) are
> > >> properly covered by a section in the ELF, and thus preventing this
> > >> issue.
> > >
> > > I'm worried that this only solves this one case, and it means that there
> > > are two (potentially conflicting) sources of information that a
> > > bootloader might be using -- the ELF or the Image header. I don't want
> > > to have to duplicate text_offset and so on, which implies that parsing
> > > the Image header is necessary anyway.
> > >
> > > That's something we can discuss if you send a patch (inline rather than
> > > attached).
> > >
> > 
> > I think updating the linker script to put the page tables into a
> > .pgdir section is reasonable, since it is part of the static footprint
> > of the kernel.
> 
> I agree

Ok. As above, please send a standalone, inline patch for this. Please Cc
at least myself, Ard, and Catalin.

We can have any further discussion there.

> > However, I strongly feel that the Image header should remain the
> > authoritative source of information regarding the nature (big/little
> > endian, page size) and the static footprint of the Image .
> 
> Agreed, and there are other ways to de-duplicate which will still work
> with binary image inputs.

I completely agree that the Image is the canonical source of
information.

Thanks,
Mark.
