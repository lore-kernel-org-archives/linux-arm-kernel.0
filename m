From: majun258@huawei.com (majun (F))
Date: Fri, 27 Nov 2015 10:31:20 +0800
Subject: ARM: Question about irq-gic-v3-its.c
Message-ID: <5657C078.3020806@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc:
	I think there is a bug in current its_alloc_tables().
When "val |= alloc_pages - 1;" is called
the "alloc_pages" is not updated accroding to "psz" value.

I mean we need do
alloc_pages = (alloc_size / psz);

Further more, I also have a question about GITS_CBASER register.
In gic-v3 spec:

Bits [7:0]. Size. The number of '4kB' pages of physical memory provided for the command queue, minus
one.

But In its_alloc_tables() function,

alloc_pages = (alloc_size / psz);   //  majun: pze = 64KB
if (alloc_pages > GITS_BASER_PAGES_MAX) {
	alloc_pages = GITS_BASER_PAGES_MAX;
	order = get_order(GITS_BASER_PAGES_MAX * psz);
	pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u (%u pages)\n",
		its->phys_base, order, alloc_pages);
}
GITS_BASER_PAGES_MAX = 256
I think this value means the maximum page number of 4KB ,right ?

But when calc alloc_pages for first time, the psz = 64KB.

So, I think maybe this is a bug too.

Thanks!
Ma Jun
