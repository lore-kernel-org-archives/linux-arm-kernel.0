From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Jan 2016 11:25:21 +0000
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <56A81B01.7010104@huawei.com>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
 <569454F6.1060207@huawei.com> <20160112111531.GA4858@leverpostej>
 <5695DA67.5080201@huawei.com> <20160113112813.GE23370@leverpostej>
 <56A81B01.7010104@huawei.com>
Message-ID: <20160127112520.GA20103@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 09:18:57AM +0800, Xishi Qiu wrote:
> On 2016/1/13 19:28, Mark Rutland wrote:
> 
> > On Wed, Jan 13, 2016 at 01:02:31PM +0800, Xishi Qiu wrote:
> >> Hi Mark,
> >>
> >> If I do like this, does it have the problem too?
> >>
> >> kmalloc a size
> >> no access
> >> flush tlb
> >> call set_memory_ro to change the page table flag
> >> flush tlb
> >> start access
> > 
> > This is broken.
> > 
> > The kmalloc will give you memory form the linear mapping. Even if you
> > allocate a page, that page could have been mapped with a section at the
> > PMD/PUD/PGD level.
> > 
> > Other data could fall within that section (e.g. a kernel stack,
> > perhaps).
> 
> Hi Mark,
> 
> If nobody use that whole section before(however it is almost impossible),
> flush tlb is safe, right?

No, it is not safe.

As I mentioned before, there is a race against the hardware that you
cannot win:

> > Additional TLB flushees do not help. There's still a race against the
> > asynchronous TLB logic. The TLB can allocate or destroy entries at any
> > tim. If there were no page table changes prior to the invalidate, the
> > TLB could re-allocate all existing entries immediately after the TLB
> > invalidate, leaving you in the same state as before.

It doesn't matter whether code hasn't accessed a portion of the VA
space. You cannot guarantee that a valid entry will not be allocated
into the TLB at any time.

See the ARM ARM (ARM DDI 0487A.h), D4.6.1, About ARMv8 Translation
Lookaside Buffers (TLBs):

    Any translation table entry that does not generate a Translation
    fault, an Address size fault, or an Access flag fault and is not
    from a translation regime for an Exception level that is lower than
    the current Exception level might be allocated to an enabled TLB at
    any time.

You must either use a Break-Before-Make approach, or ensure that the
page tables are not live (i.e. not reachable by one of the TTBRs, and
not having any partial walks cached in TLBs) at the time they are
modified. In practice, both of these require an approach like [1] and
are incredibly expensive.

The only other option is to not use sections at all [2], though this
incurs other costs.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401434.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401690.html
