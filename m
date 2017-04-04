From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 4 Apr 2017 16:29:23 +0900
Subject: [PATCH v35 08/14] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <1491211294.6020.21.camel@infradead.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
 <20170403022440.12515-6-takahiro.akashi@linaro.org>
 <1491211294.6020.21.camel@infradead.org>
Message-ID: <20170404072922.GH16309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 10:21:34AM +0100, David Woodhouse wrote:
> On Mon, 2017-04-03 at 11:24 +0900, AKASHI Takahiro wrote:
> > 
> > +static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs
> > *regs)
> > +{
> > +#ifdef CONFIG_KEXEC_CORE
> > +???????crash_save_cpu(regs, cpu);
> > +
> > +???????atomic_dec(&waiting_for_crash_ipi);
> > +
> > +???????local_irq_disable();
> 
> Shouldn't the above two be the other way round? Stop handling
> interrupts *before* we tell the surviving CPU that we're done?

Might be, but I'm not sure how well such a change works.
Do you see any improvement in, say, saving failed-to-reboot cases?

> Also, should the surviving CPU be calling __cpu_die() to attempt to
> check that the others really have died? Sure, it can't do much more
> than print a warning if the call to ->cpu_kill() times out, but that's
> still useful information.

A pair of cpu_wait_death() and cpu_report_death() merely does
a hand-shake protocol over per-cpu "cpu_hotplug_state" variable.
In this sense, it's not much different from "waiting_for_crash_ipi"
approach used here in ipi_cpu_crash_stop().

Having said that, cpu_ops->cpu_kill() might help forcefully tear down
the cpu(s). One of my concerns is that we may lose some data in cache.

> And perhaps we could allow platforms to
> register a method to shoot other CPUs down forcefully if they don't
> respond. My board could apparently support that.
> 
> It would certainly be useful to allow smp_send_crash_stop() to be
> overridden with a platform-specific method instead of normal IPIs. The
> platform might be able to do something... less maskable.

I agree.
It would be great if you post your own patch for such a new interface.
(Without any hardware, I can't implement/test this feature, anyway.)

Thanks,
-Takahiro AKASHI
