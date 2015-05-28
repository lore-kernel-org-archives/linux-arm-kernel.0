From: d.eppel@samsung.com (Damian Eppel)
Date: Thu, 28 May 2015 17:37:54 +0200
Subject: [PATCH v2] clocksource: exynos_mct: fix for sleeping in atomic ctx
 handling cpu hotplug notif.
In-Reply-To: <5566E417.1090508@samsung.com>
References: <1426151496-5509-1-git-send-email-d.eppel@samsung.com>
 <5566E417.1090508@samsung.com>
Message-ID: <1432827474.26384.4.camel@AMDC1552.digital.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-28 at 11:47 +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2015-03-12 10:11, Damian Eppel wrote:
> > This is to fix an issue of sleeping in atomic context when processing
> > hotplug notifications in Exynos MCT(Multi-Core Timer).
> > The issue was reproducible on Exynos 3250 (Rinato board) and Exynos 5420
> > (Arndale Octa board).
> >
> > Whilst testing cpu hotplug events on kernel configured with DEBUG_PREEMPT
> > and DEBUG_ATOMIC_SLEEP we get following BUG message, caused by calling
> > request_irq() and free_irq() in the context of hotplug notification
> > (which is in this case atomic context).
> >
> > root at target:~# echo 0 > /sys/devices/system/cpu/cpu1/online
> >
> > [   25.157867] IRQ18 no longer affine to CPU1
> > ...
> > [   25.158445] CPU1: shutdown
> >
> > root at target:~# echo 1 > /sys/devices/system/cpu/cpu1/online
> >
> > [   40.785859] CPU1: Software reset
> > [   40.786660] BUG: sleeping function called from invalid context at mm/slub.c:1241
> > [   40.786668] in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/1
> > [   40.786678] Preemption disabled at:[<  (null)>]   (null)
> > [   40.786681]
> > [   40.786692] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc4-00024-g7dca860 #36
> > [   40.786698] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [   40.786728] [<c0014a00>] (unwind_backtrace) from [<c0011980>] (show_stack+0x10/0x14)
> > [   40.786747] [<c0011980>] (show_stack) from [<c0449ba0>] (dump_stack+0x70/0xbc)
> > [   40.786767] [<c0449ba0>] (dump_stack) from [<c00c6124>] (kmem_cache_alloc+0xd8/0x170)
> > [   40.786785] [<c00c6124>] (kmem_cache_alloc) from [<c005d6f8>] (request_threaded_irq+0x64/0x128)
> > [   40.786804] [<c005d6f8>] (request_threaded_irq) from [<c0350b8c>] (exynos4_local_timer_setup+0xc0/0x13c)
> > [   40.786820] [<c0350b8c>] (exynos4_local_timer_setup) from [<c0350ca8>] (exynos4_mct_cpu_notify+0x30/0xa8)
> > [   40.786838] [<c0350ca8>] (exynos4_mct_cpu_notify) from [<c003b330>] (notifier_call_chain+0x44/0x84)
> > [   40.786857] [<c003b330>] (notifier_call_chain) from [<c0022fd4>] (__cpu_notify+0x28/0x44)
> > [   40.786873] [<c0022fd4>] (__cpu_notify) from [<c0013714>] (secondary_start_kernel+0xec/0x150)
> > [   40.786886] [<c0013714>] (secondary_start_kernel) from [<40008764>] (0x40008764)
> >
> > Solution:
> > Clockevent irqs cannot be requested/freed every time cpu is
> > hot-plugged/unplugged as CPU_STARTING/CPU_DYING notifications
> > that signals hotplug or unplug events are sent with both preemption
> > and local interrupts disabled. Since request_irq() may sleep it is
> > moved to the initialization stage and performed for all possible
> > cpus prior putting them online. Then, in the case of hotplug event
> > the irq asociated with the given cpu will simply be enabled.
> > Similarly on cpu unplug event the interrupt is not freed but just
> > disabled.
> >
> > Note that after successful request_irq() call for a clockevent device
> > associated to given cpu the requested irq is disabled (via disable_irq()).
> > That is to make things symmetric as we expect hotplug event as a next
> > thing (which will enable irq again). This should not pose any problems
> > because at the time of requesting irq the clockevent device is not
> > fully initialized yet, therefore should not produce interrupts at that point.
> >
> > For disabling an irq at cpu unplug notification disable_irq_nosync() is
> > chosen which is a non-blocking function. This again shouldn't be a problem as
> > prior sending CPU_DYING notification interrupts are migrated away
> > from the cpu.
> >
> > Fixes: 7114cd749a12 ("clocksource: exynos_mct: use (request/free)_irq calls for local timer registration")
> > Signed-off-by: Damian Eppel <d.eppel@samsung.com>
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > (Tested on Arndale Octa Board)
> > Tested-by: Marcin Jabrzyk <m.jabrzyk@samsung.com>
> > (Tested on Rinato B2 (Exynos 3250) board)
> > ---
> >
> > Notes:
> >      Changes since v1:
> >              o added Krzysztof's and Marcin's Reviewed-by / Tested-by
> >                with information about the test HW.
> >
> >   drivers/clocksource/exynos_mct.c | 45 ++++++++++++++++++++++++++++------------
> >   1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> > index 83564c9..9beca58 100644
> > --- a/drivers/clocksource/exynos_mct.c
> > +++ b/drivers/clocksource/exynos_mct.c
> > @@ -466,15 +466,12 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
> >   	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> >   
> >   	if (mct_int_type == MCT_INT_SPI) {
> > -		evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
> > -		if (request_irq(evt->irq, exynos4_mct_tick_isr,
> > -				IRQF_TIMER | IRQF_NOBALANCING,
> > -				evt->name, mevt)) {
> > -			pr_err("exynos-mct: cannot register IRQ %d\n",
> > -				evt->irq);
> > +
> > +		if (evt->irq == -1)
> >   			return -EIO;
> > -		}
> > -		irq_force_affinity(mct_irqs[MCT_L0_IRQ + cpu], cpumask_of(cpu));
> > +
> > +		irq_force_affinity(evt->irq, cpumask_of(cpu));
> > +		enable_irq(evt->irq);
> >   	} else {
> >   		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
> >   	}
> > @@ -487,10 +484,12 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
> >   static void exynos4_local_timer_stop(struct clock_event_device *evt)
> >   {
> >   	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
> > -	if (mct_int_type == MCT_INT_SPI)
> > -		free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
> > -	else
> > +	if (mct_int_type == MCT_INT_SPI) {
> > +		if (evt->irq != -1)
> > +			disable_irq_nosync(evt->irq);
> > +	} else {
> >   		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
> > +	}
> >   }
> >   
> >   static int exynos4_mct_cpu_notify(struct notifier_block *self,
> > @@ -522,7 +521,7 @@ static struct notifier_block exynos4_mct_cpu_nb = {
> >   
> >   static void __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
> >   {
> > -	int err;
> > +	int err, cpu;
> >   	struct mct_clock_event_device *mevt = this_cpu_ptr(&percpu_mct_tick);
> >   	struct clk *mct_clk, *tick_clk;
> >   
> > @@ -549,7 +548,27 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
> >   		WARN(err, "MCT: can't request IRQ %d (%d)\n",
> >   		     mct_irqs[MCT_L0_IRQ], err);
> >   	} else {
> > -		irq_set_affinity(mct_irqs[MCT_L0_IRQ], cpumask_of(0));
> > +		for_each_possible_cpu(cpu) {
> > +			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
> > +			struct mct_clock_event_device *pcpu_mevt =
> > +				per_cpu_ptr(&percpu_mct_tick, cpu);
> > +
> > +			pcpu_mevt->evt.irq = -1;
> > +
> > +			if (request_irq(mct_irq,
> > +					exynos4_mct_tick_isr,
> > +					IRQF_TIMER | IRQF_NOBALANCING,
> > +					pcpu_mevt->name, pcpu_mevt)) {
> > +				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
> > +									cpu);
> > +
> > +				continue;
> > +			}
> > +			pcpu_mevt->evt.irq = mct_irq;
> > +			irq_force_affinity(mct_irq, cpumask_of(cpu));
> > +
> > +			disable_irq(mct_irq);
> 
> Maybe it will be better to simply request this irq in disabled state? 
> Just call
> irq_set_status_flags(mct_irq, IRQ_NOAUTOEN) before request_irq().
> 

Good point, thanks. I will correct that in patch V3.

Best Regards,
Damian

> 
> > +		}
> >   	}
> >   
> >   	err = register_cpu_notifier(&exynos4_mct_cpu_nb);
> 
> Best regards
