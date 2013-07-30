From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 30 Jul 2013 14:56:10 +0100
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
 <20130729135000.GK32383@mudshark.cambridge.arm.com>
 <1375106635.12741.8.camel@kazak.uk.xensource.com>
 <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
Message-ID: <1375192570.32691.27.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-07-29 at 23:05 -0400, Nicolas Pitre wrote:
> On Mon, 29 Jul 2013, Ian Campbell wrote:
> 
> > On Mon, 2013-07-29 at 14:50 +0100, Will Deacon wrote:
> > > Hi Ian,
> > > 
> > > /me plays English teacher :)
> > > 
> > > On Mon, Jul 29, 2013 at 01:56:18PM +0100, Ian Campbell wrote:
> > > > Based on the discussion in [0]:
> > > >   - Recommend that the kernel be placed under 128MiB ("for automatic RAM
> > > >     location to work", says Nico)
> > > >   - Recommend that DTB larger than ~16KiB be placed after the 128MiB boundary
> > > >     (in order to avoid conflicting with the kernel decompressor, kernel is at
> > > >     most 32MiB) and within the lowmem region. Somewhat arbitrarily recommend
> > > >     placement below the 256MiB boundary, the real lowmem limit is likely up
> > > >     around 600-800MiB but varies.
> > > > 
> > > > [0] http://article.gmane.org/gmane.linux.ports.arm.kernel/254538
> > > > 
> > > > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Dave Martin <dave.martin@linaro.org>
> > > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > ---
> > > >  Documentation/arm/Booting |   14 +++++++++++---
> > > >  1 files changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
> > > > index 0c1f475..72c035e 100644
> > > > --- a/Documentation/arm/Booting
> > > > +++ b/Documentation/arm/Booting
> > > > @@ -125,6 +125,13 @@ with the caveat that it may not be located at physical address 0 since
> > > >  the kernel interprets a value of 0 in r2 to mean neither a tagged list
> > > >  nor a dtb were passed.
> > > >  
> > > > +If the DTB is larger than ~16KiB, such that placement in the first
> > > > +16KiB would lead to a conflict with the kernel loaded at 32KiB (as
> > > > +recommended below) which uses the memory between 16KiB-32KiB itself,
> > > > +then the DTB should be placed after the first 128MiB of RAM in order
> > > > +to avoid conflicting with the kernel decompressor. The recommnded
> > > 
> > > recommended
> > 
> > Should've pressed F5, sorry...
> > 
> > > It also looks like you're repeating part of what is said later regarding the
> > > 16k of page tables below the image.
> > 
> > yes, this was tricky since I wanted to justify the larger than 16KiB but
> > that was a forward reference. I went with "as recommended below".
> > Perhaps I should just omit the justification? Or perhaps "If the DTB is
> > larger than ~16KiB (see below for why this particular value
> > matters)...". Clunky :-(
> 
> Why not simply:
> 
> 	Make sure the loaded DTB doesn't conflict with the zImage 
> 	decompressor which may relocate itself.  A safe location is 
> 	just above the 128MB boundary from start of RAM.

Sounds good.

> 
> > > Also, we use 20k with LPAE.
> > 
> > I'll fold in an update along those lines too.
> > 
> > However given that this then makes everything more complicated (e.g.
> > it's now DTB > ~12KiB in that case) perhaps we should just ditch the
> > original recommendation to use the first 16KiB and switch to a
> > recommendation of "as high as possible below 256MiB" across the board?
> > That would remove the issue with repeating stuff from the next section
> > too.
> 
> Sure.

I'll make this change.

> > > > +placement in this case just below the 256MiB boundary.
> > > > +
> > > >  5. Calling the kernel image
> > > >  ---------------------------
> > > >  
> > > > @@ -136,9 +143,10 @@ is stored in flash, and is linked correctly to be run from flash,
> > > >  then it is legal for the boot loader to call the zImage in flash
> > > >  directly.
> > > >  
> > > > -The zImage may also be placed in system RAM (at any location) and
> > > > -called there.  Note that the kernel uses 16K of RAM below the image
> > > > -to store page tables.  The recommended placement is 32KiB into RAM.
> > > > +The zImage may also be placed in system RAM and called there.  The
> > > > +kernel should be placed in the first 128MiB of RAM. Note that the
> > > > +kernel uses 16KiB of RAM below the image to store page tables.  The
> > > > +recommended placement is 32KiB into RAM.
> > > 
> > > This is a bit clunky since you say that the zImage may be placed in system
> > > RAM, then restrict that in the next sentence.
> > 
> > How about:
> > 
> >         The kernel may also be placed in the first 128MiB of system RAM
> >         and called there.
> 
> Not "may" but "must" if you have CONFIG_AUTO_ZRELADDR=y.

The "may" here is an alternative to the option of being in flash. Is
that incompatible with AUTO_ZRELADDR?

>From the ZRELADDR Kconfig the answer seems to be yes.

> 
> >	Note that the kernel uses 16KiB of RAM below
> >       the image to store page tables.  The recommended placement is
> >         32KiB into RAM.
> 
> Well... not completely right.

To be fair this was part of the existing text ;)

> You may load zImage anywhere in the first 128MB of RAM if you have 
> CONFIG_AUTO_ZRELADDR=y.  If CONFIG_AUTO_ZRELADDR=n then zImage may be 
> loaded anywhere. In the former case, the zImage code will automatically 
> determine the physical start of RAM.  In the later case the start of RAM 
> is hardcoded in the zImage binary.
> 
> Then, the zImage code will decompress the actual kernel image at an 
> offset of (in most cases) 32KB from start of RAM.  However, if the 
> decompressed kernel would overwrite the loaded zImage where the 
> decompressor code and data is located, then zImage will relocate itself 
> just after the end of the decompressed kernel area before proceeding to 
> the decompression.  This is where you need to be careful about 
> ramdisk/initrd and DTB load addresses.
> 
> The initial page table is therefore (in most cases again) just below the 
> decompressed kernel location i.e. either Ffrom 16KB from start of RAM, 
> or from 12KB if using LPAE.
> 
> You can therefore load everything (zImage, initrd, DTB) sequentially 
> from the 32MB mark in RAM and be safe.  By loading zImage that high, it 
> most certainly won't need to relocate itself (unless the decompressed 
> kernel is larger than 32MB which is very unlikely as I mentioned) and 
> that will also make the boot process slightly faster.

OK. So it sounds like you want to change the existing recommendation of
loading at 32KiB into RAM to instead recommend loading the kernel at
32MiB into RAM, at least for zImage/compressed kernels. Do we care about
any other sort, e.g. bare or uncompressed images?

I think we do still care about people jumping direct to
arch/arm/kernel/head.S rather than arch/arm/boot/compressed/head.S,
don't we? It seems like the recommendation should remain 32KiB for
"bare" kernels.

Actually I've just noticed that the existing text in
Documentation/arm/Booting only talks about zImage and 32KiB, so perhaps
not worrying about non-zImage is acceptable?

Ian.
