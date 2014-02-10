From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 10 Feb 2014 17:57:19 -0600
Subject: [RFC/PATCH v2] ARM: vDSO gettimeofday using generic timer
 architecture
In-Reply-To: <20140209102023.GL26684@n2100.arm.linux.org.uk>
References: <1391814349-10706-1-git-send-email-nathan_lynch@mentor.com>
 <20140209102023.GL26684@n2100.arm.linux.org.uk>
Message-ID: <52F9675F.1040403@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2014 04:20 AM, Russell King - ARM Linux wrote:
> On Fri, Feb 07, 2014 at 05:05:49PM -0600, Nathan Lynch wrote:
>> +	/* Grab the vDSO code pages. */
>> +	for (i = 0; i < vdso_pages; i++) {
>> +		pg = virt_to_page(&vdso_start + i*PAGE_SIZE);
>> +		ClearPageReserved(pg);
>> +		get_page(pg);
>> +		vdso_pagelist[i] = pg;
>> +	}
> 
> Why do we want to clear the reserved status?  This looks over complicated
> to me.
> 
>> +
>> +	/* Sanity check the shared object header. */
>> +	vbase = vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
>> +	if (vbase == NULL) {
>> +		pr_err("Failed to map vDSO pagelist!\n");
>> +		return -ENOMEM;
>> +	} else if (memcmp(vbase, "\177ELF", 4)) {
>> +		pr_err("vDSO is not a valid ELF object!\n");
>> +		ret = -EINVAL;
>> +		goto unmap;
>> +	}
> 
> Why do we need to vmap() pages which are already accessible - vdso_start
> must be part of the kernel image, and therefore will be accessible via
> standard mappings.

Right, this stuff doesn't appear to be necessary.  Removed the vmap,
get_page, and ClearPageReserved calls for v3.


>> +static long clock_gettime_fallback(clockid_t _clkid, struct timespec *_ts)
>> +{
>> +	register struct timespec *ts asm("r1") = _ts;
>> +	register clockid_t clkid asm("r0") = _clkid;
>> +	register long ret asm ("r0");
>> +	register long nr asm("r7") = __NR_clock_gettime;
>> +
>> +	asm("swi #0" : "=r" (ret) : "r" (clkid), "r" (ts), "r" (nr) : "memory");
> 
> This isn't compatible with OABI, so either this must not be enabled when
> AEABI is disabled, or this needs to be fixed.

Okay.  I'll plan on making the vdso code depend on CONFIG_AEABI, likely
indirectly via a CONFIG_VDSO Kconfig option.  Since you'll need an
updated C library to actually benefit from the vdso, I doubt any OABI
support in this code would get any use.

Thanks for reviewing.
