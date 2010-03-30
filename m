From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Mar 2010 10:30:35 +0100
Subject: [PATCH] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <20100330013132.GA15598@shareable.org>
References: <20100329132457.1967.3394.stgit@e102109-lin.cambridge.arm.com>
	<20100330013132.GA15598@shareable.org>
Message-ID: <1269941435.17138.36.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-30 at 02:31 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > +void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
> > +                    unsigned long uaddr, void *dst, const void *src,
> > +                    unsigned long len)
> > +{
> > +     memcpy(dst, src, len);
> > +     if (vma->vm_flags & VM_EXEC)
> > +             __cpuc_coherent_user_range(uaddr, uaddr + len);
> > +}
> 
> Does that do the right thing with uaddr + len == 0?

There is a corner case where uaddr + len == 0 and uaddr is at the top of
the 4GB range. Are there such platforms? A workaround is to change the
CPU-specific loop, probably to using BLT rather than BLO.

> Other variations such as writing when a mapping is !VM_EXEC and later
> mapping or mprotecting the same shmem VM_EXEC, but it's even more
> forbidden semantically to write to a read-only mapping (and just as
> unchecked on nommu), and conversion of writable to VM_EXEC ought to
> flush i-cache at mprotect time.

ARM Linux doesn't do any cache maintenance for mprotect on VIPT or noMMU
hardware (not sure about VIVT). We discussed this in the past and it
wasn't clear whether it is required or not.

-- 
Catalin
