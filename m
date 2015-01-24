From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 24 Jan 2015 10:04:37 +0100
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
In-Reply-To: <20150123234855.GB27111@amd>
References: <201501232239.55801@pali> <201501232336.36187@pali>
 <20150123234855.GB27111@amd>
Message-ID: <201501241004.37391@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 January 2015 00:48:55 Pavel Machek wrote:
> On Fri 2015-01-23 23:36:36, Pali Roh?r wrote:
> > On Friday 23 January 2015 22:39:55 Pali Roh?r wrote:
> > > Hello,
> > > 
> > > when I boot zImage with appended DT n900 in qemu
> > > fdt_open_into() function called from file
> > > arch/arm/boot/compressed/atags_to_fdt.c (in function
> > > atags_to_fdt) always returns -FDT_ERR_NOSPACE.
> > > 
> > > It means that all ATAGS (including cmdline arguments)
> > > passed by bootloader are ignored.
> > > 
> > > On real n900 device I see that booted DT version also
> > > ignore cmdline arguments from bootloader. I cannot debug
> > > decompress code on real device, but I think it is same
> > > problem as in qemu.
> > 
> > Looks like this quick patch is fixing above problem:
> So... something overruns stack, and bigger stack fixes it...?
> 
> 							Pavel
> 

Yes, it looks like that DTB file for n900 is too big and 
atags_to_fdt.c cannot append anything to it (kernel cmdline)...

> > diff --git a/arch/arm/boot/compressed/head.S
> > b/arch/arm/boot/compressed/head.S index 68be901..4a7d75b
> > 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -268,7 +268,7 @@ restart:	adr	r0, LC0
> > 
> >  		 * area.  No GOT fixup has occurred yet, but none of 
the
> >  		 * code we're about to call uses any global variable.
> >  		
> >  		*/
> > 
> > -		add	sp, sp, #0x10000
> > +		add	sp, sp, #0x20000
> > 
> >  		stmfd	sp!, {r0-r3, ip, lr}
> >  		mov	r0, r8
> >  		mov	r1, r6
> > 
> > @@ -289,7 +289,7 @@ restart:	adr	r0, LC0
> > 
> >  		bleq	atags_to_fdt
> >  		
> >  		ldmfd	sp!, {r0-r3, ip, lr}
> > 
> > -		sub	sp, sp, #0x10000
> > +		sub	sp, sp, #0x20000
> > 
> >  #endif
> >  
> >  		mov	r8, r6			@ use the appended device tree

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/c80cf3e3/attachment.sig>
