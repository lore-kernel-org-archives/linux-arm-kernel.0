From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 28 Feb 2010 22:27:43 +0000
Subject: SMP performance question(Re: USB mass storage and ARM cache
	coherency)
In-Reply-To: <10d816431002262332ke92737cvafcbff63fbbb6c85@mail.gmail.com>
References: <10d816431002262332ke92737cvafcbff63fbbb6c85@mail.gmail.com>
Message-ID: <1267396063.4485.4.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-02-27 at 07:32 +0000, Lin Mac wrote:
> > My latest solution - http://bit.ly/apJv3O - is to use dummy
> > read-for-ownership or write-for-ownership accesses in the DMA cache
> > flushing functions to force cache line migration from the other CPUs.
> > Our current benchmarks only show around 10% disc throughput penalty
> > compared to the normal SMP case (compared to the UP case the penalty is
> > bigger but that's due to other things).
> 
> So it sounds like the performance of UP > __Normal SMP__ > RFO/WFO + SMP.
> 
> Maybe I've got the wrong expection, for I'm not experienced in SMP.
> But I do expect the performance of  __Normal SMP__ should at least >=
> UP's.
> 
> Why the performance of UP would > __Normal SMP__?
> And what's the __Normal SMP__ definition?

By normal SMP I meant an unpatched kernel but with data corruption for
DMA transfers.

Our tests were for I/O bound operations (DMA transfers) where no matter
how many CPUs you add, the bottleneck is still the DMA engine. Adding
more CPUs could make things slightly worse by introducing extra
contention (and spinlocks, cache line ping-pong'ing).


-- 
Catalin
