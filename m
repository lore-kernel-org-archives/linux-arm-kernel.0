From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 23 Feb 2016 13:32:21 +0300
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160212181640.4eabb85f@thinkpad>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
Message-ID: <20160223103221.GA1418@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 06:16:40PM +0100, Gerald Schaefer wrote:
> On Fri, 12 Feb 2016 16:57:27 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > 
> > Don't know, Gerald or Martin?
> 
> The implementation frequently changes depending on how many new bits Martin
> needs to squeeze out :-)
> We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> entry is not empty. pmd_none() of course does the opposite, it checks if it is
> empty.

I still worry about pmd_present(). It looks wrong to me. I wounder if
patch below makes a difference.

The theory is that the splitting bit effetely masked bogus pmd_present():
we had pmd_trans_splitting() in all code path and that prevented mm from
touching the pmd. Once pmd_trans_splitting() has gone, mm proceed with the
pmd where it shouldn't and here's a boom.

I'm not sure that the patch is correct wrt yound/old pmds and I have no
way to test it...

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 64ead8091248..2eeb17ab68ac 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -490,7 +490,7 @@ static inline int pud_bad(pud_t pud)
 
 static inline int pmd_present(pmd_t pmd)
 {
-	return pmd_val(pmd) != _SEGMENT_ENTRY_INVALID;
+	return !(pmd_val(pmd) & _SEGMENT_ENTRY_INVALID);
 }
 
 static inline int pmd_none(pmd_t pmd)
-- 
 Kirill A. Shutemov
