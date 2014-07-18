From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jul 2014 09:29:21 +0100
Subject: [PATCH] ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs
In-Reply-To: <53C8BBA2.7060308@gmail.com>
References: <1405617110-1136-1-git-send-email-romain.perier@gmail.com>
 <20140717221436.GZ21766@n2100.arm.linux.org.uk> <53C8BBA2.7060308@gmail.com>
Message-ID: <20140718082921.GB21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 08:16:02AM +0200, Romain Perier wrote:
> you're probably talking about __cpu_die at  
> http://lxr.free-electrons.com/source/arch/arm/kernel/smp.c#L223 . The  
> problem being that the thread below which executes cpu_die completes the  
> completion before executing smp_ops.cpu_die. So smp_ops.cpu_kill might  
> be executed before smp_ops.cpu_die (in some cases cache coherency would  
> not be turned off). Note that almost all SoCs do the same thing.

Look at what's happening:

	CPU0				CPU1
	wait_for_completion_timeout()
					idle_task_exit()
					flush_cache_louis()
					complete(&cpu_died);

At this point, it is safe for CPU1 to be powered down.

	smp_ops.cpu_kill(cpu);
					flush_cache_louis();
					smp_ops.cpu_die(cpu);

If we include your code at that point, then the sequence in totality
becomes:

	wait_for_completion_timeout()
					idle_task_exit()
					flush_cache_louis()
					complete(&cpu_died);
	--- rockchip_cpu_kill ---
	wait_for_completion_timeout()
					flush_cache_louis();
					--- rockchip_cpu_die ---
					complete(&cpu_died);
	pmu_set_power_domain(0 + cpu, false);
					flush_cache_louis();
					v7_exit_coherency_flush(louis);
					while(1)
						cpu_do_idle();

So, I repeat my question.  What is the point of your additional wait
in rockchip_cpu_kill() and complete in rockchip_cpu_die()?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
