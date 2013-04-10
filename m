From: steve.capper@arm.com (Steve Capper)
Date: Wed, 10 Apr 2013 10:47:45 +0100
Subject: [PATCH] arm: mm: lockless get_user_pages_fast
In-Reply-To: <00bc01ce35cb$38b9ffb0$aa2dff10$@samsusng.com>
References: <1360890012-4684-1-git-send-email-chanho61.park@samsung.com>
 <20130405111158.GA13428@e103986-lin>
 <00a201ce35bd$5626fd90$0274f8b0$@samsusng.com>
 <20130410082059.GA12296@e103986-lin>
 <00bc01ce35cb$38b9ffb0$aa2dff10$@samsusng.com>
Message-ID: <20130410094743.GA13494@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:10:18AM +0100, Chanho Park wrote:
> > From: Steve Capper [mailto:steve.capper at arm.com]
> > Sent: Wednesday, April 10, 2013 5:21 PM
> > To: Chanho Park
> > Cc: Steve Capper; 'Chanho Park'; linux at arm.linux.org.uk; Catalin Marinas;
> > 'Inki Dae'; linux-mm at kvack.org; 'Kyungmin Park'; 'Myungjoo Ham'; linux-
> > arm-kernel at lists.infradead.org; 'Grazvydas Ignotas'
> > Subject: Re: [PATCH] arm: mm: lockless get_user_pages_fast
> > 
> > On Wed, Apr 10, 2013 at 08:30:54AM +0100, Chanho Park wrote:
> > > > Apologies for the tardy response, this patch slipped past me.
> > >
> > > Never mind.
> > >
> > > > I've tested this patch out, unfortunately it treats huge pmds as
> > > > regular pmds and attempts to traverse them rather than fall back to a
> > slow path.
> > > > The fix for this is very minor, please see my suggestion below.
> > > OK. I'll fix it.
> > >
> > > >
> > > > As an aside, I would like to extend this fast_gup to include full
> > > > huge page support and include a __get_user_pages_fast
> > > > implementation. This will hopefully fix a problem that was brought
> > > > to my attention by Grazvydas Ignotas whereby a FUTEX_WAIT on a THP
> > > > tail page will cause an infinite loop due to the stock
> > > > implementation of __get_user_pages_fast always returning 0.
> > >
> > > I'll add the __get_user_pages_fast implementation. BTW, HugeTLB on ARM
> > > wasn't supported yet. There is no problem to add gup_huge_pmd. But I
> > > think it need a test for hugepages.
> > >
> > 
> > Thanks, that would be helpful. My plan was to then put the huge page
> > specific bits in, with another patch. That way I can test it all out here.
> 
> Can I see the patch? I think it will be helpful to implement the
> gup_huge_pmd.
> Or how about you think except gup_huge_pmd in this patch?
> IMO it will be added easily after hugetlb on arm is merged.
> 

I think it would be better if this patch did not have gup_huge_pmd in it.

I am still working on my implementation and running it through a battery of
tests here. Also, I will likely change a few things in my huge page patches
to make a gup_huge_pmd easier to implement. I will be resending a V2 of my
huge pages soon.

It still would be helpful to have the pmd_bad(*pmdp) condition check in as
I suggested before though.

> > 
> > > > I would suggest:
> > > > 		if (pmd_none(*pmdp) || pmd_bad(*pmdp))
> > > > 			return 0;
> > > > as this will pick up pmds that can't be traversed, and fall back to
> > > > the slow path.
> > >
> > > Thanks for your suggestion.
> > > I'll prepare the v2 patch.
> > >
> > 
> > Also, just one more thing. In your gup_pte_range function there is an
> > smp_rmb() just after the pte is dereferenced. I don't understand why
> > though?
> 
> I think it would be needed for 64 bit machine. A pte of 64bit machine
> consists of low and high value. In this version, there is no need to add it.
> I'll remove it. Thanks.

The pte will only be 64 bit if LPAE is enabled, and LPAE support mandates
that 64 bit page table entries be read atomically. So we should be ok without
the read barrier.

> 
> Best regards,
> Chanho Park
> 
> 

Cheers,
--
Steve
