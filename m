From: js@sig21.net (Johannes Stezenbach)
Date: Mon, 8 Dec 2014 13:55:38 +0100
Subject: using DMA-API on ARM
In-Reply-To: <20141205185303.GG31222@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com>
 <20141205183945.GE31222@e104818-lin.cambridge.arm.com>
 <20141205185303.GG31222@e104818-lin.cambridge.arm.com>
Message-ID: <20141208125538.GA26983@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 06:53:03PM +0000, Catalin Marinas wrote:
> On Fri, Dec 05, 2014 at 06:39:45PM +0000, Catalin Marinas wrote:
> > 
> > Does your system have an L2 cache? What's the SoC topology, can PCIe see
> > such L2 cache (or snoop the L1 caches)?
> 
> BTW, if you really have a PL310-like L2 cache, have a look at some
> patches (I've seen similar symptoms) and make sure your configuration is
> correct:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6395/1
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1
> 
> The first one is vexpress specific. The second one was eventually
> discarded by Russell (I don't remember the reason, I guess it's because
> SoC code is supposed to set the right bits in there anyway). In your
> case, such bits may be set up by firmware, so Linux cannot fix anything
> up.

How do you avoid the unpredictable behavior mentioned in the
PL310 TRM when the Shared Attribute Invalidate Enable bit is set?
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/Ceggcfcj.html

I think this bit does not do what you seem to think it does, it only
changes behaviour for "writes targeting a full cache line, for example
4x64-bit bursts with all strobes active", which then cause the
cacheline to be invalidated.  "Other cases are identical to the default
shared behavior", which is "cacheable no allocate for reads"
and "write through no write allocate for writes".

If the problem is really speculative reads via the cachable
alias mapping, it seems this bit cannot solve the problem, right?


Johannes
