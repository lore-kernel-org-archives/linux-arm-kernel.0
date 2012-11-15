From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 16:21:23 +0000
Subject: [PATCH V2 1/5] arm: mvebu: Added support for coherency fabric in
 mach-mvebu
In-Reply-To: <50A5103F.1040903@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-2-git-send-email-gregory.clement@free-electrons.com>
 <20121105140258.GO3351@mudshark.cambridge.arm.com>
 <50A15A33.60405@free-electrons.com>
 <20121113104340.GD3940@mudshark.cambridge.arm.com>
 <50A3F860.5010601@free-electrons.com>
 <20121115101752.GA26453@mudshark.cambridge.arm.com>
 <50A5103F.1040903@free-electrons.com>
Message-ID: <20121115162123.GC5885@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, Nov 15, 2012 at 03:54:39PM +0000, Gregory CLEMENT wrote:
> On 11/15/2012 11:17 AM, Will Deacon wrote:
> > Interesting, thanks for asking them about this. Does this mean that:
> 
> Here come the answers to your new questions

Great, thanks for the quick turn-around!

> > 	1. When not running coherently (i.e. before initialising the
> > 	   coherency fabric), memory is treated as non-shareable,
> > 	   non-cacheable?
> 
> It can be cacheable. The shared memory (as defined on the page table)
> will NOT be coherent by HW.

Ok, so we really are incoherent before enabling the fabric.

> > 	2. If (1), then are exclusive accesses the only way to achieve
> > 	   coherent memory accesses in this scenario?
> 
> I quote: "I suspect there is terminology miss-use: exclusive accesses
> are NOT used to achieve memory coherency - they are used to achieve
> atomicity. To achieve memory coherency while fabric is configured to
> be non-coherent, SW should use maintenance operations over the L1
> caches."

Ok, so if I'm understanding correctly then I don't really see the usefulness
of having working exclusives that are incoherent. Surely it means that you
can guarantee mutual exclusion on a lock variable, but the value you actually
end up reading from the lock is junk unless you litter the accessors with cache
clean operations?

Anyway, that's by-the-by as this is all called early enough that we
shouldn't care. The thing I don't like now is that the fabric initialisation
is done entirely differently on the primary CPU than the secondaries. The
primary probes the device-tree (well, it's also now hard-coded for v2) and
accesses the registers from a C function(armada_370_xp_set_cpu_coherent) whilst
the secondaries have hardcoded addresses and access via asm
(armada_xp_secondary_startup).

Will
