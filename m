From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Dec 2016 11:46:44 +0000
Subject: [PATCHv4 05/10] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <72eb08c8-4f2c-6cb9-1e23-0860fd153a2e@gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-6-git-send-email-labbott@redhat.com>
 <72eb08c8-4f2c-6cb9-1e23-0860fd153a2e@gmail.com>
Message-ID: <20161206114644.GA16701@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 04:50:33PM -0800, Florian Fainelli wrote:
> On 11/29/2016 10:55 AM, Laura Abbott wrote:
> > __pa_symbol is technically the marco that should be used for kernel
> > symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
> > will do bounds checking. As part of this, introduce lm_alias, a
> > macro which wraps the __va(__pa(...)) idiom used a few places to
> > get the alias.
> > 
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > v4: Stop calling __va early, conversion of a few more sites. I decided against
> > wrapping the __p*d_populate calls into new functions since the call sites
> > should be limited.
> > ---
> 
> 
> > -	pud_populate(&init_mm, pud, bm_pmd);
> > +	if (pud_none(*pud))
> > +		__pud_populate(pud, __pa_symbol(bm_pmd), PMD_TYPE_TABLE);
> >  	pmd = fixmap_pmd(addr);
> > -	pmd_populate_kernel(&init_mm, pmd, bm_pte);
> > +	__pmd_populate(pmd, __pa_symbol(bm_pte), PMD_TYPE_TABLE);
> 
> Is there a particular reason why pmd_populate_kernel() is not changed to
> use __pa_symbol() instead of using __pa()? The other users in the arm64
> kernel is arch/arm64/kernel/hibernate.c which seems to call this against
> kernel symbols as well?

create_safe_exec_page() may allocate a pte from the linear map and
passes such pointer to pmd_populate_kernel(). The copy_pte() function
does something similar. In addition, we have the generic
__pte_alloc_kernel() in mm/memory.c using linear addresses.

-- 
Catalin
