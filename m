From: geoff@infradead.org (Geoff Levand)
Date: Mon, 20 Jun 2016 09:49:43 -0700
Subject: [PATCH v19 03/13] arm64/kexec: Add core kexec support
In-Reply-To: <57680D94.6080704@arm.com>
References: <cover.1466120418.git.geoff@infradead.org>
 <b5534d3ea3662d9f7fc5909b158ab36d135d8f6d.1466120418.git.geoff@infradead.org>
 <57680D94.6080704@arm.com>
Message-ID: <1466441383.7965.15.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2016-06-20 at 16:36 +0100, James Morse wrote:
> +> 	> 	> switch (flag) {
> > +> > 	> > 	> > case IND_INDIRECTION:
> > +> > 	> > 	> > 	> > /* Set entry point just before the new list page. */
> > +> > 	> > 	> > 	> > entry = (kimage_entry_t *)addr - 1;
> 
> Ah, after this restructuring we end up cleaning this page as we fall-through,
> and one kimage_entry_t at a time as we walk the list.
> 
> 	> 	> 	> break;
> ?

I added this in, but that missing break shouldn't cause any problems.


> > +> > 	> > 	> > case IND_SOURCE:
> > +> > 	> > 	> > 	> > __flush_dcache_area(addr, PAGE_SIZE);
> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > case IND_DESTINATION:
> > +> > 	> > 	> > 	> > break;
> > +> > 	> > 	> > default:
> > +> > 	> > 	> > 	> > BUG();
> > +> > 	> > 	> > }
> > +> > 	> > }
> > +}
> 
> 
> > diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> > new file mode 100644
> > index 0000000..51b73cd
> > --- /dev/null
> > +++ b/arch/arm64/kernel/relocate_kernel.S
> 
> [ ... ]
> 
> > +.ltorg
> > +
> > +.align 3> > 	> > /* To keep the 64-bit values below naturally aligned. */
> > +
> > +.Lcopy_end:
> > +.org> > 	> > KEXEC_CONTROL_PAGE_SIZE
> 
> 
> On 16/06/16 23:41, Geoff Levand wrote:
> > This is to check if arm64_relocate_new_kernel gets too
> > big.  The assembler should give an error if the location
> > counter is set backwards.
> 
> Cunning. (probably worth a comment).

I thought this was the standard way to do it...

> This looks like it is need because we hard-coded KEXEC_CONTROL_PAGE_SIZE in
> kexec.h, so the code must be smaller than that size.
> It looks like this value is only ever passed to get_order(), could we just pass
> the actual size? It shouldn't matter if it grows >4K, as the core code will
> allocate enough memory, and the memcpy() in machine_kexec() uses the size too.

I thought 4K would be enough, but if some debugging code is
added it could get too big.

> Reviewed-by: James Morse <james.morse@arm.com>

Thanks for your comments.

-Geoff
