From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Nov 2013 10:19:02 +0000
Subject: mm: get_user_pages_fast()
In-Reply-To: <52797483.2000105@cs.bris.ac.uk>
References: <52797483.2000105@cs.bris.ac.uk>
Message-ID: <20131106101901.GA21074@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:43:15PM +0000, Michael McTernan wrote:
> Hi all,

Hi Mike,

> I think there's a problem on ARM with futex calls to FUTEX_WAIT and 
> similar for addresses that have been mapped to userspace from /dev/mem 
> or a device which sets VM_IO or VM_PFNMAP.  This can break 
> pthread_mutex_lock() if placed on such mapped memory and attributed as 
> process-shared.
> 
> The cause looks to be that ARM doesn't yet implement 
> get_user_pages_fast(), which is called in get_futex_key() for a 
> non-process private futex.

[...]

> I've seen a couple of patches go by that provide get_user_pages_fast() 
> on ARM, but none yet accepted.  I therefore would like to highlight this 
> particular case for context, and also to perhaps generate some movement 
> on this issue, which I also reported here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=64321

The latest patches from Steve are here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205951.html

but we need some feedback from the MM guys regarding the atomics in patch 2
(since we don't require IPIs for TLB invalidation). I'd also like to see
some numbers comparing the two schemes (since we could add a dummy IPI to
our huge TLB flushing code if it's cheaper).

Will
