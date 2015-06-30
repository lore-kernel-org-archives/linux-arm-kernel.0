From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Jun 2015 20:50:31 +0200
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <5592C1BB.9090106@arm.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
 <20150629100304.GB18931@leverpostej> <55914033.5060008@arm.com>
 <CAL5wTH7EUh0ciutXKs2s-4VjKnRM65QmrUQQiRdM=R+_VXi6DA@mail.gmail.com>
 <559270D3.8030305@arm.com>
 <CAL5wTH4H7DiE-Z-YHCs7mLRPoixOOxi=yMk-j8yC1np1m=9sYw@mail.gmail.com>
 <5592C1BB.9090106@arm.com>
Message-ID: <20150630185031.GA23001@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 05:20:11PM +0100, Marc Zyngier wrote:
> On 30/06/15 17:16, Dirk M?ller wrote:
> > Hi Marc,
> > 
> >> Can try the following patch?
> > 
> > [..]
> > 
> > Thanks a lot for the quick patch, from a brief testing this seems to
> > fix the issue (on a 4k kernel). I'll retest this in our original
> > configuration (which was 64k) but so far I don't see a reason why it
> > shouldn't fix the issue.
> 
> Awesome. Mind if I put your Tested-by on the patch?
> 
Looks to me like the definition of pmd_huge() on arm64 is broken; pretty
sure when I reviewed this original patch I followed the path of both
pmd_huge() and pmd_trans_huge() and checked that they don't return true
if the entry is clear.  This happens to be the case on both arm and x86,
and I probably only looked at the arm code and not the arm64 code.

I'm fine with this patch, but I think we should also merge the
following, since by definition, a clear pmd cannot also be a huge pmd:

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 2de9d2e..779520b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -40,7 +40,7 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 
 int pmd_huge(pmd_t pmd)
 {
-	return !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
 }
 
 int pud_huge(pud_t pud)

 Thanks,
 -Christoffer
