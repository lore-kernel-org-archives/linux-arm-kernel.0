From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:15:44 +0100
Subject: [PATCH 0/2] Implement ticket spinlocks for ARM
Message-ID: <1340378146-17560-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

With multi-cluster ARM platforms on the horizon, our current spinlock
implementation can result in lock-bias when the memory latency is not
uniform between clusters. This may be due to microarchitectural
constraints or (mis-)configuration of the cache-coherent interconnect.

This series ensures lock fairness by implementing the ticket algorithm
described in detail here:

        http://lwn.net/Articles/267968/

Whilst fairness is not necessarily congruent with throughput, I've not
observed any drop in performance on single-cluster systems with this
change to the kernel (I ran hackbench, which stresses &(&u->lock)->rlock
on the msg{snd,rcv} paths).

All comments welcome,

Will


Will Deacon (2):
  ARM: spinlock: use ticket algorithm for ARMv6+ locking implementation
  ARM: rwlocks: remove unused branch labels from trylock routines

 arch/arm/include/asm/spinlock.h       |   77 ++++++++++++++++++++++-----------
 arch/arm/include/asm/spinlock_types.h |   17 ++++++-
 2 files changed, 66 insertions(+), 28 deletions(-)

-- 
1.7.4.1
