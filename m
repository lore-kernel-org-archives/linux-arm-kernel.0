From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 4 Feb 2015 07:56:15 -0800
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <1423063348.24415.10.camel@AMDC1943>
References: <20150201025922.GA16820@wfg-t540p.sh.intel.com>
 <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
 <20150204130018.GG8656@n2100.arm.linux.org.uk>
 <20150204131420.GC5370@linux.vnet.ibm.com>
 <1423059387.24415.2.camel@AMDC1943>
 <20150204151028.GD5370@linux.vnet.ibm.com>
 <1423063348.24415.10.camel@AMDC1943>
Message-ID: <20150204155615.GF5370@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 04:22:28PM +0100, Krzysztof Kozlowski wrote:
> On ?ro, 2015-02-04 at 07:10 -0800, Paul E. McKenney wrote:
> > On Wed, Feb 04, 2015 at 03:16:27PM +0100, Krzysztof Kozlowski wrote:
> > > On ?ro, 2015-02-04 at 05:14 -0800, Paul E. McKenney wrote:
> > > > On Wed, Feb 04, 2015 at 01:00:18PM +0000, Russell King - ARM Linux wrote:
> > > > > On Wed, Feb 04, 2015 at 12:39:07PM +0100, Krzysztof Kozlowski wrote:
> > > > > > +Cc some ARM people
> > > > > 
> > > > > I wish that people would CC this list with problems seen on ARM.  I'm
> > > > > minded to just ignore this message because of this in the hope that by
> > > > > doing so, people will learn something...
> > > > > 
> > > > > > > Another thing I could do would be to have an arch-specific Kconfig
> > > > > > > variable that made ARM responsible for informing RCU that the CPU
> > > > > > > was departing, which would allow a call to as follows to be placed
> > > > > > > immediately after the complete():
> > > > > > > 
> > > > > > > rcu_cpu_notify(NULL, CPU_DYING_IDLE, (void *)(long)smp_processor_id());
> > > > > > > 
> > > > > > > Note:  This absolutely requires that the rcu_cpu_notify() -always-
> > > > > > > be allowed to execute!!!  This will not work if there is -any- possibility
> > > > > > > of __cpu_die() powering off the outgoing CPU before the call to
> > > > > > > rcu_cpu_notify() returns.
> > > > > 
> > > > > Exactly, so that's not going to be possible.  The completion at that
> > > > > point marks the point at which power _could_ be removed from the CPU
> > > > > going down.
> > > > 
> > > > OK, sounds like a polling loop is required.
> > > 
> > > I thought about using wait_on_bit() in __cpu_die() (the waiting thread)
> > > and clearing the bit on CPU being powered down. What do you think about
> > > such idea?
> > 
> > Hmmm...  It looks to me that wait_on_bit() calls out_of_line_wait_on_bit(),
> > which in turn calls __wait_on_bit(), which calls prepare_to_wait() and
> > finish_wait().  These are in the scheduler, but this is being called from
> > the CPU that remains online, so that should be OK.
> > 
> > But what do you invoke on the outgoing CPU?  Can you get away with
> > simply clearing the bit, or do you also have to do a wakeup?  It looks
> > to me like a wakeup is required, which would be illegal on the outgoing
> > CPU, which is at a point where it cannot legally invoke the scheduler.
> > Or am I missing something?
> 
> Actually the timeout versions but I think that doesn't matter.
> The wait_on_bit will busy-loop with testing for the bit. Inside the loop
> it calls the 'action' which in my case will be bit_wait_io_timeout().
> This calls schedule_timeout().

Ah, good point.

> See proof of concept in attachment. One observed issue: hot unplug from
> commandline takes a lot more time. About 7 seconds instead of ~0.5.
> Probably I did something wrong.

Well, you do set the timeout to five seconds, and so if the condition
does not get set before the surviving CPU finds its way to the
out_of_line_wait_on_bit_timeout(), you are guaranteed to wait for at
least five seconds.

One alternative approach would be to have a loop around a series of
shorter waits.  Other thoughts?

> > You know, this situation is giving me a bad case of nostalgia for the
> > old Sequent Symmetry and NUMA-Q hardware.  On those platforms, the
> > outgoing CPU could turn itself off, and thus didn't need to tell some
> > other CPU when it was ready to be turned off.  Seems to me that this
> > self-turn-off capability would be a great feature for future systems!
> 
> There are a lot more issues with hotplug on ARM...

Just trying to clean up this particular corner at the moment.  ;-)

> Patch/RFC attached.

Again, I believe that you will need to loop over a shorter timeout
in order to get reasonable latencies.  If waiting a millisecond at
a time is an energy-efficiency concern (don't know why it would be
in this rare case, but...), then one approach would be to start
with very short waits, then increase the wait time, for example,
doubling the wait time on each pass through the loop would result
in a smallish number of wakeups, but would mean that you waited
no more than twice as long as necessary.

Thoughts?

							Thanx, Paul

> >From feaad18a483871747170fa797f80b49592489ad1 Mon Sep 17 00:00:00 2001
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Date: Wed, 4 Feb 2015 16:14:41 +0100
> Subject: [RFC] ARM: Don't use complete() during __cpu_die
> 
> The complete() should not be used on offlined CPU.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/kernel/smp.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 86ef244c5a24..f3a5ad80a253 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -26,6 +26,7 @@
>  #include <linux/completion.h>
>  #include <linux/cpufreq.h>
>  #include <linux/irq_work.h>
> +#include <linux/wait.h>
> 
>  #include <linux/atomic.h>
>  #include <asm/smp.h>
> @@ -76,6 +77,9 @@ enum ipi_msg_type {
> 
>  static DECLARE_COMPLETION(cpu_running);
> 
> +#define CPU_DIE_WAIT_BIT		0
> +static unsigned long wait_cpu_die;
> +
>  static struct smp_operations smp_ops;
> 
>  void __init smp_set_ops(struct smp_operations *ops)
> @@ -133,7 +137,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
> 
> -
> +	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
>  	memset(&secondary_data, 0, sizeof(secondary_data));
>  	return ret;
>  }
> @@ -213,7 +217,17 @@ int __cpu_disable(void)
>  	return 0;
>  }
> 
> -static DECLARE_COMPLETION(cpu_died);
> +static int wait_for_cpu_die(void)
> +{
> +	might_sleep();
> +
> +	if (!test_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die))
> +		return 0;
> +
> +	return out_of_line_wait_on_bit_timeout(&wait_cpu_die, CPU_DIE_WAIT_BIT,
> +					bit_wait_timeout, TASK_UNINTERRUPTIBLE,
> +					msecs_to_jiffies(5000));
> +}
> 
>  /*
>   * called on the thread which is asking for a CPU to be shutdown -
> @@ -221,7 +235,7 @@ static DECLARE_COMPLETION(cpu_died);
>   */
>  void __cpu_die(unsigned int cpu)
>  {
> -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> +	if (wait_for_cpu_die()) {
>  		pr_err("CPU%u: cpu didn't die\n", cpu);
>  		return;
>  	}
> @@ -267,7 +281,7 @@ void __ref cpu_die(void)
>  	 * this returns, power and/or clocks can be removed at any point
>  	 * from this CPU and its cache by platform_cpu_kill().
>  	 */
> -	complete(&cpu_died);
> +	clear_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
> 
>  	/*
>  	 * Ensure that the cache lines associated with that completion are
> -- 
> 1.9.1
> 
