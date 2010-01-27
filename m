From: jpihet@mvista.com (Jean Pihet)
Date: Wed, 27 Jan 2010 18:40:47 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000701ca9f75$dbe071f0$93a155d0$@deacon@arm.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001261847.44774.jpihet@mvista.com>
	<000701ca9f75$dbe071f0$93a155d0$@deacon@arm.com>
Message-ID: <201001271840.47714.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 27 January 2010 18:26:27 Will Deacon wrote:
> Hi Jean,
>
> * Jean Pihet wrote:
> > Here is the latest version of the patch, after review on the ML.
> > Adds the Performance Events support for ARMv7 processor, using
> > the PMNC unit in HW.
>
> I tested this on a dual-core Cortex-A9 [Realview PBX board].
> One thing I noticed was that, even if you don't add the PMU IRQs to
> kernel/pmu.c, perf will still report event counts [I guess this is
> due to sampling on context switch etc].
Yes, Perf Events uses the timer interrupts and the scheduler to control the 
events to be traced. The result is a really low IRQ count, which is good on 
the Cortex-A8 PMUs units that have the HW problem (known as errata).

> However, if the IRQs are 
> defined, but for some reason we fail to request them, then the
> armpmu_reserve_hardware function will fail.
That is the expected behaviour, isn't it?
Why is the PMU request failing? That is worth investigating. I never had that 
problem on the Cortex-A8. Is it caused because of the multicore?

> Actually, the return 
> value appears to be uninitialised if you don't have any IRQs defined.
If the PMU request fails the IRQ should not be requested, so I think it is ok. 
Is that correct?

>
> Anyway, apart from that, it appeared to work fine.
Good!

Thanks for testing!
Jean

> Tested-by: Will Deacon <will.deacon@arm.com>
>
> Will
