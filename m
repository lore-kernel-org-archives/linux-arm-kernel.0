From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 17 Feb 2016 17:04:56 +0200
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160216172444.013988d8@thinkpad>
References: <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160215113159.GA28832@node.shutemov.name>
 <20160215193702.4a15ed5e@thinkpad>
 <20160215213526.GA9766@node.shutemov.name>
 <20160216172444.013988d8@thinkpad>
Message-ID: <20160217150456.GA15882@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 05:24:44PM +0100, Gerald Schaefer wrote:
> On Mon, 15 Feb 2016 23:35:26 +0200
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > Is there any chance that I'll be able to trigger the bug using QEMU?
> > Does anybody have an QEMU image I can use?
> > 
> 
> I have no image, but trying to reproduce this under virtualization may
> help to trigger this also on other architectures. After ruling out IPI
> vs. fast_gup I do not really see why this should be arch-specific, and
> it wouldn't be the first time that we hit subtle races first on s390, due
> to our virtualized environment (my test case is make -j20 with 10 CPUs and
> 4GB of memory, no swap).

Could you post your kernel config?

It would be nice also to check if disabling split_huge_page() would make
any difference:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a75081ca31cf..26d2b7b21021 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3364,6 +3364,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	bool mlocked;
 	unsigned long flags;
 
+	return -EBUSY;
+
 	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-- 
 Kirill A. Shutemov
