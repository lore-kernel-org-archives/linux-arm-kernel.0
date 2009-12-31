From: jsun@junsun.net (Jun Sun)
Date: Wed, 30 Dec 2009 21:45:07 -0800
Subject: [PATCH] Valid relocation symbol for FLAT format on ARM
In-Reply-To: <20091230184929.GB22469@shareable.org>
References: <52886e760912300830n2234e01bm2e300828141d226@mail.gmail.com>
	<20091230184929.GB22469@shareable.org>
Message-ID: <20091231054507.GA16734@Pogoplug>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 06:49:29PM +0000, Jamie Lokier wrote:
> Jun Sun wrote:
> >    (Sent to linux-kernel, but seems nobody cared. Hopefully someone here
> >    can pick it up)
> 
> I've included uclinux-dev at uclinux.org, because that's where I've seen
> most discussion of FLAT format in general.
>

Thanks. I should have probably done this at the first place.
 
> >    Apparently newer GCC would generate ANCHOR symbols beyond the end of
> >    data/bss segment on ARM CPUs. As a result, the exiting validity checking
> >    for relocation symbols in FLAT format will fail for some programs.
> 
> > -#define        flat_reloc_valid(reloc, size)           ((reloc) <= (size))
> > +#define        flat_reloc_valid(reloc, size)           ((reloc) <= (size) + 0x1000)
> 
> Why 0x1000?  Is that an arbitrary number, or does it have a specific
> meaning for GCC?
> 

I had a piece of comment in my first patch submission which explains it
well. I attached it here. This time around I thought for the simplicity
look of code and dropped it. Maybe it should still be there. :)

> >    This also fixes a cosmetic error in printk. Text segment and data/bss
> >    segment are allocated from two different areas. It is not meaningful to
> >    give the diff between them in error reporting messages.
> 
> That part looks fine to me.
> 
> -- Jamie
> 
> ps. Russell, proof that someone is using no-MMU ARM? :-)

Yes, ARM on no-MMU CPU is still alive. :) Hopefully you can see
some amazing products coming soon that we can all be proud of.

Cheers.

Jun
-------------- next part --------------
diff -Nru linux-2.6.32.2/arch/arm/include/asm/flat.h.orig linux-2.6.32.2/arch/arm/include/asm/flat.h
--- linux-2.6.32.2/arch/arm/include/asm/flat.h.orig	2009-12-18 14:27:07.000000000 -0800
+++ linux-2.6.32.2/arch/arm/include/asm/flat.h	2009-12-26 08:22:43.000000000 -0800
@@ -7,7 +7,12 @@
 
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
+#define	flat_reloc_valid(reloc, size)		((reloc) <= (size) + 0x1000)
+/* [JSUN] new gcc 4.x generates ANCHOR symbols in order to reduce the size
+ * of GOT table for PIC code. It is possible the ANCHOR is placed beyond
+ * the end of data/bss segment up to 4K bytes(12 bits), because ARM allows
+ * negative 12-bit offset. Thus we allow 0x1000 extra in reloc address range.
+ */
 #define	flat_get_addr_from_rp(rp, relval, flags, persistent) get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)
diff -Nru linux-2.6.32.2/fs/binfmt_flat.c.orig linux-2.6.32.2/fs/binfmt_flat.c
--- linux-2.6.32.2/fs/binfmt_flat.c.orig	2009-12-18 14:27:07.000000000 -0800
+++ linux-2.6.32.2/fs/binfmt_flat.c	2009-12-26 08:22:43.000000000 -0800
@@ -355,7 +355,7 @@
 
 	if (!flat_reloc_valid(r, start_brk - start_data + text_len)) {
 		printk("BINFMT_FLAT: reloc outside program 0x%x (0 - 0x%x/0x%x)",
-		       (int) r,(int)(start_brk-start_code),(int)text_len);
+		       (int) r,(int)(start_brk-start_data+text_len),(int)text_len);
 		goto failed;
 	}
 
