From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 May 2015 09:31:26 +0200
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <20150527062250.GD3928@swordfish>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <20150527041015.GB11609@blaptop> <20150527062250.GD3928@swordfish>
Message-ID: <3176422.FWpfrlzXOV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 15:22:50 Sergey Senozhatsky wrote:
> On (05/27/15 13:10), Minchan Kim wrote:
> > On Tue, May 26, 2015 at 08:29:59PM +0900, Jungseok Lee wrote:
> > > 
> > > if (test_thread_flag(TIF_MEMDIE) && !(gfp_mask & __GFP_NOFAIL))
> > >     goto nopage;
> > > 
> > > IMHO, a reclaim operation would be not needed in this context if memory is
> > > allocated from vmalloc space. It means there is no need to traverse shrinker list. 
> > 
> > For making fork successful with using vmalloc, it's bandaid.

Right.

> > > >> This patch tries to solve the problem as allocating thread_info memory
> > > >> from vmalloc space, not 1:1 mapping one. The downside is one additional
> > > >> page allocation in case of vmalloc. However, vmalloc space is large enough,
> > > > 
> > > > The size you want to allocate is 16KB in here but additional 4K?
> > > > It increases 25% memory footprint, which is huge downside.
> > > 
> > > I agree with the point, and most people who try to use vmalloc might know the number.
> > > However, an interoperation on the number depends on a point of view.
> > > 
> > > Vmalloc is large enough and not fully utilized in case of ARM64.
> > > With the considerations, there is a room to do math as follows.
> > > 
> > > 4KB / 240GB = 1.5e-8 (4KB page + 3 level combo)
> > > 
> > > It would be not a huge downside if fork-routine is not damaged due to fragmentation.
> > 
> > Okay, address size point of view, it wouldn't be significant problem.
> > Then, let's see it performance as point of view.
> > 
> > If we use vmalloc, it needs additional data structure for vmalloc
> > management, several additional allocation request, page table hanlding
> > and TLB flush.

One upside of it is that we could in theory make THREAD_SIZE 12KB or
20KB instead of 16KB if we wanted to, as vmalloc does not have the
power-of-two requirement.

The downsides of vmalloc that you list are probably much stronger.

Another one is that /proc/vmallocinfo would become completely unreadable
on systems with lots of threads.

Finally, accessing data in vmalloc memory requires 4KB TLBs, while the
linear mapping usually uses hugepages, so we get extra page table walks
in the kernel for accessing the kernel stack, or for any kernel code
that looks at the thread_info of another thread.

> plus a guard page. I don't see VM_NO_GUARD being passed.

That's only a virtual page, which is virtually free here, it does not
consume any real memory.

	Arnd
