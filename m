From: rabin@rab.in (Rabin Vincent)
Date: Thu, 29 Sep 2016 10:59:52 +0200
Subject: [PATCH] ARM: *: mm: Implement get_user_pages_fast()
In-Reply-To: <CACOPJM6AC5TwSEPUA7Df8F-FuChrjVP1TWVNeSrHt6ZaSyFiGg@mail.gmail.com>
References: <CACOPJM6AC5TwSEPUA7Df8F-FuChrjVP1TWVNeSrHt6ZaSyFiGg@mail.gmail.com>
Message-ID: <20160929085952.GA15574@lnxartpec.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 07:00:28PM -0700, Yuriy Romanenko wrote:
> +int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> + struct page **pages)
> +{
> + struct mm_struct *mm = current->mm;
> + int ret;
> + unsigned long page_addr = (start & PAGE_MASK);
> + int nr = 0;
> +
> + struct gup_private_data private_data = {
> + .nr = 0,
> + .pages = pages,
> + .write = write
> + };
> +
> + struct mm_walk gup_walk = {
> + .pte_entry = gup_pte_entry,
> + .pte_hole = gup_pte_hole_entry,
> + .mm = mm,
> + .private = (void *)&private_data
> + };
> +
> + ret = walk_page_range(page_addr,
> + page_addr + nr_pages * PAGE_SIZE,
> + &gup_walk);
> + nr = ret ? ret : nr_pages;

walk_page_range() can't be called without the mmap_sem.

  * Locking:
  *   Callers of walk_page_range() and walk_page_vma() should hold
  *   @walk->mm->mmap_sem, because these function traverse vma list and/or
  *   access to vma's data.
  */
 int walk_page_range(unsigned long start, unsigned long end,
 		    struct mm_walk *walk)
 {
 	int err = 0;
 	unsigned long next;
 	struct vm_area_struct *vma;
 
 	if (start >= end)
 		return -EINVAL;
 
 	if (!walk->mm)
 		return -EINVAL;
 
 	VM_BUG_ON_MM(!rwsem_is_locked(&walk->mm->mmap_sem), walk->mm);
