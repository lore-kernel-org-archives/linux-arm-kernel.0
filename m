From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 22 Feb 2013 14:54:11 +0100
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <1361540926.26780.56.camel@laptop>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361522767.26780.44.camel@laptop>
 <20130222125019.GC17948@somewhere.redhat.com>
 <1361540926.26780.56.camel@laptop>
Message-ID: <20130222135411.GA9202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, 2013-02-22 at 13:50 +0100, Frederic Weisbecker wrote:

> > atomic64_read() and atomic64_set() are supposed to take care 
> > of that, without even the need for _inc() or _add() parts 
> > that use LOCK.
> 
> Are you sure? Generally atomic*_set() is not actually an 
> atomic operation.

as per Documentation/atomic_ops.h:

        #define atomic_read(v)  ((v)->counter)

 which simply reads the counter value currently visible to the 
 calling thread. The read is atomic in that the return value is 
 guaranteed to be one of the values initialized or modified with 
 the interface operations if a proper implicit or explicit 
 memory barrier is used after possible runtime initialization by 
 any other thread and the value is modified only with the 
 interface operations.

 ...

 Properly aligned pointers, longs, ints, and chars (and unsigned 
 equivalents) may be atomically loaded from and stored to in the 
 same sense as described for atomic_read() and atomic_set().  

 The ACCESS_ONCE() macro should be used to prevent the compiler 
 from using optimizations that might otherwise optimize accesses 
 out of existence on the one hand, or that might create 
 unsolicited accesses on the other.

This is usually a side effect of M[O]ESI cache coherency 
protocols - you can only get a 'split' word access if the word 
crosses cache line boundaries (multiples of 32 bytes, 
generally).

Thanks,

	Ingo
