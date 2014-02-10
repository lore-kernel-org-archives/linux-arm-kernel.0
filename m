From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 17:12:00 +0000
Subject: [RFC/PATCH v2] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <20140210165113.GA7891@linaro.org>
References: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
 <20140209102023.GL26684@n2100.arm.linux.org.uk>
 <20140210165113.GA7891@linaro.org>
Message-ID: <20140210171200.GE26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:51:16PM +0000, Steve Capper wrote:
> Hi Russell,
> 
> On Sun, Feb 09, 2014 at 10:20:23AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 07, 2014 at 05:05:49PM -0600, Nathan Lynch wrote:
> > > +	/* Grab the vDSO code pages. */
> > > +	for (i = 0; i < vdso_pages; i++) {
> > > +		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
> > > +		ClearPageReserved(pg);
> > > +		get_page(pg);
> > > +		vdso_pagelist[i] = pg;
> > > +	}
> > 
> > Why do we want to clear the reserved status?  This looks over complicated
> > to me.
> > 
> 
> This looks like it was inherited from the PowerPC code where the
> behaviour of set_pte_at would change dependent on whether or not the
> page was reserved (set_pte_at->set_pte_filter->maybe_pte_to_page). I
> think we can safely remove this from ARM and ARM64.

Great, so we can get rid of that and the get_page() on the vdso data
page below.

> > > +
> > > +	/* Sanity check the shared object header. */
> > > +	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
> > > +	if (vbase == NULL) {
> > > +		pr_err("Failed to map vDSO pagelist!\n");
> > > +		return -ENOMEM;
> > > +	} else if (memcmp(vbase, "\177ELF", 4)) {
> > > +		pr_err("vDSO is not a valid ELF object!\n");
> > > +		ret = -EINVAL;
> > > +		goto unmap;
> > > +	}
> > 
> > Why do we need to vmap() pages which are already accessible - vdso_start
> > must be part of the kernel image, and therefore will be accessible via
> > standard mappings.
> > 
> 
> This is a dress rehersal for install_special_mapping more than anything.
> If we map the page, and look at the first 4 bytes, are they what we
> expect?

My point is that we can already view this page directly by dereferencing
vdso_start - do we really need to perform this apparant test of the MMU?
If the MMU isn't working in this way, we have much bigger and more
fundamental problems...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
