From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 24 Nov 2016 14:42:38 +0100
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <CAKv+Gu8aWpz5vXSWdKHwL5Xk2aWyQBOoR1WHOnVPaWZOwqojBQ@mail.gmail.com>
References: <20161017185801.GT25086@rric.localdomain>
 <20161027160136.GD24290@arm.com>
 <20161028091905.GM22012@rric.localdomain>
 <20161107210514.GP20591@arm.com>
 <20161109195132.GZ22012@rric.localdomain>
 <20161117142528.GJ22855@arm.com>
 <20161117151805.GJ2151@rric.localdomain>
 <CAKv+Gu-2uGJGovqQL-gbB54u=fQ9L9YUbDdRo6u3oWqF6znn6Q@mail.gmail.com>
 <20161123211538.GH10776@rric.localdomain>
 <CAKv+Gu8aWpz5vXSWdKHwL5Xk2aWyQBOoR1WHOnVPaWZOwqojBQ@mail.gmail.com>
Message-ID: <20161124134238.GI10776@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.11.16 21:25:06, Ard Biesheuvel wrote:
> Why? MEMREMAP_WB is used often, among other things for mapping
> firmware tables, which are marked as NOMAP, so in these cases, the
> linear address is not mapped.

If fw tables are mapped wb, that is wrong and needs a separate fix.

> > If you think pfn_valid() is wrong here, I am happy to send a patch
> > that fixes this by using page_is_ram(). In any case, the worst case
> > that may happen is to behave the same as v4.4, we might fix then the
> > wrong use of pfn_valid() where it is not correctly used to check for
> > ram.
> >
> 
> page_is_ram() uses string comparisons to look for regions called
> 'System RAM'. Is that something we can tolerate for each pfn_valid()
> calll?
> 
> Perhaps the solution is to reimplement page_is_ram() for arm64 using
> memblock_is_memory() instead, But that still means we need to modify
> the generic memremap() code first to switch to it before changing the
> arm64 implementation of pfn_valid

No, that's not the solution. pfn_valid() should just check if there is
a valid struct page, as other archs do. And if there is a mis-use of
pfn_valid() to check for ram, only that calls should be fixed to use
page_is_ram(), however this is implemented, or something appropriate.
But I don't see any problematic code, and if so, I will fix that.

-Robert
