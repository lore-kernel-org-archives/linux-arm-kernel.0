From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 20:14:01 +0000
Subject: [PATCH v2 17/31] arm64: System calls handling
In-Reply-To: <20120821175122.GI12708@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151422.16335.arnd@arndb.de> <20120821175122.GI12708@arm.com>
Message-ID: <201208212014.01837.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Catalin Marinas wrote:
> > > +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> > > +                    unsigned long prot, unsigned long flags,
> > > +                    unsigned long fd, off_t off)
> > > +{
> > > +   if (offset_in_page(off) != 0)
> > > +           return -EINVAL;
> > > +
> > > +   return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> > > +}
> > 
> > I think
> > 
> > #define sys_mmap sys_mmap_pgoff 
> 
> There are slightly different semantics with the last argument of
> sys_mmap() which takes a byte offset. The sys_mmap_pgoff() function
> takes the offset shifted by PAGE_SHIFT (which is the same as sys_mmap2).
> 
> Looking at the other architectures, it makes sense to use a generic
> sys_mmap() implementation similar to the one above (or the ia-64, seems
> to be the most complete).
> 

Why that? The generic sys_mmap_pgoff was specifically added so new architectures
could just use that instead of having their own wrappers, see f8b72560.

	Arnd
