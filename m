From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 03 Feb 2010 16:21:47 -0800
Subject: [RFC PATCH] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100203161434.15912.42697.stgit@pc1117.cambridge.arm.com>
References: <20100203161434.15912.42697.stgit@pc1117.cambridge.arm.com>
Message-ID: <4B6A131B.1070005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The mandatory barriers (mb, rmb, wmb) are used even on uniprocessor
> systems for things like ordering Normal Non-cacheable memory accesses
> with DMA transfer (via Device memory writes). The current implementation
> uses dmb() for mb() and friends but this is not sufficient. The DMB only
> ensures the ordering of accesses with regards to a single observer
> accessing the same memory. If a DMA transfer is started by a write to
> Device memory, the data to be transfered may not reach the main memory
> (even if mapped as Normal Non-cacheable) before the device receives the
> notification to begin the transfer. The only barrier that would help in
> this situation is DSB which would completely drain the write buffers.

On ARMv7, DMB guarantees that all accesses prior to DMB are observed by 
an observer if that observer sees any accesses _after_ the DMB. In this 
case, since DMA engine observes a write to itself( It is being written 
to and hence must observe the write) it should also see the writes to 
the buffers. A dmb() after the writes to buffer and before write to DMA 
engine should suffice.

Moreover an mb() could be in places where accesses to ARM's Device type 
memory need ordering and are 1kb apart. Such usages of mb() would result 
in a dsb() and could cause performance problems.

Since you mention the write buffers this probably applies only to ARMv6. 
Correct me here, I think that dmb on ARMv6 should suffice too.
