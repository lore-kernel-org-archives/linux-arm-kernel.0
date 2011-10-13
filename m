From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 09:49:47 +0100
Subject: change_page_attr() implementation for ARM?
In-Reply-To: <401E54CE964CD94BAE1EB4A729C7087E3722519EE2@HQMAIL04.nvidia.com>
References: <D19EBEE1D7B1F742A8ED7130E050A38A4CA460FF0C@HQMAIL02.nvidia.com>
	<CAHkRjk4mqhu+HhoSAnowk6=5GzXXhmKCE-3jrjhMpVzbtakFYg@mail.gmail.com>
	<401E54CE964CD94BAE1EB4A729C7087E3722519EE2@HQMAIL04.nvidia.com>
Message-ID: <20111013084947.GI21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 07:27:58PM -0700, Krishna Reddy wrote:
> Catalin,
> >The kernel linear mapping is done using sections, so we would have to
> >change the attributes for a full section. Russell's approach I think
> >is better but people reported some stability issues.
> 
> X86 way breaks the sections into pages and it only changes the attributes
> for the requested pages. the other pages of section would have same prot
> attributes as section.

And doing that is the problem - you have multiple page tables to manipulate,
which in a SMP world could be in-use on different CPUs.  When you alter
such a page table, you will have a race between the CPU walking the
page tables and your update of that table.

Not only that but you will have to send a TLB flush to the other CPUs for
that address, and that requires an interruptible context.  There are
contexts which memory is allocated for DMA where that's not possible
(because IRQs are disabled by the caller.)

> does Russell's approach refer to a different way?
> Is there any link on how Russell wants to do it?

I had a patch which pre-allocates memory for the DMA allocators, but I
had to drop it because it caused regressions on platforms which had
very limited DMA memory available - it caused such platforms to panic
at boot.

So, this is proving to be an extremely difficult problem to solve -
and I've been wishing for quite a long time that ARM Ltd would get
their act together and realize that the combination of restrictions
(DMA incoherence plus not permitting aliases) is Very Bad News.

So, I'm hoping that there's an increasing chorus of voices trying to
persuade a move towards data-cache DMA coherence as standard.
