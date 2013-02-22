From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 22 Feb 2013 15:09:10 +0100
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <20130222125019.GC17948@somewhere.redhat.com>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361522767.26780.44.camel@laptop>
 <20130222125019.GC17948@somewhere.redhat.com>
Message-ID: <1361542150.26780.64.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 13:50 +0100, Frederic Weisbecker wrote:
> > Argh!! at what cost? 64bit atomics are like expensive. Wouldn't
> adding
> > a seqlock be saner?
> 
> Not sure. This requires a spinlock in the write side which is called
> from
> fast path like the timer interrupt.

A single spinlock is _way_ cheaper than a ton of cmpxchg8b()s to update
a few variables.
