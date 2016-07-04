From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jul 2016 14:05:45 +0100
Subject: [PATCHv2 0/2] arm-cc*: fix PMU interrupt flags
In-Reply-To: <20160704125740.GH1639@arm.com>
References: <1467631532-8122-1-git-send-email-mark.rutland@arm.com>
 <20160704125740.GH1639@arm.com>
Message-ID: <20160704130545.GA9048@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 01:57:40PM +0100, Will Deacon wrote:
> On Mon, Jul 04, 2016 at 12:25:30PM +0100, Mark Rutland wrote:
> > As discovered during review of the X-Gene SoC PMU [1], the arm-cc{i,n} drivers
> > don't ensure that IRQ balancers don't migrate interrupts.
> > 
> > This is problematic for the perf core code, which requires mutual exclusion of
> > certain operations (e.g. event rotation, cross-calls, and irq handling) to be
> > provided by disabling IRQs, which only works if all operations occur on the
> > same CPU. This is also required for safe (lockless) manipulation of some data
> > structures.
> > 
> > To avoid this problem, we must request interrupts with IRQF_NOBALANCING, as is
> > already the case for CPU PMU drivers which make use of interrupts.
> > 
> > To ensure synchronisation between IRQ handlers and other manipulation of said
> > data structures or HW state, we must also ensure that the interrupt handlers
> > are not threaded, by requesting them with IRQF_NO_THREAD, as is already the
> > case for CPU PMU drivers.
> 
> Thanks, looks good now:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Cheers!

I take it that as with the other recent CCI patch [1] you expect the
patches to go via arm-soc.

Arnd, Olof, are you happy to pick these patches?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/440916.html
