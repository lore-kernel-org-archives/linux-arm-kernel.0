From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jun 2011 15:52:29 +0100
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <274124B9C6907D4B8CE985903EAA19E9185A92978D@SI-MBX06.de.bosch.com>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
	<274124B9C6907D4B8CE985903EAA19E9185A92978D@SI-MBX06.de.bosch.com>
Message-ID: <20110623145229.GA18409@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Thu, Jun 23, 2011 at 04:39:01PM +0200, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> it's interesting that you almost agree with me.
> 
> But isn't it really expensive to flush the icache on switch_mm?
> Is that meant as a test to see if the problem goes away?

Who said anything about flushing the icache on switch_mm()? My patch
doesn't do this, it actually reduces the amount of cache flushing on
ARM11MPCore.

> Wouldn't it suffice to get_cpu/put_cpu to disable preemption while
> load_module() works?

It may work, just give it a try.

> I think the other way will cause trouble: the module is loaded on
> cpu0 for example, preempted, woken up on cpu1 with a stale icache
> line not holding the "newly loaded code" and running mod->init peng!
> Nobody told cpu1 to revalidate it's icache.
> Don't know if this is possible though.

That's possible as well if the pages allocated for the module code have
been previously used for other code.

To resolve the stale I-cache lines, you would have to broadcast the
cache maintenance to all the CPUs. For the D-cache we could trick the
CPU via some reading to force the dirty cache lines migration but that's
not possible for the I-cache.

> The data of the module won't get through the icache anyway.

No but the module is copied into the new allocated space via the
D-cache. This needs to be flushed so that the I-cache would get the
right instructions.

> AFAIK we are not able to reproduce quickly and it will take some
> time before I can try...

OK, just let us know how it goes.

-- 
Catalin
