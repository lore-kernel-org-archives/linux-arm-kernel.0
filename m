From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 4 Jan 2016 16:30:36 +0100
Subject: [PATCH v2 20/32] metag: define __smp_xxx
In-Reply-To: <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
 <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
Message-ID: <20160104153036.GG6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 03:25:58PM +0000, James Hogan wrote:
> It is used along with the metag specific __global_lock1() (global
> voluntary lock between hw threads) whenever a write is performed, and by
> smp_mb/smp_rmb to try to catch other cases, but I've never been
> confident this fixes every single corner case, since there could be
> other places where multiple CPUs perform unsynchronised writes to the
> same memory location, and expect cache not to become incoherent at that
> location.

Ah, yuck, I thought blackfin was the only one attempting !coherent SMP.
And yes, this is bound to break in lots of places in subtle ways. We
very much assume cache coherency for SMP in generic code.

> It seemed to be sufficient to achieve stability however, and SMP on Meta
> Linux never made it into a product anyway, since the other hw thread
> tended to be used for RTOS stuff, so it didn't seem worth extending the
> generic barrier API for it.

*phew*, should we take it out then, just to be sure nobody accidentally
tries to use it then?
