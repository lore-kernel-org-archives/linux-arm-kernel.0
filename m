From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 27 Jan 2012 11:44:05 +0200
Subject: [Linaro-mm-sig] [PATCH 12/15] drivers: add Contiguous Memory
 Allocator
In-Reply-To: <1327568457-27734-13-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CADMYwHw1B4RNV_9BqAg_M70da=g69Z3kyo5Cr6izCMwJ9LAtvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

With v19, I can't seem to allocate big regions anymore (e.g. 101MiB).
In particular, this seems to fail:

On Thu, Jan 26, 2012 at 11:00 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> +static int cma_activate_area(unsigned long base_pfn, unsigned long count)
> +{
> + ? ? ? unsigned long pfn = base_pfn;
> + ? ? ? unsigned i = count >> pageblock_order;
> + ? ? ? struct zone *zone;
> +
> + ? ? ? WARN_ON_ONCE(!pfn_valid(pfn));
> + ? ? ? zone = page_zone(pfn_to_page(pfn));
> +
> + ? ? ? do {
> + ? ? ? ? ? ? ? unsigned j;
> + ? ? ? ? ? ? ? base_pfn = pfn;
> + ? ? ? ? ? ? ? for (j = pageblock_nr_pages; j; --j, pfn++) {
> + ? ? ? ? ? ? ? ? ? ? ? WARN_ON_ONCE(!pfn_valid(pfn));
> + ? ? ? ? ? ? ? ? ? ? ? if (page_zone(pfn_to_page(pfn)) != zone)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;

The above WARN_ON_ONCE is triggered, and then the conditional is
asserted (page_zone() retuns a "Movable" zone, whereas zone is
"Normal") and the function fails.

This happens to me on OMAP4 with your 3.3-rc1-cma-v19 branch (and a
bunch of remoteproc/rpmsg patches).

Do big allocations work for you ?

Thanks,
Ohad.
