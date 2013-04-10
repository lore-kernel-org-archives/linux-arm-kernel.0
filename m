From: steve.capper@arm.com (Steve Capper)
Date: Wed, 10 Apr 2013 09:21:00 +0100
Subject: [PATCH] arm: mm: lockless get_user_pages_fast
In-Reply-To: <00a201ce35bd$5626fd90$0274f8b0$@samsusng.com>
References: <1360890012-4684-1-git-send-email-chanho61.park@samsung.com>
 <20130405111158.GA13428@e103986-lin>
 <00a201ce35bd$5626fd90$0274f8b0$@samsusng.com>
Message-ID: <20130410082059.GA12296@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 08:30:54AM +0100, Chanho Park wrote:
> > Apologies for the tardy response, this patch slipped past me.
> 
> Never mind.
> 
> > I've tested this patch out, unfortunately it treats huge pmds as regular
> > pmds and attempts to traverse them rather than fall back to a slow path.
> > The fix for this is very minor, please see my suggestion below.
> OK. I'll fix it.
> 
> > 
> > As an aside, I would like to extend this fast_gup to include full huge
> > page support and include a __get_user_pages_fast implementation. This will
> > hopefully fix a problem that was brought to my attention by Grazvydas
> > Ignotas whereby a FUTEX_WAIT on a THP tail page will cause an infinite
> > loop due to the stock implementation of __get_user_pages_fast always
> > returning 0.
> 
> I'll add the __get_user_pages_fast implementation. BTW, HugeTLB on ARM
> wasn't
> supported yet. There is no problem to add gup_huge_pmd. But I think it need
> a test
> for hugepages.
> 

Thanks, that would be helpful. My plan was to then put the huge page
specific bits in, with another patch. That way I can test it all out
here.

> > I would suggest:
> > 		if (pmd_none(*pmdp) || pmd_bad(*pmdp))
> > 			return 0;
> > as this will pick up pmds that can't be traversed, and fall back to the
> > slow path.
> 
> Thanks for your suggestion.
> I'll prepare the v2 patch.
> 

Also, just one more thing. In your gup_pte_range function there is
an smp_rmb() just after the pte is dereferenced. I don't understand
why though?

> Best regards,
> Chanho Park
> 
> 

Thanks,
-- 
Steve
