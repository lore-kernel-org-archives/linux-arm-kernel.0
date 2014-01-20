From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 20 Jan 2014 13:28:38 +0900
Subject: [PATCH] arm64: mm: use ubfm for dcache_line_size
In-Reply-To: <20140117111307.GE16003@mudshark.cambridge.arm.com>
References: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
 <20140117111307.GE16003@mudshark.cambridge.arm.com>
Message-ID: <002401cf1598$173ab750$45b025f0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 17, 2014 8:13 PM, Will Deacon wrote:
> On Fri, Jan 17, 2014 at 08:04:32AM +0000, Jingoo Han wrote:
> > Use 'ubfm' for the bitfield move instruction; thus, single
> > instruction can be used instead of two instructions, when
> > getting the minimum D-cache line size from CTR_EL0 register.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  arch/arm64/mm/proc-macros.S |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> > index 8957b82..c31f41e 100644
> > --- a/arch/arm64/mm/proc-macros.S
> > +++ b/arch/arm64/mm/proc-macros.S
> > @@ -38,8 +38,7 @@
> >   */
> >  	.macro	dcache_line_size, reg, tmp
> >  	mrs	\tmp, ctr_el0			// read CTR
> > -	lsr	\tmp, \tmp, #16
> > -	and	\tmp, \tmp, #0xf		// cache line size encoding
> > +	ubfm	\tmp, \tmp, #0x16, 0x19		// cache line size encoding
> 
> 0x16 and 0x19. Are you sure? 
> 
> You can also grep for other occurences of this pattern and change those too
> (pgtable stuff in head.S, clidr in cache.S).

I will not change those things, due to the following reasons.
So, I will send v3 patch that fixes only dcache_line_size in
proc-macros.S.

1. pgtable stuff in head.S
'ubfx' can be used instead of 'ubfm'. Also, additional definition
such as 'PGDIR_WIDTH' is necessary.

./arch/arm64/kernel/head.S
@@ -371,8 +371,7 @@ ENDPROC(__calc_phys_offset)
  * Corrupts:   tmp1, tmp2
  */
        .macro  create_pgd_entry, pgd, tbl, virt, tmp1, tmp2
-       lsr     \tmp1, \virt, #PGDIR_SHIFT
-       and     \tmp1, \tmp1, #PTRS_PER_PGD - 1 // PGD index
+       ubfx    \tmp1, \virt, #PGDIR_SHIFT, #PGDIR_WIDTH        // PGD index

./arch/arm64/include/asm/pgtable-2level-hwdef.h
@@ -32,6 +32,7 @@
+#define PGDIR_WIDTH            13

./arch/arm64/include/asm/pgtable-3level-hwdef.h
@@ -32,6 +32,7 @@
+#define PGDIR_WIDTH            9


2. clidr in cache.S
'ubfm' can be used; however, additional 'lsl' is necessary.

ENTRY(__flush_dcache_all)
        dsb     sy                              // ensure ordering with previous memory accesses
        mrs     x0, clidr_el1                   // read clidr
-       and     x3, x0, #0x7000000              // extract loc from clidr
-       lsr     x3, x3, #23                     // left align loc bit field
+       ubfm    x3, x0, #24, #26
+       lsl     x3, x3, #1
        cbz     x3, finished                    // if loc is 0, then no need to clean
        mov     x10, #0                         // start clean at cache level 0

Best regards,
Jingoo Han
