From: geoff@infradead.org (Geoff Levand)
Date: Thu, 07 Jul 2016 09:42:34 -0700
Subject: [PATCH v21 3/8] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20160707004330.GU20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-4-takahiro.akashi@linaro.org>
 <1467826137.8880.35.camel@infradead.org>
 <20160707004330.GU20774@linaro.org>
Message-ID: <1467909754.8880.56.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2016-07-07 at 09:43 +0900, AKASHI Takahiro wrote:
> On Wed, Jul 06, 2016 at 10:28:57AM -0700, Geoff Levand wrote:
> > On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> > > @@ -830,6 +855,14 @@ void handle_IPI(int ipinr, struct pt_regs
> > > *regs)
> > >  > > > > 	> > > > > > > 	> > > > irq_exit();
> > >  > > > > 	> > > > > > > 	> > > > break;
> > >  
> > > +#ifdef CONFIG_KEXEC_CORE
> > > +> > > > 	> > > > case IPI_CPU_CRASH_STOP:
> > > +> > > > 	> > > > > > > 	> > > > irq_enter();
> > > +> > > > 	> > > > > > > 	> > > > ipi_cpu_crash_stop(cpu, regs);
> > > +
> > > +> > > > 	> > > > > > > 	> > > > unreachable();
> > > +#endif
> > 
> > It seems like you could simplifiy with something like:
> > 
> > 	> > case IPI_CPU_CRASH_STOP:
> > 	> > 	> > if (IS_ENABLED(CONFIG_KEXEC_CORE) {
> > 	> > 	> > 	> > irq_enter();
> > 	> > 	> > 	> > ipi_cpu_crash_stop(cpu, regs);
> > 	> > 	> > 	> > unreachable();
> > 	> > 	> > }
> 
> OK, I will take this.
> 
> > Then move the CONFIG_KEXEC_CORE conditional around
> > ipi_cpu_crash_stop to just around crash_save_cpu().
> 
> Yeah, we can do that, but I added these conditionals just because
> the kernel size can be reduced (a bit, obviously) if kexec is
> not needed.

The linker will remove the unused ipi_cpu_crash_stop since
it is static.  atomic_t waiting_for_crash_ipi also becomes
unused, and I think it will be removed also.  The motivation
for these changes is to get a build test of this code
even when CONFIG_KEXEC_CORE=n.

-Geoff
