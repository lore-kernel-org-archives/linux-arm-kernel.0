From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 18 Mar 2016 09:40:25 +0000
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160318003322.GC4287@linux.vnet.ibm.com>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
 <20160317225557.GA4287@linux.vnet.ibm.com> <56EB4937.1010404@mellanox.com>
 <20160318003322.GC4287@linux.vnet.ibm.com>
Message-ID: <56EBCD09.2000400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/16 00:33, Paul E. McKenney wrote:
> On Thu, Mar 17, 2016 at 08:17:59PM -0400, Chris Metcalf wrote:
>> On 3/17/2016 6:55 PM, Paul E. McKenney wrote:
>>> The RCU stall-warn stack traces can be ugly, agreed.
>>>
>>> That said, RCU used to use NMI-based stack traces, but switched to the
>>> current scheme due to the NMIs having the unfortunate habit of locking
>>> things up, which IIRC often meant no stack traces at all.  If I recall
>>> correctly, one of the problems was self-deadlock in printk().
>>
>> Steven Rostedt enabled the per_cpu printk func support in June 2014, and
>> the nmi_backtrace code uses it to just capture printk output to percpu
>> buffers, so I think it's going to be a lot more robust than earlier attempts.
>
> That would be a very good thing, give or take the "I think" qualifier.
> And assuming that the target CPU is healthy enough to find its way back
> to some place that can dump the per-CPU printk buffer.  I might well
> be overly paranoid, but I have to suspect that the probability of that
> buffer getting dumped is reduced greatly on a CPU that isn't healthy
> enough to respond to RCU, though.

The target CPU doesn't dump the buffer. It "just" fields the NMI, stores 
the backtrace and sets a flag.

The buffer is dumped to console by the requesting CPU, either when all 
backtraces have come back or when a timeout is reached.


> But it seems like enabling the experiment might be useful.
>
> "Try enabling the NMI version.  If that doesn't get you your RCU CPU
> stall warning stack trace, try the remote-print variant."
>
> Or I suppose we could just do both in succession, just in case their
> console was a serial port.  ;-)

I guess both might be needed but only when the target CPU is dead enough 
to fail to respond to NMI. In principle, we could exploit the timeout in 
the NMI backtrace logic and only issue the missing backtraces.


Daniel.
