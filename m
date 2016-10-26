From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 26 Oct 2016 08:18:58 -0700
Subject: [PATCH v3] drivers: psci: PSCI checker module
In-Reply-To: <20161026131752.GA15478@red-moon>
References: <20161020145115.6326-1-kevin.brodsky@arm.com>
 <20161025154535.GA3107@red-moon>
 <20161025183436.GF3716@linux.vnet.ibm.com>
 <20161026131752.GA15478@red-moon>
Message-ID: <20161026151858.GQ3716@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 02:17:52PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 25, 2016 at 11:34:36AM -0700, Paul E. McKenney wrote:
> 
> [...]
> 
> > > > +static int __init psci_checker(void)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Since we're in an initcall, we assume that all the CPUs that all
> > > > +	 * CPUs that can be onlined have been onlined.
> > > > +	 *
> > > > +	 * The tests assume that hotplug is enabled but nobody else is using it,
> > > > +	 * otherwise the results will be unpredictable. However, since there
> > > > +	 * is no userspace yet in initcalls, that should be fine.
> > > 
> > > I do not think it is. If you run a kernel with, say,
> > > CONFIG_LOCK_TORTURE_TEST, cpus may disappear from the radar while
> > > running the PSCI checker test itself; that at least would confuse the
> > > checker, and that's just an example.
> > > 
> > > I added Paul to check what are the assumptions behind the torture test
> > > hotplug tests, in particular if there are any implicit assumptions for
> > > it to work (ie it is the only kernel test hotplugging cpus in and out
> > > (?)), what I know is that the PSCI checker assumptions are not correct.
> > 
> > Both CONFIG_LOCK_TORTURE_TEST and CONFIG_RCU_TORTURE_TEST can and will
> > hotplug CPUs.  The locktorture.onoff_holdoff and rcutorture.onoff_holdoff
> > kernel parameters can delay the start of CPU-hotplug testing, and in
> > my testing I set this delay to 30 seconds after boot.
> > 
> > One approach would be to make your test refuse to run if either of
> > the lock/RCU torture tests was running.  Or do what Lorenzo suggests
> > below.  The torture tests aren't crazy enough to offline the last CPU.
> > Though they do try, just for effect, in cases where the last CPU is
> > marked cpu_is_hotpluggable().  ;-)
> 
> Thank you Paul. I have an additional question though. Is there any
> implicit assumption in LOCK/RCU torture tests whereby nothing else
> in the kernel is hotplugging cpus in/out (through cpu_down()/up())
> while they are running ?
> 
> I am asking because that's the main reason behind my query. Those tests
> hotplug cpus in and out through cpu_down/up() but AFAICS nothing
> prevents another piece of code in the kernel to call those functions and
> the tests may just fail in that case (ie trying to cpu_down() a cpu
> that is not online).
> 
> Are false negatives contemplated (or I am missing something) ?

The current code assumes nothing else doing CPU-hotplug operations,
and will therefore print "RCU_HOTPLUG" error (or "LOCK_HOTPLUG" for
locktorture) if any of the hotplug operations failed.

> I just would like to understand if what this patch currently does
> is safe and sound. I think that calling cpu_down() and cpu_up()
> is always safe, but the test can result in false negatives if
> other kernel subsystems (eg LOCK torture test) are calling those
> APIs in parallel (because cpu_down()/cpu_up() calls can fail - eg
> trying to cpu_down() a cpu that is not online any longer, since it
> was taken down by another kernel control path), that's the question
> I have.

I am assuming that these added calls to cpu_down() and cpu_up() aren't
enabled by default.  If they are, rcutorture and locktorture need some
way to turn the off.

