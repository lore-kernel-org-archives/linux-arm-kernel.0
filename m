From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jun 2014 19:00:26 +0100
Subject: [PATCHv2 1/4] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <538E6EC2.5000004@codeaurora.org>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
 <1401742658-11841-2-git-send-email-lauraa@codeaurora.org>
 <20140603152201.GP23149@arm.com> <538E6EC2.5000004@codeaurora.org>
Message-ID: <20140604180026.GC27881@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 01:56:34AM +0100, Laura Abbott wrote:
> On 6/3/2014 8:22 AM, Will Deacon wrote:
> >> +int set_memory_ro(unsigned long addr, int numpages)
> >> +{
> >> +	return change_memory_set_bit(addr, numpages, __pgprot(PTE_RDONLY));
> >> +}
> >> +EXPORT_SYMBOL_GPL(set_memory_ro);
> >> +
> >> +int set_memory_rw(unsigned long addr, int numpages)
> >> +{
> >> +	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_RDONLY));
> >> +}
> >> +EXPORT_SYMBOL_GPL(set_memory_rw);
> > 
> > I'm slightly worried about the interaction with this and PTE_WRITE (see
> > linux-next). If the kernel pages are marked as PTE_DIRTY | PTE_WRITE, then
> > setting read-only is a weird contradiction. Can you take PTE_WRITE into
> > account for these two please?
> >
> 
> It sounds like the solution should be to set/clear PTE_WRITE as appropriate
> here, is my understanding correct?

You got it! You can look at set_pte_at if you're unsure (bearing in mind
that kernel mappings are always dirty).

Will
