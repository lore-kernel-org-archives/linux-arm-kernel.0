From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 26 Feb 2010 11:22:50 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002250448.17866.oliver@neukum.org>
References: <1266445892.16346.306.camel@pasglop>
	<201002240816.10178.oliver@neukum.org>
	<1267045954.23523.1692.camel@pasglop>
	<201002250448.17866.oliver@neukum.org>
Message-ID: <1267143770.23523.1763.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-25 at 04:48 +0100, Oliver Neukum wrote:
> Am Mittwoch, 24. Februar 2010 22:12:34 schrieb Benjamin Herrenschmidt:
> > On Wed, 2010-02-24 at 08:16 +0100, Oliver Neukum wrote:
> > > I don't know. The issue seems quite complex. It would seem better to
> > > centralize it as far as practical. Do you have a wrapper drivers could
> > > call?
> > 
> > flush_dcache_page() ? :-)
> 
> Will this do anything on arches that don't need it?

No, it's going to be an empty inline:

arch/x86/include/asm/cacheflush.h:static inline void flush_dcache_page(struct page *page) { }

> Secondly, can we have a wrapper that you can pass a pointer and an
> offset?

I'm sure you can make one :-) Use virt_to_page() though that will not
work for vmap/vmalloc space of course.
 
> > Now, the subsystem might be the one to know whether something is mapped
> > into userspace or not (v4l in our case) in which case a wrapper could be
> > created.
> 
> If possible, I'd like to centralize this. Drivers are likely to get this wrong.

Right. In the case of v4l, it's probably something that should go into
the subsystem. IE. That's how it works for block too, it's done at the
BIO and/or filesystem layer (though individual filesystems do have their
hand in the pudding). 

Cheers,
Ben.

> 	Regards
> 		Oliver
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
