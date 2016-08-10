From: danielmicay@gmail.com (Daniel Micay)
Date: Wed, 10 Aug 2016 13:06:34 -0400
Subject: [kernel-hardening] Re: [PATCH 2/2] arm: apply more __ro_after_init
In-Reply-To: <20160810094339.GK1041@n2100.armlinux.org.uk>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org>
 <20160810094339.GK1041@n2100.armlinux.org.uk>
Message-ID: <1470848794.22360.1.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-10 at 10:43 +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> > 
> > @@ -1309,16 +1309,11 @@ void __init arm_mm_memblock_reserve(void)
> > ? * Any other function or debugging method which may touch any
> > device _will_
> > ? * crash the kernel.
> > ? */
> > +static char vectors[PAGE_SIZE * 2] __ro_after_init
> > __aligned(PAGE_SIZE);
> > ?static void __init devicemaps_init(const struct machine_desc
> > *mdesc)
> > ?{
> > ?	struct map_desc map;
> > ?	unsigned long addr;
> > -	void *vectors;
> > -
> > -	/*
> > -	?* Allocate the vector page early.
> > -	?*/
> > -	vectors = early_alloc(PAGE_SIZE * 2);
> 
> This one is not appropriate.??We _do_ write to these pages after init
> for FIQ handler updates.??See set_fiq_handler().

This is one of the many cases where pax_open_kernel/pax_close_kernel are
needed to temporarily toggle it read-only. From grsecurity:

@@ -95,7 +95,10 @@ void set_fiq_handler(void *start, unsigned int
length)
?	void *base = vectors_page;
?	unsigned offset = FIQ_OFFSET;
?
+	pax_open_kernel();
?	memcpy(base + offset, start, length);
+	pax_close_kernel();
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 851 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/5bdd557b/attachment.sig>
