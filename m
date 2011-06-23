From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Thu, 23 Jun 2011 17:20:39 +0200
Subject: AW: parallel load of modules on an ARM multicore
In-Reply-To: <20110623145229.GA18409@1n450.cable.virginmedia.net>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
	<274124B9C6907D4B8CE985903EAA19E9185A92978D@SI-MBX06.de.bosch.com>
	<20110623145229.GA18409@1n450.cable.virginmedia.net>
Message-ID: <274124B9C6907D4B8CE985903EAA19E9185A92978E@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No, you didn't say that, but the patch ;)

--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #ifdef CONFIG_SMP
        /* check for possible thread migration */
        if (!cpumask_empty(mm_cpumask(next)) &&
-           !cpumask_test_cpu(cpu, mm_cpumask(next)))
+           (cache_ops_need_broadcast() ||
+            !cpumask_test_cpu(cpu, mm_cpumask(next))))
                __flush_icache_all();


On ARM11MPcore cache_ops_need_broadcast() returns true -
with that, anytime the thread migrates the icache is flushed?


Mit freundlichen Gr??en / Best regards

Peter W?chtler

> -----Urspr?ngliche Nachricht-----
> Von: Catalin Marinas [mailto:catalin.marinas at gmail.com] Im
> Auftrag von Catalin Marinas
> Gesendet: Donnerstag, 23. Juni 2011 16:52
> An: EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31)
> Cc: linux-arm-kernel at lists.infradead.org
> Betreff: Re: parallel load of modules on an ARM multicore
>
> Peter,
>
> On Thu, Jun 23, 2011 at 04:39:01PM +0200, EXTERNAL Waechtler
> Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> > it's interesting that you almost agree with me.
> >
> > But isn't it really expensive to flush the icache on switch_mm?
> > Is that meant as a test to see if the problem goes away?
>
> Who said anything about flushing the icache on switch_mm()? My patch
> doesn't do this, it actually reduces the amount of cache flushing on
> ARM11MPCore.
>
> > Wouldn't it suffice to get_cpu/put_cpu to disable preemption while
> > load_module() works?
>
> It may work, just give it a try.
>
> > I think the other way will cause trouble: the module is loaded on
> > cpu0 for example, preempted, woken up on cpu1 with a stale icache
> > line not holding the "newly loaded code" and running mod->init peng!
> > Nobody told cpu1 to revalidate it's icache.
> > Don't know if this is possible though.
>
> That's possible as well if the pages allocated for the module
> code have
> been previously used for other code.
>
> To resolve the stale I-cache lines, you would have to broadcast the
> cache maintenance to all the CPUs. For the D-cache we could trick the
> CPU via some reading to force the dirty cache lines migration
> but that's
> not possible for the I-cache.
>
> > The data of the module won't get through the icache anyway.
>
> No but the module is copied into the new allocated space via the
> D-cache. This needs to be flushed so that the I-cache would get the
> right instructions.
>
> > AFAIK we are not able to reproduce quickly and it will take some
> > time before I can try...
>
> OK, just let us know how it goes.
>
> --
> Catalin
>
