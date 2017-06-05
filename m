From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 05 Jun 2017 12:12:40 +0100
Subject: arm64: segfaults on next-20170602 with LTP tests
In-Reply-To: <87k24q4w0m.fsf@e105922-lin.cambridge.arm.com> (Punit Agrawal's
 message of "Mon, 05 Jun 2017 10:35:37 +0100")
References: <20170602111151.r2x3364zqabmshzo@yury-thinkpad>
 <20170602121917.GG6371@arm.com>
 <20170602123751.3jzdkjwntbce2e6e@yury-thinkpad>
 <20170602144204.uyvbby5vauxpt6yr@yury-thinkpad>
 <20170602152440.GQ6371@arm.com>
 <87k24q4w0m.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <87d1ai4riv.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:

> Will Deacon <will.deacon@arm.com> writes:
>
>> On Fri, Jun 02, 2017 at 05:42:04PM +0300, Yury Norov wrote:
>>> On Fri, Jun 02, 2017 at 03:37:51PM +0300, Yury Norov wrote:
>>> > On Fri, Jun 02, 2017 at 01:19:18PM +0100, Will Deacon wrote:
>>> > > Hi Yury,
>>> > > 
>>> > > [adding Steve and Punit]
>>> > > 
>>> > > On Fri, Jun 02, 2017 at 02:11:51PM +0300, Yury Norov wrote:
>>> > > > I see that latest and yesterday's linux-next segfaults with tests pth_str01,
>>> > > > pth_str03, rwtest04. Rwtest04 hangs sometimes. Crashes are not always
>>> > > > reproducible. About week ago everything was fine. Kernel log and config file
>>> > > > are attached. The testing is performed on qemu.
>>> > > 
>>> > > It's weird that these haven't cropped up in our nightly tests, especially
>>> > > given that defconfig is very similar to the one you're using. That said,
>>> > > I see huge pmds cropping up in the traces below and there have been some
>>> > > recent changes from Punit and Steve in that area, in particular things
>>> > > like 55f379263bcc ("mm, gup: ensure real head page is ref-counted when using
>>> > > hugepages").
>>> > > 
>>> > > Are you in a position to bisect this, or is it too fiddly to reproduce?
>>> 
>>> I have bisected the bug to exactly this patch. If I revert it, the
>>> pth_str01/03 are passed.
>>
>> Thanks for doing that: I had my suspicion ;) I can also reproduce the
>> failure locally on my Juno.
>>
>> Punit -- please can you investigate this? Otherwise I think we have to
>> revert this for now and bring it back after some better testing.
>
> Apologies for the breakage. It looks like anonymous hugepages are not
> happy with the change. Let me dig into this.

I've found the issue - in certain scenarios the ref-count was being
taken on a page following the one of interest. The below fixup (on top
of the patches in next) makes the failures with pth_str0[1|3] go away
for me.

I'll send an updated patch for Andrew to pick up shortly.

Thanks,
Punit

---------------->8------------------------
commit ee56e197cd8f3f782e32219f828e04ef0145a1aa
Author: Punit Agrawal <punit.agrawal@arm.com>
Date:   Mon Jun 5 12:03:55 2017 +0100

    fixup! mm, gup: Ensure real head page is ref-counted when using hugepages

diff --git a/mm/gup.c b/mm/gup.c
index 7d730e4188ce..6bd39264d0e7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1362,7 +1362,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
                refs++;
        } while (addr += PAGE_SIZE, addr != end);

-   head = compound_head(page);
+ head = compound_head(pmd_page(orig));
        if (!page_cache_add_speculative(head, refs)) {
                *nr -= refs;
                return 0;
@@ -1400,7 +1400,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
                refs++;
        } while (addr += PAGE_SIZE, addr != end);

-   head = compound_head(page);
+ head = compound_head(pud_page(orig));
        if (!page_cache_add_speculative(head, refs)) {
                *nr -= refs;
                return 0;
@@ -1437,7 +1437,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
                refs++;
        } while (addr += PAGE_SIZE, addr != end);

-   head = compound_head(page);
+ head = compound_head(pgd_page(orig));
        if (!page_cache_add_speculative(head, refs)) {
                *nr -= refs;
                return 0;
