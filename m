From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 1 Jul 2015 14:05:11 +0200
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <CAPvkgC0Bx4_pvO8J1dJWRXWLBzaHSpCGQ2TgVK5s+uCwwobVRg@mail.gmail.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
 <20150629100304.GB18931@leverpostej> <55914033.5060008@arm.com>
 <CAL5wTH7EUh0ciutXKs2s-4VjKnRM65QmrUQQiRdM=R+_VXi6DA@mail.gmail.com>
 <559270D3.8030305@arm.com>
 <CAL5wTH4H7DiE-Z-YHCs7mLRPoixOOxi=yMk-j8yC1np1m=9sYw@mail.gmail.com>
 <5592C1BB.9090106@arm.com> <20150630185031.GA23001@cbox>
 <5593A2CC.2050805@arm.com>
 <20150701112732.GB21981@e104818-lin.cambridge.arm.com>
 <CAPvkgC0Bx4_pvO8J1dJWRXWLBzaHSpCGQ2TgVK5s+uCwwobVRg@mail.gmail.com>
Message-ID: <CAMJs5B8FGcAcNZM9zez4MhcyEJQfog4C23B-tUVgVxUoq=yFug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 1:44 PM, Steve Capper <steve.capper@linaro.org> wrote:
> On 1 July 2015 at 12:27, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Wed, Jul 01, 2015 at 09:20:28AM +0100, Marc Zyngier wrote:
>>> [+Will, Catalin]
>>>
>>> On 30/06/15 19:50, Christoffer Dall wrote:
>>> > On Tue, Jun 30, 2015 at 05:20:11PM +0100, Marc Zyngier wrote:
>>> >> On 30/06/15 17:16, Dirk M?ller wrote:
>>> >>> Hi Marc,
>>> >>>
>>> >>>> Can try the following patch?
>>> >>>
>>> >>> [..]
>>> >>>
>>> >>> Thanks a lot for the quick patch, from a brief testing this seems to
>>> >>> fix the issue (on a 4k kernel). I'll retest this in our original
>>> >>> configuration (which was 64k) but so far I don't see a reason why it
>>> >>> shouldn't fix the issue.
>>> >>
>>> >> Awesome. Mind if I put your Tested-by on the patch?
>>> >>
>>> > Looks to me like the definition of pmd_huge() on arm64 is broken; pretty
>>> > sure when I reviewed this original patch I followed the path of both
>>> > pmd_huge() and pmd_trans_huge() and checked that they don't return true
>>> > if the entry is clear.  This happens to be the case on both arm and x86,
>>> > and I probably only looked at the arm code and not the arm64 code.
>>> >
>>> > I'm fine with this patch, but I think we should also merge the
>>> > following, since by definition, a clear pmd cannot also be a huge pmd:
>>> >
>>> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> > index 2de9d2e..779520b 100644
>>> > --- a/arch/arm64/mm/hugetlbpage.c
>>> > +++ b/arch/arm64/mm/hugetlbpage.c
>>> > @@ -40,7 +40,7 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
>>> >
>>> >  int pmd_huge(pmd_t pmd)
>>> >  {
>>> > -   return !(pmd_val(pmd) & PMD_TABLE_BIT);
>>> > +   return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
>>> >  }
>>> >
>>> >  int pud_huge(pud_t pud)
>>>
>>> If the convention is for pmd_huge to check for pmd_none, then we don't
>>> need my patch, and only this should be merged.
>>
>> Adding Steve on cc. I can see that the mm code checks for pmd_none()
>> before calling pmd_huge() but I'm not sure it does this all the time
>> (same goes for pud_huge).
>>
>> Steve, do you have any more insight here?
>>
>
> I thought pmd_none was always called before pmd_huge, but this was an
> oversight on my part as clear pud's and pmd's cannot also be huge.
> I think Christoffer's patch should be applied (with the equivalent for
> pud_huge too) in case the logic ever changes.
>
ok, I'll send out a patch.

-Christoffer