So maybe we need to have some sort of API that detects concurrent
CPU-hotplug torturing?  Maybe something like the following?

	static atomic_t n_cpu_hotplug_torturers;
	static atomic_t cpu_hotplug_concurrent_torture;

	void torture_start_cpu_hotplug(void)
	{
		if (atomic_inc_return(&n_cpu_hotplug_torturers) > 1)
			atomic_inc(&cpu_hotplug_concurrent_torture);
	}

	void torture_end_cpu_hotplug(void)
	{
		atomic_dec(&n_cpu_hotplug_torturers);
	}

	bool torture_cpu_hotplug_was_concurrent(void)
	{
		return !!atomic_read(&cpu_hotplug_concurrent_torture);
	}

The locktorture and rcutorture code could then ignore CPU-hotplug
errors that could be caused by concurrent access.  And complain
bitterly about the concurrent access, of course!  ;-)

Or am I missing your point?

							Thanx, Paul

> Thanks !
> Lorenzo
> 
> > 
> > 						Thanx, Paul
> > 
> > > There is something simple you can do to get this "fixed".
> > > 
> > > You can use the new API James implemented for hibernate,
> > > that allows you to disable (ie PSCI CPU OFF) all "secondary" cpus
> > > other than the primary one passed in as parameter:
> > > 
> > > freeze_secondary_cpus(int primary);
> > > 
> > > that function will _cpu_down() all online cpus other than "primary"
> > > in one go, without any interference allowed from other bits of the
> > > kernel. It requires an enable_nonboot_cpus() counterpart, and you
> > > can do that for every online cpus you detect (actually you can even
> > > avoid using the online cpu mask and use the present mask to carry
> > > out the test). If there is a resident trusted OS you can just
> > > trigger the test with primary == tos_resident_cpu, since all
> > > others are bound to fail (well, you can run them and check they
> > > do fail, it is a checker after all).
> > > 
> > > You would lose the capability of hotplugging a "cluster" at a time, but
> > > I do not think it is a big problem, the test above would cover it
> > > and more importantly, it is safe to execute.
> > > 
> > > Or we can augment the torture test API to restrict the cpumask
> > > it actually uses to offline/online cpus (I am referring to
> > > torture_onoff(), kernel/torture.c).
> > > 
> > > Further comments appreciated since I am not sure I grokked the
> > > assumption the torture tests make about hotplugging cpus in and out,
> > > I will go through the commits logs again to find more info.
> > > 
> > > Thanks !
> > > Lorenzo
> > > 
> > > > +	 */
> > > > +	nb_available_cpus = num_online_cpus();
> > > > +
> > > > +	/* Check PSCI operations are set up and working. */
> > > > +	ret = psci_ops_check();
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pr_info("PSCI checker started using %u CPUs\n", nb_available_cpus);
> > > > +
> > > > +	pr_info("Starting hotplug tests\n");
> > > > +	ret = hotplug_tests();
> > > > +	if (ret == 0)
> > > > +		pr_info("Hotplug tests passed OK\n");
> > > > +	else if (ret > 0)
> > > > +		pr_err("%d error(s) encountered in hotplug tests\n", ret);
> > > > +	else {
> > > > +		pr_err("Out of memory\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	pr_info("Starting suspend tests (%d cycles per state)\n",
> > > > +		NUM_SUSPEND_CYCLE);
> > > > +	ret = suspend_tests();
> > > > +	if (ret == 0)
> > > > +		pr_info("Suspend tests passed OK\n");
> > > > +	else if (ret > 0)
> > > > +		pr_err("%d error(s) encountered in suspend tests\n", ret);
> > > > +	else {
> > > > +		switch (ret) {
> > > > +		case -ENOMEM:
> > > > +			pr_err("Out of memory\n");
> > > > +			break;
> > > > +		case -ENODEV:
> > > > +			pr_warn("Could not start suspend tests on any CPU\n");
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	pr_info("PSCI checker completed\n");
> > > > +	return ret < 0 ? ret : 0;
> > > > +}
> > > > +late_initcall(psci_checker);
> > > > -- 
> > > > 2.10.0
> > > > 
> > > 
> > 
> 
