From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 8 Jul 2011 14:33:15 +0100
Subject: ARM cortex A9 performance issue
In-Reply-To: <CAE_nTV7PuEJx0WJKCtbGU-4HjEBzFxPRmPLue1toktS27Htbzg@mail.gmail.com>
References: <CAE_nTV4VgcNB0gc64zEPEfHp-hnDBsw6QsM=GqEObXAwzMTzTA@mail.gmail.com>
	<20110707152740.GG2486@arm.com>
	<CAE_nTV7PuEJx0WJKCtbGU-4HjEBzFxPRmPLue1toktS27Htbzg@mail.gmail.com>
Message-ID: <20110708133315.GB2115@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 05:08:38PM +0530, rd bairva wrote:
> Now i have modified a source a little bit. Now I am doing a pingpong
> using msgsnd and msgrcv. using this I am getting 40000req/sec and 55%
> CPU usage.
> In another version I have taken the same lock in both the processes to
> ensure same thread is unlocking the mutex. But CPU usage is 100%.
> Shouldn't be the behaviour 50%.

Possibly.  Do you see that behaviour on all platforms, or just A9?

> 
> algo
> msgsnd/msgrcv version.
> 
> Process1
> shared memory counter++
> msgsnd1
> msgrcv 2
> 
> Process2
> msgrcv 1
> shared memory counter--
> msgsnd2
> 
> Mutex version:
> Process 1
> 
> mutex1
> c++
> unlock_mutex1
> 
> Process 2
> mutex1
> c++
> unlock_mutex1

If there is some overhead outside the critical section, then the two threads
are likely to end up synchronised in such a way that this hides some or all of
the latency of acquiring the lock.  So I'd expect a CPU load somewhere between
50% and 100%, though I'd be a bit surprised if all the latency is hidden.

If you don't check or wait for the counter increment, the same thread may
repeatedly take the lock of course, without ever waiting.  If that happens,
you would see 100% load.  This probably can't happen with the msgsnd/msgrcv
version.

Your results from msgsnd/msgrcv also suggest that the hidden message
receive latency and other system overheads account for something like  
of the total CPU load for that code, which sounds plausible.

Can you attach your new code?

Cheers
---Dave
