From: sergey.senozhatsky@gmail.com (Sergey Senozhatsky)
Date: Thu, 16 Jun 2016 22:36:38 +0900
Subject: [PATCH] ARM: mm: Speed up page list initialization during boot
In-Reply-To: <20160616021813.GB658@swordfish>
References: <004001d14158$114be8d0$33e3ba70$@samsung.com>
 <005101d14158$b50842c0$1f18c840$@samsung.com>
 <CAJFHJrpgHmcXBwuV5i4nH4SOL-OwrY2-+Fe7x9W2c6GWW=F7bg@mail.gmail.com>
 <20160102103722.GQ8644@n2100.arm.linux.org.uk>
 <002c01d1479f$49ea2970$ddbe7c50$@samsung.com>
 <20160616021813.GB658@swordfish>
Message-ID: <20160616133638.GA523@swordfish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (06/16/16 11:18), Sergey Senozhatsky wrote:
> On (01/05/16 18:56), Jungseung Lee wrote:
> [..]
> > > > >> #ifdef CONFIG_HIGHMEM
> > > > >> static inline void free_area_high(unsigned long pfn, unsigned long
> > > > >>end)  {
> > > > >>-      for (; pfn < end; pfn++)
> > > > >>-              free_highmem_page(pfn_to_page(pfn));
> > > > >>+      while (pfn < end) {
> > > > >>+              struct page *page = pfn_to_page(pfn);
> > > > >>+              unsigned long order = min(__ffs(pfn), MAX_ORDER - 1);
> > > > >>+              unsigned long nr_pages = 1 << order;
> > > > >>+              unsigned long rem = end - pfn;
> > > > >>+
> > > > >>+              if (nr_pages > rem) {
> > > > >>+                      order = __fls(rem);
> > > > >>+                      nr_pages = 1 << order;
> > > > >>+              }
> > > > >>+
> > > > >>+              __free_pages_bootmem(page, order);
> > > > >>+              totalram_pages += nr_pages;
> > > > >>+              totalhigh_pages += nr_pages;
> 
> +			page_zone(page)->managed_pages += nr_pages;  ???

ah, no. __free_pages_boot_core() seems to do it. sorry for the noise.

	-ss
