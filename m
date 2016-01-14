From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Jan 2016 13:44:49 +0000
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <56979D40.4060602@huawei.com>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5696272E.8090408@huawei.com> <20160113111806.GC23370@leverpostej>
 <56979621.1060102@huawei.com> <56979D40.4060602@huawei.com>
Message-ID: <20160114134448.GB27039@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 09:06:08PM +0800, Xishi Qiu wrote:
> On 2016/1/14 20:35, Xishi Qiu wrote:
> 
> > On 2016/1/13 19:18, Mark Rutland wrote:
> > 
> >> On Wed, Jan 13, 2016 at 06:30:06PM +0800, Xishi Qiu wrote:
> >>> Hi Mark,
> >>>
> >>> If I create swapper page tables by 4kb, not large page, then I use
> >>> set_memory_ro() to change the pate table flag, does it have the problem
> >>> too?
> >>
> >> The splitting/merging problem would not apply.
> >>
> >> However, you're going to waste a reasonable amount of memory by not
> >> using section mappings in the swapper, and we gain additional complexity
> >> in the page table setup code (which is shared with others things that
> >> want section mappings).
> >>
> >> What are you exactly actually trying to achieve?
> >>
> > 
> > If module allocates some pages and save data on them, and the data will
> > not be changed during the module running. So we want to use set_memory_ro()
> > to increase the security. If the data is changed, we can catch someone.
> > 
> >> What memory do you want to mark RO, and why?
> >>
> > 
> > The key data, and it will not be changed during the running time.
> > 
> >> >From a previous discussion [1], we figured out alternative approaches
> >> for common cases. Do none of those work for your case?
> >>
> > 
> > I have not read the patchset carefully, could you tell me the general meaning
> > of the approaches?
> > 
> 
> Hi Mark,
> 
> Is the two approaches like following?
> 1. use create_mapping to map the data in read only, then use fixmap to create a
> temp page table, and change the data when necessary.

In your code you'd have to statically place the data in .rodata somehow
(e.g. [2]). Your code would not call create_mapping. The usual init code
would take care of that.

Note that this can only work for a fixed amount of data, whereas it
sounds like you are doing dynamic allocation.

> 2. use vmalloc, then we can use set_memory_ro to change the page table prot.

Something like this should be workable, yes. See [3,4].

> >> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397320.html

[2] https://lkml.org/lkml/2015/11/24/724
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399015.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399252.html

Thanks,
Mark.
