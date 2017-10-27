From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Oct 2017 16:27:43 +0100
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <87wp3g39es.fsf@free-electrons.com>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
Message-ID: <20171027152743.GJ20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 05:19:55PM +0200, Gregory CLEMENT wrote:
> Hi Arnd,
>  
>  On ven., oct. 20 2017, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The asm-generic/unaligned.h header provides two different implementations
> > for accessing unaligned variables: the access_ok.h version used when
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set pretends that all pointers
> > are in fact aligned, while the le_struct.h version convinces gcc that the
> > alignment of a pointer is '1', to make it issue the correct load/store
> > instructions depending on the architecture flags.
> >
> > On ARMv5 and older, we always use the second version, to let the compiler
> > use byte accesses. On ARMv6 and newer, we currently use the access_ok.h
> > version, so the compiler can use any instruction including stm/ldm and
> > ldrd/strd that will cause an alignment trap. This trap can significantly
> > impact performance when we have to do a lot of fixups and, worse, has
> > led to crashes in the LZ4 decompressor code that does not have a trap
> > handler.
> >
> > This adds an ARM specific version of asm/unaligned.h that uses the
> > le_struct.h/be_struct.h implementation unconditionally. This should lead
> > to essentially the same code on ARMv6+ as before, with the exception of
> > using regular load/store instructions instead of the trapping instructions
> > multi-register variants.
> >
> > The crash in the LZ4 decompressor code was probably introduced by the
> > patch replacing the LZ4 implementation, commit 4e1a33b105dd ("lib: update
> > LZ4 compressor module"), so linux-4.11 and higher would be affected most.
> > However, we probably want to have this backported to all older stable
> > kernels as well, to help with the performance issues.
> >
> > There are two follow-ups that I think we should also work on, but not
> > backport to stable kernels, first to change the asm-generic version of
> > the header to remove the ARM special case, and second to review all
> > other uses of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to see if they
> > might be affected by the same problem on ARM.
> >
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Untested so far, please verify that this fixes all the known problems
> > with the alignment traps.
> 
> I think Russell already find this conclusion but this patch didn't solve
> my boot issue with dtb append.
> 
> I tested this patch onto a v4.14-rc6.
> 
> Then at least with the patch from Ard: "efi/libstub: arm: omit sorting
> of the UEFI memory map", it didn't prevent booting.

There's three things wrong, all of which I have patches to address:

1. The decompressor code reading the image data sometimes issues unaligned
   reads.  Some compilers get this wrong and cause an abort.  Arnds patch
   addresses this.

2. Additional sections can appear in the zImage binary which adds extra
   bytes on the end of the image.  Concatenating the zImage with the
   extra bytes onto a DTB is the same thing as doing this:

	cat zImage extrabytes foo.dtb > image

   and the decompressor tolerates no additional bytes between the
   _official_ end of the zImage and the DTB.  I've added a patch which
   detects this situation and fails the kernel build when it happens.

3. Ard's patch "efi/libstub: arm: omit sorting of the UEFI memory map"
   gets rid of the additional sections that (a) change the alignment
   of the compressed data, and (b) add additional unexpected bytes on
   the end of zImage.

So, merely applying Ard's patch will appear to fix the problem, but leave
the actual underlying issues - so next time we have an additional section
appear in the zImage, we'd go through all this pain again.

These other patches are required to either make the decompressor tolerant
or catch the problem cases while they're still in the developer's tree.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
