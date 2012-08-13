From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Mon, 13 Aug 2012 16:05:17 +0200
Subject: RFC: mutex: hung tasks on SMP platforms with
 asm-generic/mutex-xchg.h
In-Reply-To: <alpine.LFD.2.02.1208130931530.5231@xanadu.home>
References: <20120807115647.GA12828@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208090029460.5231@xanadu.home>
 <20120809144953.GC18486@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208091201380.5231@xanadu.home>
 <alpine.LFD.2.02.1208091243080.5231@xanadu.home>
 <1344845704.31459.11.camel@twins>
 <alpine.LFD.2.02.1208130931530.5231@xanadu.home>
Message-ID: <1344866717.31459.32.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-08-13 at 09:35 -0400, Nicolas Pitre wrote:
> Date: Fri, 10 Aug 2012 15:22:09 +0100
> From: Will Deacon <will.deacon@arm.com>
> Subject: [PATCH] mutex: place lock in contended state after fastpath_lock failure
> 
> ARM recently moved to asm-generic/mutex-xchg.h for its mutex
> implementation after the previous implementation was found to be missing
> some crucial memory barriers. However, this has revealed some problems
> running hackbench on SMP platforms due to the way in which the
> MUTEX_SPIN_ON_OWNER code operates.
> 
> The symptoms are that a bunch of hackbench tasks are left waiting on an
> unlocked mutex and therefore never get woken up to claim it. This boils
> down to the following sequence of events:
> 
>         Task A        Task B        Task C        Lock value
> 0                                                     1
> 1       lock()                                        0
> 2                     lock()                          0
> 3                     spin(A)                         0
> 4       unlock()                                      1
> 5                                   lock()            0
> 6                     cmpxchg(1,0)                    0
> 7                     contended()                    -1
> 8       lock()                                        0
> 9       spin(C)                                       0
> 10                                  unlock()          1
> 11      cmpxchg(1,0)                                  0
> 12      unlock()                                      1
> 
> At this point, the lock is unlocked, but Task B is in an uninterruptible
> sleep with nobody to wake it up.
> 
> This patch fixes the problem by ensuring we put the lock into the
> contended state if we fail to acquire it on the fastpath, ensuring that
> any blocked waiters are woken up when the mutex is released.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Mason <chris.mason@fusionio.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org> 

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>


Will you carry this through the ARM tree or do you want me/Ingo to take
it?
