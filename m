From: hughd@google.com (Hugh Dickins)
Date: Sun, 17 Mar 2013 19:33:25 -0700 (PDT)
Subject: mmap sync issue
In-Reply-To: <CANN689HX9rhecNv3RsDn8QZO8iUrMsQQBgnhUDb5AdyfWgyFag@mail.gmail.com>
References: <DEACCBA4C6A9D145A6A68B5F5BE581B80FC057AB@HKXPRD0310MB353.apcprd03.prod.outlook.com>
 <514502B6.2090804@gmail.com>
 <CANN689HX9rhecNv3RsDn8QZO8iUrMsQQBgnhUDb5AdyfWgyFag@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1303171906050.1676@eggly.anvils>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Mar 2013, Michel Lespinasse wrote:
> On Sat, Mar 16, 2013 at 4:39 PM, Will Huck <will.huckk@gmail.com> wrote:
> > On 03/15/2013 07:39 PM, Gil Weber wrote:
> >> I am experiencing an issue with my device driver. I am using mmap and
> >> ioctl to share information with my user space application.
> >> The thing is that the shared memory does not seems to be synced. Do check
> >> this, I have done a simple test:
> 
> So if I got this right, the issue is that the vmalloc_area is
> virtually aliased between the kernel and the user space mapping, so
> that coherency is not guaranteed on architectures that use virtually
> aliased caches.
> 
> fs/aio.c does something similar to what you want with their ring
> buffer. The kernel doesn't access the ring buffer through a vmalloc
> area like you're trying to do; instead it uses kmap_atomic() ..
> kunmap_atomic() whenever it wants to access it.
> 
> I don't actually consider myself an expert in this area but I believe
> the above should solve your problem :)

I don't think so: kmap_atomic() provides a temporary kernel mapping for
a page when not all memory is direct-mapped, but it's close to a no-op
when there's no highmem.  This question isn't about highmem.

I can't point to what solves the problem for the aio ringbuffer:
for all I know, that's not even used on such architectures.

The usual solution is flush_dcache_page(): see Documentation/cachetlb.txt.
Which mostly describes the common page cache case, but a driver like
yours may also need it.

Each architecture has its own implementation, and often its own way of
minimizing the overhead of flush_dcache_page(): if you're using it in
a new context, you might need to be careful about such optimizations,
and the page flags used to control them.

But better to ask on the (moderated) linux-arm-kernel list if it's not
clear to you how to use it: being a no-op on x86, those of us who know
little beyond x86 are apt to give bad advice.

Hugh
