From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 May 2011 14:19:58 +0100
Subject: [RFC PATCH 1/2] arm: introduce arch_ioremap and arch_iounmap
	function pointer
In-Reply-To: <20110522110543.GB15292@game.jcrosoft.org>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<20110522100342.GD17672@n2100.arm.linux.org.uk>
	<20110522110543.GB15292@game.jcrosoft.org>
Message-ID: <20110522131958.GF17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 22, 2011 at 01:05:43PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> did see that and I should I did it on at91 too
> 
> so how about introduce a new ioreamap/iouremap functiom

How about not.  How about we intercept all the ioremap() calls at a better
place like at the beginning of __arm_ioremap_pfn_caller() - iow, something
like this:

void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
        unsigned long offset, size_t size, unsigned int mtype, void *caller)
{
        const struct mem_type *type;
        int err;
        unsigned long addr;
        struct vm_struct * area;

        /*
         * High mappings must be supersection aligned
         */
        if (pfn >= 0x100000 && (__pfn_to_phys(pfn) & ~SUPERSECTION_MASK))
                return NULL;

        /*
         * Don't allow RAM to be mapped - this causes problems with ARMv6+
         */
        if (WARN_ON(pfn_valid(pfn)))
                return NULL;

        type = get_mem_type(mtype);
        if (!type)
                return NULL;

        /*
         * Page align the mapping size, taking account of any offset.
         */
        size = PAGE_ALIGN(offset + size);

+	addr = __arch_ioremap(pfn, size);
+	if (addr)
+		return (void __iomem *) (offset + addr);
	...

and then we can have __arch_ioremap() do whatever checking of static
mappings we desire.
