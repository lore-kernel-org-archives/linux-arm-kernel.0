From: james.hogan@imgtec.com (James Hogan)
Date: Mon, 4 Jan 2016 15:25:58 +0000
Subject: [PATCH v2 20/32] metag: define __smp_xxx
In-Reply-To: <20160104134128.GZ6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
Message-ID: <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Jan 04, 2016 at 02:41:28PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 31, 2015 at 09:08:22PM +0200, Michael S. Tsirkin wrote:
> > +#ifdef CONFIG_SMP
> > +#define fence() metag_fence()
> > +#else
> > +#define fence()		do { } while (0)
> >  #endif
> 
> James, it strikes me as odd that fence() is a no-op instead of a
> barrier() for UP, can you verify/explain?

fence() is an unfortunate workaround for a specific issue on a certain
SoC, where writes from different hw threads get reordered outside of the
core, resulting in incoherency between RAM and cache. It has slightly
different semantics to the normal SMP barriers, since I was assured it
is required before a write rather than after it.

Here's the comment:

> This is needed before a write to shared memory in a critical section,
> to prevent external reordering of writes before the fence on other
> threads with writes after the fence on this thread (and to prevent the
> ensuing cache-memory incoherence). It is therefore ineffective if used
> after and on the same thread as a write.

It is used along with the metag specific __global_lock1() (global
voluntary lock between hw threads) whenever a write is performed, and by
smp_mb/smp_rmb to try to catch other cases, but I've never been
confident this fixes every single corner case, since there could be
other places where multiple CPUs perform unsynchronised writes to the
same memory location, and expect cache not to become incoherent at that
location.

It seemed to be sufficient to achieve stability however, and SMP on Meta
Linux never made it into a product anyway, since the other hw thread
tended to be used for RTOS stuff, so it didn't seem worth extending the
generic barrier API for it.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/c898072c/attachment.sig>
