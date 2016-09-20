From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Sep 2016 16:46:23 +0900
Subject: [PATCH v26 3/7] arm64: kdump: add kdump support
In-Reply-To: <57DC06B0.8030504@arm.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-4-takahiro.akashi@linaro.org>
 <57DC06B0.8030504@arm.com>
Message-ID: <20160920074622.GD30248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 03:50:24PM +0100, James Morse wrote:
> On 07/09/16 05:29, AKASHI Takahiro wrote:
> > On crash dump kernel, all the information about primary kernel's system
> > memory (core image) is available in elf core header.
> > The primary kernel will set aside this header with reserve_elfcorehdr()
> > at boot time and inform crash dump kernel of its location via a new
> > device-tree property, "linux,elfcorehdr".
> > 
> > Please note that all other architectures use traditional "elfcorehdr="
> > kernel parameter for this purpose.
> > 
> > Then crash dump kernel will access the primary kernel's memory with
> > copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> > not reside in linear mapping on crash dump kernel.
> > 
> > We also need our own elfcorehdr_read() here since the header is placed
> > within crash dump kernel's usable memory.
> 
> One nit below, looks good.

Fixed.

Thanks,
-Takahiro AKASHI

> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> 
> > +/**
> > + * copy_oldmem_page() - copy one page from old kernel memory
> > + * @pfn: page frame number to be copied
> > + * @buf: buffer where the copied page is placed
> > + * @csize: number of bytes to copy
> > + * @offset: offset in bytes into the page
> > + * @userbuf: if set, @buf is in a user address space
> > + *
> > + * This function copies one page from old kernel memory into buffer pointed by
> > + * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> > + * copied or negative error in case of failure.
> > + */
> > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > +			 size_t csize, unsigned long offset,
> > +			 int userbuf)
> > +{
> > +	void *vaddr;
> > +
> > +	if (!csize)
> > +		return 0;
> > +
> > +	vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > +	if (!vaddr)
> > +		return -ENOMEM;
> > +
> > +	if (userbuf) {
> 
> > +		if (copy_to_user(buf, vaddr + offset, csize)) {
> 
> If you re-cast buf with (char __user *), it should stop sparse complaining:
> > ../arch/arm64/kernel/crash_dump.c:45:34: warning: incorrect type in argument 1
> (different address spaces)
> > ../arch/arm64/kernel/crash_dump.c:45:34:    expected void [noderef] <asn:1>*to
> > ../arch/arm64/kernel/crash_dump.c:45:34:    got char *buf
> 
> 
