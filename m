From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Feb 2014 10:45:53 +0000
Subject: [RFC/PATCH v2] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <52F9675F.1040403@mentor.com>
References: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
 <20140209102023.GL26684@n2100.arm.linux.org.uk>
 <52F9675F.1040403@mentor.com>
Message-ID: <20140211104553.GD8693@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:57:19PM +0000, Nathan Lynch wrote:
> On 02/09/2014 04:20 AM, Russell King - ARM Linux wrote:
> > On Fri, Feb 07, 2014 at 05:05:49PM -0600, Nathan Lynch wrote:
> >> +	/* Grab the vDSO code pages. */
> >> +	for (i = 0; i < vdso_pages; i++) {
> >> +		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
> >> +		ClearPageReserved(pg);
> >> +		get_page(pg);
> >> +		vdso_pagelist[i] = pg;
> >> +	}
> > 
> > Why do we want to clear the reserved status?  This looks over complicated
> > to me.
> > 
> >> +
> >> +	/* Sanity check the shared object header. */
> >> +	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
> >> +	if (vbase == NULL) {
> >> +		pr_err("Failed to map vDSO pagelist!\n");
> >> +		return -ENOMEM;
> >> +	} else if (memcmp(vbase, "\177ELF", 4)) {
> >> +		pr_err("vDSO is not a valid ELF object!\n");
> >> +		ret = -EINVAL;
> >> +		goto unmap;
> >> +	}
> > 
> > Why do we need to vmap() pages which are already accessible - vdso_start
> > must be part of the kernel image, and therefore will be accessible via
> > standard mappings.
> 
> Right, this stuff doesn't appear to be necessary.  Removed the vmap,
> get_page, and ClearPageReserved calls for v3.

Can you make the corresponding change for arm64 too, please?

> >> +static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
> >> +{
> >> +	register struct timespec *ts asm("r1") = _ts;
> >> +	register clockid_t clkid asm("r0") = _clkid;
> >> +	register long ret asm ("r0");
> >> +	register long nr asm("r7") = __NR_clock_gettime;
> >> +
> >> +	asm("swi #0" : "=r" (ret) : "r" (clkid), "r" (ts), "r" (nr) : "memory");

Might be worth making this volatile, rather than depend on the use of ret.

Also, placing both _clkid and ret into "r0" worries me slightly -- is GCC
smart enough to realise that writing to ret kills _clkid?

Will
