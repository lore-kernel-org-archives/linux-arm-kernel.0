From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Feb 2014 10:20:23 +0000
Subject: [RFC/PATCH v2] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
References: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140209102023.GL26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 05:05:49PM -0600, Nathan Lynch wrote:
> +	/* Grab the vDSO code pages. */
> +	for (i = 0; i < vdso_pages; i++) {
> +		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
> +		ClearPageReserved(pg);
> +		get_page(pg);
> +		vdso_pagelist[i] = pg;
> +	}

Why do we want to clear the reserved status?  This looks over complicated
to me.

> +
> +	/* Sanity check the shared object header. */
> +	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
> +	if (vbase == NULL) {
> +		pr_err("Failed to map vDSO pagelist!\n");
> +		return -ENOMEM;
> +	} else if (memcmp(vbase, "\177ELF", 4)) {
> +		pr_err("vDSO is not a valid ELF object!\n");
> +		ret = -EINVAL;
> +		goto unmap;
> +	}

Why do we need to vmap() pages which are already accessible - vdso_start
must be part of the kernel image, and therefore will be accessible via
standard mappings.

> +
> +	/* Grab the vDSO data page. */
> +	pg = virt_to_page(vdso_data);
> +	get_page(pg);
> +	vdso_pagelist[i] = pg;

Same goes for this.

> +static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
> +{
> +	register struct timespec *ts asm("r1") = _ts;
> +	register clockid_t clkid asm("r0") = _clkid;
> +	register long ret asm ("r0");
> +	register long nr asm("r7") = __NR_clock_gettime;
> +
> +	asm("swi #0" : "=r" (ret) : "r" (clkid), "r" (ts), "r" (nr) : "memory");

This isn't compatible with OABI, so either this must not be enabled when
AEABI is disabled, or this needs to be fixed.

> +static long clock_getres_fallback(clockid_t _clkid, struct timespec *_ts)
> +{
> +	register struct timespec *ts asm("r1") = _ts;
> +	register clockid_t clkid asm("r0") = _clkid;
> +	register long ret asm ("r0");
> +	register long nr asm("r7") = __NR_clock_getres;
> +
> +	asm volatile(
> +		"swi #0" :
> +		"=r" (ret) :
> +		"r" (clkid), "r" (ts), "r" (nr) :
> +		"memory");

Same here.

> +static long gettimeofday_fallback(struct timeval *_tv, struct timezone *_tz)
> +{
> +	register struct timezone *tz asm("r1") = _tz;
> +	register struct timeval *tv asm("r0") = _tv;
> +	register long ret asm ("r0");
> +	register long nr asm("r7") = __NR_gettimeofday;
> +
> +	asm("swi #0" : "=r" (ret) : "r" (tv), "r" (tz), "r" (nr) : "memory");

and here.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
