From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 4 Feb 2015 07:10:28 -0800
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <1423059387.24415.2.camel@AMDC1943>
References: <20150201025922.GA16820@wfg-t540p.sh.intel.com>
 <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
 <20150204130018.GG8656@n2100.arm.linux.org.uk>
 <20150204131420.GC5370@linux.vnet.ibm.com>
 <1423059387.24415.2.camel@AMDC1943>
Message-ID: <20150204151028.GD5370@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 03:16:27PM +0100, Krzysztof Kozlowski wrote:
> On ?ro, 2015-02-04 at 05:14 -0800, Paul E. McKenney wrote:
> > On Wed, Feb 04, 2015 at 01:00:18PM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Feb 04, 2015 at 12:39:07PM +0100, Krzysztof Kozlowski wrote:
> > > > +Cc some ARM people
> > > 
> > > I wish that people would CC this list with problems seen on ARM.  I'm
> > > minded to just ignore this message because of this in the hope that by
> > > doing so, people will learn something...
> > > 
> > > > > Another thing I could do would be to have an arch-specific Kconfig
> > > > > variable that made ARM responsible for informing RCU that the CPU
> > > > > was departing, which would allow a call to as follows to be placed
> > > > > immediately after the complete():
> > > > > 
> > > > > rcu_cpu_notify(NULL, CPU_DYING_IDLE, (void *)(long)smp_processor_id());
> > > > > 
> > > > > Note:  This absolutely requires that the rcu_cpu_notify() -always-
> > > > > be allowed to execute!!!  This will not work if there is -any- possibility
> > > > > of __cpu_die() powering off the outgoing CPU before the call to
> > > > > rcu_cpu_notify() returns.
> > > 
> > > Exactly, so that's not going to be possible.  The completion at that
> > > point marks the point at which power _could_ be removed from the CPU
> > > going down.
> > 
> > OK, sounds like a polling loop is required.
> 
> I thought about using wait_on_bit() in __cpu_die() (the waiting thread)
> and clearing the bit on CPU being powered down. What do you think about
> such idea?

Hmmm...  It looks to me that wait_on_bit() calls out_of_line_wait_on_bit(),
which in turn calls __wait_on_bit(), which calls prepare_to_wait() and
finish_wait().  These are in the scheduler, but this is being called from
the CPU that remains online, so that should be OK.

But what do you invoke on the outgoing CPU?  Can you get away with
simply clearing the bit, or do you also have to do a wakeup?  It looks
to me like a wakeup is required, which would be illegal on the outgoing
CPU, which is at a point where it cannot legally invoke the scheduler.
Or am I missing something?

You know, this situation is giving me a bad case of nostalgia for the
old Sequent Symmetry and NUMA-Q hardware.  On those platforms, the
outgoing CPU could turn itself off, and thus didn't need to tell some
other CPU when it was ready to be turned off.  Seems to me that this
self-turn-off capability would be a great feature for future systems!

							Thanx, Paul
