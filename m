From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 17:38:24 +0000
Subject: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
In-Reply-To: <1291307320.11271.51.camel@e102109-lin.cambridge.arm.com>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
	<20101130233204.GB14383@n2100.arm.linux.org.uk>
	<20101201002527.GC14383@n2100.arm.linux.org.uk>
	<AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
	<20101202152428.GD10461@n2100.arm.linux.org.uk>
	<1291307320.11271.51.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101202173824.GE10461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 04:28:40PM +0000, Catalin Marinas wrote:
> The SCU is part of the core TRM, so I don't expect it to be the same
> across various MP cores (and A15 is an example).
> 
> You may want to consolidate functions like scu_prepare_cpus (maybe call
> it smp_prepare_cpus)

You do realise the function called from architecture independent code is
called 'smp_prepare_cpus' ?

> and something that calls set_cpu_possible() but
> with platform callbacks for getting the number of calls and initialising
> the SMP (SCU for most platforms).

What if a platform, for what ever reason, wants to have 3 CPUs,
numbered 0, 2, 3 ?  That's the reason why the code which sets the
possible and present maps isn't in the ARM core code - Eg, we don't
know if a platform wants to keep CPU 1 in AMP mode to run some
special software on it.

> Whether this is worth, I don't know.

I don't think it's worth it because I think trying to considate this
is going to cripple the code structure in the future.

What we currently have is a nice sane separation of the core SMP
support from the platform specific parts of the SMP support.

BTW, is it worth making sure that the IC and SCU standby mode bits
are set for A9 MPCore ?
