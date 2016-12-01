From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Dec 2016 17:27:20 +0000
Subject: [PATCH] arm64: smp: Prevent raw_smp_processor_id() recursion
In-Reply-To: <2bd54897-df2e-a20e-d748-07966642b850@arm.com>
References: <bb132e9abf4d256e40ad311b106b05d724b290fb.1480607460.git.robin.murphy@arm.com>
 <2bd54897-df2e-a20e-d748-07966642b850@arm.com>
Message-ID: <20161201172720.GB9191@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 05:16:50PM +0000, Robin Murphy wrote:
> On 01/12/16 15:55, Robin Murphy wrote:
> > Under CONFIG_DEBUG_PREEMPT=y, this_cpu_ptr() ends up calling back into
> > raw_smp_processor_id(), resulting in some hilariously catastrophic
> > infinite recursion. In the normal case, we have:
> > 
> >   #define this_cpu_ptr(ptr) raw_cpu_ptr(ptr)
> > 
> > and everything is dandy. However for CONFIG_DEBUG_PREEMPT, this_cpu_ptr()
> > is defined in terms of my_cpu_offset, wherein the fun begins:
> > 
> >   #define my_cpu_offset per_cpu_offset(smp_processor_id())
> >   ...
> >   #define smp_processor_id() debug_smp_processor_id()
> >   ...
> >   notrace unsigned int debug_smp_processor_id(void)
> >   {
> >   	return check_preemption_disabled("smp_processor_id", "");
> >   ...
> >   notrace static unsigned int check_preemption_disabled(const char *what1,
> >   							const char *what2)
> >   {
> >   	int this_cpu = raw_smp_processor_id();
> > 
> > and bang. Use raw_cpu_ptr() directly to avoid that.
> > 
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> I wasn't sure whether commit IDs on for-next/core are stable, but if
> they are, this could also have:
> 
> Fixes: 57c82954e77f ("arm64: make cpu number a percpu variable")

It depends on which branch is pulled into next. I keep the for-next/core
stable at this stage, so I'll include the Fixes like as well. Thanks.

-- 
Catalin
