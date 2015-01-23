From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 24 Jan 2015 00:48:55 +0100
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
In-Reply-To: <201501232336.36187@pali>
References: <201501232239.55801@pali>
 <201501232336.36187@pali>
Message-ID: <20150123234855.GB27111@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-01-23 23:36:36, Pali Roh?r wrote:
> On Friday 23 January 2015 22:39:55 Pali Roh?r wrote:
> > Hello,
> > 
> > when I boot zImage with appended DT n900 in qemu
> > fdt_open_into() function called from file
> > arch/arm/boot/compressed/atags_to_fdt.c (in function
> > atags_to_fdt) always returns -FDT_ERR_NOSPACE.
> > 
> > It means that all ATAGS (including cmdline arguments) passed
> > by bootloader are ignored.
> > 
> > On real n900 device I see that booted DT version also ignore
> > cmdline arguments from bootloader. I cannot debug decompress
> > code on real device, but I think it is same problem as in
> > qemu.
> 
> Looks like this quick patch is fixing above problem:

So... something overruns stack, and bigger stack fixes it...?

							Pavel

> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 68be901..4a7d75b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -268,7 +268,7 @@ restart:	adr	r0, LC0
>  		 * area.  No GOT fixup has occurred yet, but none of the
>  		 * code we're about to call uses any global variable.
>  		*/
> -		add	sp, sp, #0x10000
> +		add	sp, sp, #0x20000
>  		stmfd	sp!, {r0-r3, ip, lr}
>  		mov	r0, r8
>  		mov	r1, r6
> @@ -289,7 +289,7 @@ restart:	adr	r0, LC0
>  		bleq	atags_to_fdt
>  
>  		ldmfd	sp!, {r0-r3, ip, lr}
> -		sub	sp, sp, #0x10000
> +		sub	sp, sp, #0x20000
>  #endif
>  
>  		mov	r8, r6			@ use the appended device tree
> 
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
