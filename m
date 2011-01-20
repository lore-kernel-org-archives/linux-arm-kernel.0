From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 20 Jan 2011 09:25:13 -0800
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <20110120142844.GA28358@barrios-desktop>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<20110120142844.GA28358@barrios-desktop>
Message-ID: <1295544313.9039.618.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-20 at 23:28 +0900, Minchan Kim wrote:
> On Thu, Jan 20, 2011 at 06:45:39PM +0900, KyongHo Cho wrote:
> > Sparsemem allows that a bank of memory spans over several adjacent
> > sections if the start address and the end address of the bank
> > belong to different sections.
> > When gathering statictics of physical memory in mem_init() and
> > show_mem(), this possiblity was not considered.
> 
> Please write down the result if we doesn't consider this patch.
> I can understand what happens but for making good description and review,
> merging easily, it would be better to write down the result without 
> the patch explicitly. 

You'll oops.  __section_mem_map_addr() in:

> #define __pfn_to_page(pfn)                              \
> ({      unsigned long __pfn = (pfn);                    \
>         struct mem_section *__sec = __pfn_to_section(__pfn);    \
>         __section_mem_map_addr(__sec) + __pfn;          \
> })

will return NULL, you'll add some fuzz on to it with __pfn, then you'll
oops when the arm show_mem() does PageReserved() and dereferences
page->flags.

Ether that, or with the sparsemem vmemmap variant, you'll get a
valid-looking pointer with no backing memory, and oops as well.

-- Dave
