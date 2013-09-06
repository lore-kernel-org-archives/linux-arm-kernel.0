From: thommyj@gmail.com (Thommy Jakobsson)
Date: Fri, 6 Sep 2013 11:36:07 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <1378458778.4208.30.camel@weser.hi.pengutronix.de>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
Message-ID: <alpine.DEB.2.02.1309061123530.1299@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 6 Sep 2013, Lucas Stach wrote:

> > static int device_mmap(struct file *filp, struct vm_area_struct *vma)
> >  {
> > 	unsigned long size;
> > 	int res = 0;
> > 	size = vma->vm_end - vma->vm_start;
> > 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > 
> This is the relevant part where you are mapping things uncached into
> userspace, so no wonder it is slower than cached malloc memory. If you
> want to use cached userspace mappings you need bracketed MMAP access,
> where you tell the kernel by using an ioctl or something that userspace
> is accessing the mapping so it can flush/invalidate caches at the right
> points in time.
Well that explains it, you think that calling a function named noncached 
would have be a tell, but apparently no =). Thanks Lucas for spotting 
that. I should not copy and paste so much I guess.

> Before doing so read up on how conflicting page mappings can lead to
> undefined behavior on ARMv7 systems and consider the consequences
> carefully. If you aren't sure you understood the problem fully and know
> how to mitigate the problems, back out and live with an uncached or
> writecombined mapping.
I have read up a bit on it, but isn't so that I have conflicting page 
mappings now in my test? Since the kernel is accessing the buffer as 
cached and userspace as noncached? If I would use cached in both places I 
assume that I wouldn't have conflicting page mappings?

Thanks,
Thommy
