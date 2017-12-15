From: willy@infradead.org (Matthew Wilcox)
Date: Fri, 15 Dec 2017 11:35:51 -0800
Subject: [Question ]: Avoid kernel panic when killing an application if
 happen RAS page table error
In-Reply-To: <5A3419F3.1030804@arm.com>
References: <0184EA26B2509940AA629AE1405DD7F2019C8B36@DGGEMA503-MBS.china.huawei.com>
 <20171205165727.GG3070@tassilo.jf.intel.com>
 <0276f3b3-94a5-8a47-dfb7-8773cd2f99c5@huawei.com>
 <dedf9af6-7979-12dc-2a52-f00b2ec7f3b6@huawei.com>
 <0b7bb7b3-ae39-0c97-9c0a-af37b0701ab4@huawei.com>
 <eab54efe-0ab4-bf6a-5831-128ff02a018b@huawei.com>
 <5A3419F3.1030804@arm.com>
Message-ID: <20171215193551.GD27160@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 06:52:35PM +0000, James Morse wrote:
> Leaking any memory that isn't marked as poisoned isn't a good idea.
> 
> What you would need is a way to know from the struct_page that: this page is
> is page-table, and which struct_mm it belongs to. (If its the kernel's init_mm:
> panic()).
> Next you need a way to find all the other pages of page-table without walking
> them. With these three pieces of information you can free all the unaffected
> memory, with even more work you can probably regenerate the corrupted page.
> 
> It's going to be complicated to do, I don't think its worth the effort.

We can find a bit in struct page that we guarantee will only be set if
this is allocated as a pagetable.  Bit 1 of the third union is currently
available (compound_head is a pointer if bit 0 is set, so nothing is
using bit 1).  We can put a pointer to the mm_struct in the same word.

Finding all the allocated pages will be the tricky bit.  We could put a
list_head into struct page; perhaps in the same spot as page_deferred_list
for tail pages.  Then we can link all the pagetables belonging to
this mm together and tear them all down if any of them get an error.
They'll repopulate on demand.  It won't be quick or scalable, but when
the alternative is death, it looks relatively attractive.
