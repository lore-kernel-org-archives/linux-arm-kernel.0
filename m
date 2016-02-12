From: james.morse@arm.com (James Morse)
Date: Fri, 12 Feb 2016 17:47:47 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56BE1AC3.409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 01/02/16 10:54, Ard Biesheuvel wrote:
> This moves the module area to right before the vmalloc area, and
> moves the kernel image to the base of the vmalloc area. This is
> an intermediate step towards implementing KASLR, which allows the
> kernel image to be located anywhere in the vmalloc area.

I've rebased hibernate onto for-next/core, and this patch leads to the hibernate
core code falling down a kernel shaped hole in the linear map.

The hibernate code assumes that for zones returned by for_each_populated_zone(),
if pfn_valid() says a page is present, then it is okay to access the page via
page_address(pfn_to_page(pfn)). But for pfns that correspond to the kernel text,
this is still returning an address in the linear map, which isn't mapped...

I'm not sure what the correct fix is here.
Should this sort of walk be valid?


>From include/linux/mm.h:
> static __always_inline void *lowmem_page_address(const struct page *page)
> {
>	return __va(PFN_PHYS(page_to_pfn(page)));
> }


Suggestions welcome!


Thanks,

James
