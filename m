From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jun 2010 17:16:01 +0100
Subject: Question about SMP
In-Reply-To: <AANLkTilJOUmarsLJJtNzbVwrZLbLAD29gp2SHL0TZCUQ@mail.gmail.com>
References: <AANLkTilJOUmarsLJJtNzbVwrZLbLAD29gp2SHL0TZCUQ@mail.gmail.com>
Message-ID: <1277482561.13134.68.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-07 at 21:11 +0100, Dave Hylands wrote:
> I'm trying to understand what I need to be concerned about with SMP
> processors and sharing global data (in particular a dual Cortex-A9)
> 
> I'm familiar with spinlocks, but in this case I'm trying to work with
> some lockless data structures.

You should be really concerned about memory ordering and barriers :).
See Documentation/memory-barriers.txt in the kernel source.

> What I'm not sure is whether the following would work. Suppose I have
> a couple of 8-bit get/put indicies which are in adjacent memory
> locations (within the same 32-bit word).
> 
> If I have an ISR and a thread running on an SMP core, and the ISR is
> running on one core and the thread is running on a second core, if the
> ISR were to only write to the put pointer and the thread were only to
> write to the get pointer, does the cache maintain consistency? Or do
> the get and put pointers need to be in separate cache lines?

The consistency is maintained (though be careful about memory ordering
and when the put/get pointers become visible to the other CPUs).

> Another way of asking this: If both cores are writing to the same
> 32-bit word (but different bytes) do the writes collide?

No, though it's not very efficient because of cache line being moved
between CPUs. See http://en.wikipedia.org/wiki/MESI_protocol.

-- 
Catalin
