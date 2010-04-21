From: skannan@codeaurora.org (skannan at codeaurora.org)
Date: Wed, 21 Apr 2010 03:31:03 -0700 (PDT)
Subject: udelay() broken for SMP cores?
In-Reply-To: <20100421095036.GA13971@n2100.arm.linux.org.uk>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
Message-ID: <d6e7a481ba26beb786f922f95a75875d.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Well, the assumption is that the CPUs will be running at their fastest
> speed at boot time, and therefore loops_per_jiffy will be calibrated
> such that we guarantee _at least_ the asked-for delay - which is the
> only guarantee udelay has.

Even if the boot assumption is true, cpufreq actively changes the
loops_per_jiffy value when it changes freq. So, this could still mess up
the _at least_ guarantee.

I think it's right for cpufreq to scale lpj with cpu speed to avoid udelay
from taking longer by several magnitudes. But we also need to avoid
breaking the guarantee. May be we can postpose the freq change if a
udelay loop is active.

Thanks,
Saravana
