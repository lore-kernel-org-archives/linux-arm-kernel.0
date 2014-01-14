From: js07.lee@samsung.com (=?ks_c_5601-1987?B?wMzBpL3C?=)
Date: Tue, 14 Jan 2014 22:42:35 +0900
Subject: Question on flush_pfn_alias function.
Message-ID: <001f01cf112e$7bb98f80$732cae80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin,

I found below function and that clean and invalidate data cache range with
"mcrr"
The end address is end of page - L1_CACHE_BYTES (e.g. 32 , 64)

+static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
+{
+	unsigned long to = ALIAS_FLUSH_START + (CACHE_COLOUR(vaddr) <<
PAGE_SHIFT);
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
