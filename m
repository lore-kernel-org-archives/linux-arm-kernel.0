From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 14:09:01 +0100
Subject: [Question] ARM/ARM64: Ticket Spinlock With GENERIC_BREAKLOCK
In-Reply-To: <53508F7B.2000400@marvell.com>
References: <53508F7B.2000400@marvell.com>
Message-ID: <20140423130901.GC5649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 03:35:39AM +0100, Leo Yan wrote:
> hi,

Hello,

> I noticed now for ARM and ARM64 both have disabled GENERIC_BREAKLOCK, 
> and i found the patch "ARM: 7484/1: Don't enable GENERIC_LOCKBREAK with 
> ticket spinlocks" to remove related configuration.
> 
> The ticket spinlock will be helpful for spinlock's performance, but 
> after disabled LOCKBREAK, it will always disable the preempt when the 
> cpu is spinning to wait for the lock.
> 
> So even after have refined the spinlock with ticket algorithm, we still 
> need LOCKBREAK for the cpu has the chance to do scheduling so that other 
> threads have chance can run.

The problem with GENERIC_LOCKBREAK is that we no longer end up using the
lock() function. Instead, we trylock() in a busy loop, so if the machine
doesn't have pending interrupts or other tasks to run, we end up chewing
power in a busy loop while the lock is contended. Worse still, we're polling
the lock value, so the relevant cacheline will be thrasing between all
waiters (and potentially the CPU trying to unlock()!).

If latency is an issue for you, have you considered either using a mutex
(where we explicitly block) or something like PREEMPT_RT instead?

Will
