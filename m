From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 May 2014 11:58:25 +0100
Subject: the cost of _raw_spin_lock in arm linux
In-Reply-To: <OF33C6F1E2.8DD5197C-ON48257CE1.0037D051-48257CE1.0037D052@spreadtrum.com>
References: <OF33C6F1E2.8DD5197C-ON48257CE1.0037D051-48257CE1.0037D052@spreadtrum.com>
Message-ID: <20140523105825.GU3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 06:09:38PM +0800, Xing.Wei at spreadtrum.com wrote:
> I'm a sw engineer from the mobile soc company named spreadtrum.
> And our soc based on arm smp cortex-A7 with 4 cores, all runs at fixed 600Mhz.
> We found a problem that the coreX which will be unplugged take about more than 40ms
> to excute the take_cpu_down function(migrate irqs, migrate tasks, etc), the result is all other online cores have to
> wait for the coreX finish that with irq disabled.
> So I use ftrace to analyze this problem.

One of the most basic points here is the Schrodinger's cat problem - that
you can't measure the system without affecting it.  That is very true of
ftrace - it imposes significant overheads which can change the timing
quite considerably.

The second point is that if you have things like lockdep enabled or other
debugging options, the otherwise lightweight spinlocks become really quite
heavy.

So, if you're doing development, you should have things like lockdep and
other debugging options enabled to help find bugs in your code.  Once
you've debugged the code and you're ready to start caring about
performance, you need to turn all those debugging options off (but don't
forget to turn them back on to check for newly introduced bugs afterwards.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
