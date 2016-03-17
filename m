From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 17 Mar 2016 15:55:57 -0700
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317193600.GY6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
Message-ID: <20160317225557.GA4287@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 08:36:00PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 01:02:10PM -0400, Chris Metcalf wrote:
> > Currently you can only request a backtrace of either all cpus, or
> > all cpus but yourself.  It can also be helpful to request a remote
> > backtrace of a single cpu, and since we want that, the logical
> > extension is to support a cpumask as the underlying primitive.
> > 
> > This change modifies the existing lib/nmi_backtrace.c code to take
> > a cpumask as its basic primitive, and modifies the linux/nmi.h code
> > to use either the old "all/all_but_self" arch methods, or the new
> > "cpumask" method, depending on which is available.
> > 
> > The existing clients of nmi_backtrace (arm and x86) are converted
> > to using the new cpumask approach in this change.
> 
> So the past days I've been staring at RCU stall warns, and they can use
> a little of this. Their remote stack unwinds are less than useful.

The RCU stall-warn stack traces can be ugly, agreed.

That said, RCU used to use NMI-based stack traces, but switched to the
current scheme due to the NMIs having the unfortunate habit of locking
things up, which IIRC often meant no stack traces at all.  If I recall
correctly, one of the problems was self-deadlock in printk().

Have these problems been fixed?

							Thanx, Paul
