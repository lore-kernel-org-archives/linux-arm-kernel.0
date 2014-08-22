From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Aug 2014 16:45:38 +0100
Subject: [PATCHv3 2/2] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <53F38797.1050301@codeaurora.org>
References: <1407886667-16919-1-git-send-email-lauraa@codeaurora.org>
 <1407886667-16919-3-git-send-email-lauraa@codeaurora.org>
 <20140819121142.GC23128@arm.com> <53F38797.1050301@codeaurora.org>
Message-ID: <20140822154537.GG17255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Tue, Aug 19, 2014 at 06:21:27PM +0100, Laura Abbott wrote:
> On 8/19/2014 5:11 AM, Will Deacon wrote:
> > On Wed, Aug 13, 2014 at 12:37:47AM +0100, Laura Abbott wrote:
> >> +static int __change_memory(pte_t *ptep, pgtable_t token, unsigned long addr,
> >> +			pgprot_t prot, bool set)
> >> +{
> >> +	pte_t pte;
> >> +
> >> +	if (set)
> >> +		pte = set_pte_bit(*ptep, prot);
> >> +	else
> >> +		pte = clear_pte_bit(*ptep, prot);
> >> +	set_pte(ptep, pte);
> >> +	return 0;
> >> +}
> > 
> > Why do we need to propagate the token this far?
> > 
> 
> Not quite sure I understand the comment here.

Sorry, I was reviewing patches on a plane and ended up being a bit too
terse. I basically don't understand why we have to pass the `token'
parameter to __change_memory as it appears to be unused.

> > What about UXN? (I don't have the ARM ARM to hand, but we may want to set
> > both)
> > 
> 
> Both PAGE_KERNEL and PAGE_KERNEL_EXEC already set PTE_UXN. It seems
> redundant to add it again given this is currently restricted to module
> addresses. It's cheap to add it though for paranoia's sake.

I missed that, so I think it's fine to leave this part as-is.

Will
