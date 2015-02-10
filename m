From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Feb 2015 20:58:10 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150210151416.GD9432@leverpostej>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210151416.GD9432@leverpostej>
Message-ID: <20150210205809.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 03:14:16PM +0000, Mark Rutland wrote:
> That sounds about right, though surely cache flush is irrelevant w.r.t.
> publishing of the unlock? The dsb(ishst) in the unlock path will ensure
> that the write is visibile prior to the second flush_cache_louis().
> 
> That said, we _do_ need to flush the cache prior to the CPU being
> killed, or we can lose any (shared) dirty cache lines the CPU owns. In
> the presence of dirty cacheline migration we need to be sure the CPU to
> be killed doesn't acquire any lines prior to being killed (i.e. its
> caches need to be off and flushed). Given that I don't think it's
> feasible to perform an IPI.
> 
> I think we need to move the synchronisation down into the
> cpu_ops::{cpu_die,cpu_kill} implementations, so that we can have the
> dying CPU signal readiness after it has disabled and flushed its caches.

Absolutely not - we're not having lots of implementations of the same
fscking thing.  We need this basic stuff to be in the generic code, not
repeated some hundreds of times across every single SMP implementation
that's out there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
