From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 14:52:35 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
References: <20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
Message-ID: <20091207145235.GD19348@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 02:55:52PM +0200, Ronen Shitrit wrote:
> > Russell King - ARM Linux wrote:
> > > On Mon, Dec 07, 2009 at 01:31:41PM +0200, saeed bishara wrote:
> > [...]
> > >>> If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
> > >>> what's going on, and I don't have any suggestion on what to try next.
> > >>>
> > >>> The log shows that the kernel is doing the right thing: when we detect
> > >>> two mappings for the same page in the same MM space, we clean and
> > >>> invalidate any existing cacheable mappings visible in the MM space
> > >>> (both L1 and L2), and switch all visible mappings to C=0 B=1 mappings.
> > >>> This makes the area non-cacheable.
> > >> what about the PTE of the MM space of the write process? if it remains
> > >> C=1 B=1, then it's data will be at the L2, and as the L2 is not
> > >> flushed on context switch, then that explains this behavior.
> > > 
> > > That's probably the issue, and it means that _all_ shared writable
> > > mappings on your processor will be broken.
> > 
> > Hmm.. I tried also the testprg with CACHE_FEROCEON_L2 deaktivated,
> > same result ...
> > 
> > > Oh dear, that really is bad news.
> > 
> > Indeed.
> > 
> > > There are two solutions to this which I can currently think of:
> > > 1. flush the L2 cache on every context switch
> > 
> > To clarify, the testprg runs fine, if I start 4 processes each with
> > only one read thread. In this case all works as expected. The mess
> > begins only, if one read process starts more than one read thread ...
> > 
> That also match the theory:
> When using different processes, the shared area will stay C=1 B=1, 
> On each context switch L1 will be flushed,
> Since L2 is PIPT next process will get the correct data...

Hang on - if L2 is PIPT, then there shouldn't be a problem provided it's
searched with C=0 B=1 mappings.  Is that the case?
