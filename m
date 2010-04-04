From: kosaki.motohiro@jp.fujitsu.com (KOSAKI Motohiro)
Date: Mon,  5 Apr 2010 07:45:47 +0900 (JST)
Subject: [Question] race condition in mm/page_alloc.c regarding page->lru?
In-Reply-To: <h2rd6200be21004021759x4ae83403i4daa206d47b7d523@mail.gmail.com>
References: <20100402094805.GA12886@csn.ul.ie>
	<h2rd6200be21004021759x4ae83403i4daa206d47b7d523@mail.gmail.com>
Message-ID: <20100405010442.7E08.A69D9226@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> >> "mm: Add min_free_order_shift tunable." seems makes zero sense. I don't think this patch
> >> need to be merge.
> >
> > It makes a marginal amount of sense. Basically what it does is allowing
> > high-order allocations to go much further below their watermarks than is
> > currently allowed. If the platform in question is doing a lot of high-order
> > allocations, this patch could be seen to "fix" the problem but you wouldn't
> > touch mainline with it with a barge pole. It would be more stable to fix
> > the drivers to not use high order allocations or use a mempool.
> 
> The high order allocation that caused problems was the first level
> page table for each process. Each time a new process started the
> kernel would empty the entire page cache to create contiguous free
> memory. With the reserved pageblock mostly full (fixed by the second
> patch) this contiguous memory would then almost immediately get used
> for low order allocations, so the same problem starts again when the
> next process starts. I agree this patch does not fix the problem, but
> it does improve things when the problem hits. I have not seen a device
> in this situation with the second patch applied, but I did not remove
> the first patch in case the reserved pageblock fills up.

I would like to merge the second patch at first. If the same problem still occur, please
post bug report. (and please cc arm folks if it is arm pagetable related)


> > It is inconceivable this patch is related to the problem though.
> >
> >> but "mm: Check if any page in a pageblock is reserved before marking it MIGRATE_RESERVE"
> >> treat strange hardware correctly, I think. If Mel ack this, I hope merge it.
> >> Mel, Can we hear your opinion?
> >>
> >
> > This patch is interesting and I am surprised it is required. Is it really the
> > case that page blocks near the start of a zone are dominated with PageReserved
> > pages but the first one happen to be free? I guess it's conceivable on ARM
> > where memmap can be freed at boot time.
> 
> I think this happens by default on arm. The kernel starts at offset
> 0x8000 to leave room for boot parameters, and in recent kernel
> versions (>~2.6.26-29) this memory is freed.
> 
> >
> > There is a theoritical problem with the patch but it is easily resolved.
> > A PFN walker like this must call pfn_valid_within() before calling
> > pfn_to_page(). If they do not, it's possible to get complete garbage
> > for the page and result in a bad dereference. In this particular case,
> > it would be a kernel oops rather than memory corruption though.
> >
> > If that was fixed, I'd see no problem with Acking the patch.
> >
> 
> I can fix this if you want the patch in mainline. I was not sure it
> was acceptable since will slow down boot on all systems, even where it
> is not needed.

bootup code is not fast path. then, small slowdown is ok, I think.
So, I'm looking for your new version patch.
