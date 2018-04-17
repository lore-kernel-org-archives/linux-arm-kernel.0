From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Tue, 17 Apr 2018 16:55:08 +0100
Subject: [PATCH v2 2/2] parisc: define stronger ordering for the default
 readX()
In-Reply-To: <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
References: <1523938133-3224-1-git-send-email-okaya@codeaurora.org>
 <1523938133-3224-2-git-send-email-okaya@codeaurora.org>
 <1523957852.3250.9.camel@HansenPartnership.com>
 <38a1d4e3-cabe-6c39-4355-8d8111637382@codeaurora.org>
Message-ID: <1523980508.3310.9.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-17 at 10:13 -0400, Sinan Kaya wrote:
> Hi James,
> 
> > 
> > Perhaps if you gave an example of the actual problem you're trying
> > to fix we could assess if it affects parisc.
> 
> Let me clarify myself here. Maybe, there is a better solution.
> 
> 		/* assign ownership */
> 		desc->status = DEVICE_OWN;
> 
> 		/* notify device of new descriptors */
> 		writel(DESC_NOTIFY, doorbell);
> 
> The difference between writel() and writel_relax() is writel()
> guarantees memory transactions to be flushed to the device before the
> register write.

Um, no it doesn't, at least not in PCI.  It guarantees the write will
be issued by the memory system, but it may still be cached (called
posting) in the PCI bridge.  So it doesn't guarantee the write reaches
the device by the time it returns.

>  writel_relaxed() does not provide any guarantees about the memory
> and IO operations.
> 
> Similarly, readl() provides following code to observe the DMA result
> while readl_relaxed() does not provide this guarantee.

Right, the relaxed operator provides no guarantee of ordering between
the memory and IO domains.  However, it's only really a problem on
multiple memory controller systems (i.e. NUMA).  Parisc (except
superdome, which we don't support) doesn't have this problem.  We also
turn of CPU stream reordering, so compile order is retire order on our
CPUs (which makes life a lot simpler).

> Ideally, you want to embed rmb() and wmb() into the writel() and
> readl() to provide this guarantee.
>  
> PA-RISC doesn't seem to support neither one of the barrier types. If
> you are familiar with the architecture, maybe you could guide us
> here.
> 
> Is __raw_writeX() enough to provide this guarantee for this
> architecture?

Well, with the volatile address it is.

The current implementations provide the expected semantics: namely the
position in the instruction stream is compile (retire) ordered and
issued from memory once retired.  We still do have the write posting
problem, but you'll find additional reads in the drivers to flush the
posted writes, so I don't actually believe we need anything changing.

James
