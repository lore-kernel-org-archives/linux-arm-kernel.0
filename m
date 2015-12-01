From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 11:02:55 +0000
Subject: arm64 boot requirements
In-Reply-To: <565BAA2E.5090102@cog.systems>
References: <565BAA2E.5090102@cog.systems>
Message-ID: <20151201110159.GA4757@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 30, 2015 at 12:45:18PM +1100, Carl van Schaik wrote:
> In commit bd00cd5f8c8c3c282bb1e1eac6a6679a4f808091, the idmap_pg_dir
> and swapper_pg_dir where moved from before the kernel to after it.
> 
> The problem is that these symbols fall outside the range covered by
> the ELF file - outside of any section.
> 
> A bootloader which loads the kernel ELF file and dynamically
> determines where to place the DTB, may try place it after the
> kernel. We've just run into this problem and the DTB gets
> overwritten as soon as the pagetables are created.

We had similar issues with the BSS when booting Image files prior to
this and commit a2c1d73b94ed49f5 ("arm64: Update the Image header").
Since then, the image_size field in the Image header tells you how much
memory the kernel may clobber (including the BSS and page tables).

Prior to that, the page tables were below the kernel, and also not
described in any ELF section.

Others booting the kernel vmlinux haven't reported similar issues, so I
assume that either they are parsing the Image header, or getting lucky.
Parsing the header is necessary to get the correct text offset, too...

Pratyush, Geoff, I understood you were loading the kernel vmlinux for
kexec. Do you parse the Image header to figure out where to place
things?

> I'd suggest that the kernel either:
>  A. document this boot requirement for where not to load a DTB

Do you have any particular suggestion?

We already describe the Image footprint (including BSS and page tables)
by the image_size in the Image header, which is sufficient. The size of
the BSS and page tables is effectively unbound, so we can't define some
upper bound that will always be true.

The documentation is written on the assumption that an Image file is
being used rather than a vmlinux. Perhaps that is something to consider.

>  B. update the vmlinux.lds.S such that these symbols (and _end) are
> properly covered by a section in the ELF, and thus preventing this
> issue.

I'm worried that this only solves this one case, and it means that there
are two (potentially conflicting) sources of information that a
bootloader might be using -- the ELF or the Image header. I don't want
to have to duplicate text_offset and so on, which implies that parsing
the Image header is necessary anyway.

That's something we can discuss if you send a patch (inline rather than
attached).

Thanks,
Mark.
