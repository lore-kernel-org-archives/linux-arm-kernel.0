From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 13:34:34 +0100
Subject: [PATCH V5 1/2] arm: mm: Introduce {pte,pmd}_isset and
 {pte,pmd}_isclear
In-Reply-To: <20140627122359.GA30585@linaro.org>
References: <1403612604-2645-1-git-send-email-steve.capper@linaro.org>
 <1403612604-2645-2-git-send-email-steve.capper@linaro.org>
 <20140627112420.GK26276@arm.com>
 <20140627122359.GA30585@linaro.org>
Message-ID: <20140627123433.GO26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 01:24:00PM +0100, Steve Capper wrote:
> On Fri, Jun 27, 2014 at 12:24:20PM +0100, Will Deacon wrote:
> > On Tue, Jun 24, 2014 at 01:23:23PM +0100, Steve Capper wrote:
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > -#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> > > -#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> > > +#define pmd_trans_huge(pmd)	(pmd_val(pmd) && pmd_isclear((pmd), PMD_TABLE_BIT))
> > 
> > Why isn't this just pmd_present(pmd) && !pmd_table(pmd)? Put another way, I
> > see to have forgotten why we need PMD_TABLE_BIT instead of just using
> > pmd_table and pmd_sect to work out whether we have a table or a block.
> > 
> 
> If we use pmd_sect, we are testing for block entries, but THPs are allowed to
> be faulting entries (i.e. PROT_NONE). A non-zero pmd that does not have the
> table bit set can safely be assumed to be a PROT_NONE THP.

Ah yes, I forgot about faulting entries. We should still be able to use
pmd_table(pmd) as opposed to PMD_TABLE_BIT though, right?

Will
