From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Mar 2015 12:55:45 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150322233057.GA17605@linux.vnet.ibm.com>
References: <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <20150225170011.GC8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
 <alpine.LFD.2.11.1502251427580.25484@knanqh.ubzr>
 <20150226010505.GU15405@linux.vnet.ibm.com>
 <20150322233057.GA17605@linux.vnet.ibm.com>
Message-ID: <20150323125545.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 04:30:57PM -0700, Paul E. McKenney wrote:
> On Wed, Feb 25, 2015 at 05:05:05PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 25, 2015 at 03:16:59PM -0500, Nicolas Pitre wrote:
> > > On Wed, 25 Feb 2015, Nicolas Pitre wrote:
> > > 
> > > > On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:
> > > > 
> > > > > We could just use the spin-and-poll solution instead of an IPI, but
> > > > > I really don't like that - when you see the complexity needed to
> > > > > re-initialise it each time, it quickly becomes very yucky because
> > > > > there is no well defined order between __cpu_die() and __cpu_kill()
> > > > > being called by the two respective CPUs.
> > > > > 
> > > > > The last patch I saw doing that had multiple bits to indicate success
> > > > > and timeout, and rather a lot of complexity to recover from failures,
> > > > > and reinitialise state for a second CPU going down.
> > > > 
> > > > What about a per CPU state?  That would at least avoid the need to 
> > > > serialize things across CPUs.  If only one CPU may write its state, that 
> > > > should eliminate the need for any kind of locking.
> > > 
> > > Something like the following?  If according to $subject it is the 
> > > complete() usage that has problems, then this replacement certainly has 
> > > it removed while keeping things simple.  And I doubt CPU hotplug is 
> > > performance critical so a simple polling is certainly good enough.
> > 
> > For whatever it is worth, I am proposing the patch below for common code.
> > Works on x86.  (Famous last words...)
> 
> So I am intending to submit these changes to the upcoming merge window.
> Do you guys have something in place for ARM?

I've rather dropped the ball on this (sorry, I've had wisdom teeth out,
with a week long recovery, and then had to catch back up with mail...).

Looking at this patch, what advantage does using atomic_t give us?
For example:

> > +int cpu_check_up_prepare(int cpu)
> > +{
> > +	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> > +		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
> > +		return 0;
> > +	}
> > +
> > +	switch (atomic_read(&per_cpu(cpu_hotplug_state, cpu))) {
> > +
> > +	case CPU_POST_DEAD:
> > +
> > +		/* The CPU died properly, so just start it up again. */
> > +		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
> > +		return 0;

What if the cpu_hotplug_state for the CPU changes between reading it
testing its value, and then writing it, or do we guarantee that it
can't change other than by this function here?  If it can't change,
then what's the point of using atomic_t for this?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
