From: js07.lee@samsung.com (=?ks_c_5601-1987?B?wMzBpL3C?=)
Date: Fri, 17 Jan 2014 18:54:42 +0900
Subject: [Q] L1_CACHE_BYTES on flush_pfn_alias function.
Message-ID: <00d501cf136a$24ec49c0$6ec4dd40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Follow the mailing-list
http://comments.gmane.org/gmane.linux.ports.arm.omap/31686

>>Setting the L1 cache line size larger than it actually is should be safe.

the written code expected as L1_CACHE_BYTES should be real cache line size
has bug.
It looks like that flush_pfn_alias function should be fixed.

Anybody to have another opinion?

Cheers,
JS

-----Original Message-----
From: ??? [mailto:js07.lee at samsung.com] 
Sent: Tuesday, January 14, 2014 10:43 PM
To: 'catalin.marinas at arm.com'; 'linux-arm-kernel at lists.infradead.org'
Cc: 'linux at arm.linux.org.uk'
Subject: Question on flush_pfn_alias function.

Dear Catalin,

I found below function and that clean and invalidate data cache range with
"mcrr"
The end address is end of page - L1_CACHE_BYTES (e.g. 32 , 64)

+static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr) {
+	unsigned long to = ALIAS_FLUSH_START + (CACHE_COLOUR(vaddr) << 
+PAGE_SHIFT);
+
+	set_pte(TOP_PTE(to), pfn_pte(pfn, PAGE_KERNEL));
+	flush_tlb_kernel_page(to);
+
+	asm(	"mcrr	p15, 0, %1, %0, c14\n"
+	"	mcrr	p15, 0, %1, %0, c5\n"
+	    :
+	    : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES)
+	    : "cc");
+}

However, follow the mail and current setting in vanilla kernel,
L1_CACHE_BYTES of Cortex A9 will be 64 not 32.
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183316.html
I think that could be problem.

What is your opinion?
