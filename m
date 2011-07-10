From: will.deacon@arm.com (Will Deacon)
Date: Sun, 10 Jul 2011 12:00:24 +0100
Subject: [PATCH 01/17] ARM: proc: add definition of cpu_reset for ARMv6
	and ARMv7 cores
In-Reply-To: <20110709101445.GH4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709101445.GH4812@n2100.arm.linux.org.uk>
Message-ID: <20110710110023.GA14312@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Jul 09, 2011 at 11:14:45AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 04:50:14PM +0100, Lorenzo Pieralisi wrote:
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > This patch adds simple definitions of cpu_reset for ARMv6 and ARMv7
> > cores, which disable the MMU via the SCTLR.
> 
> This really needs fixing properly, so that we have this well defined
> across all supported ARM cores.  Requiring ARMv6 and ARMv7 to have this
> code called with a flat mapping (which may overlap a section boundary)
> vs ARMv5 and lower code which doesn't is just silly.
> 
> With any API, we need consistency.  So if ARMv6 and v7 require a flat
> mapping, we need to ensure that ARMv5 and lower is happy to deal with
> that code being also called with a flat mapping.

I've had a look at a bunch of the cpu_*_reset definitions and I can't see
any reason why they wouldn't be callable with the flat mapping in place. In
fact, there's a scary comment for xscale:

@ CAUTION: MMU turned off from this point. We count on the pipeline
@ already containing those two last instructions to survive.

which I think would disappear if the code was called via the ID map.

At the moment, the only caller [1] of these functions is arch_reset which is
called from arm_machine_restart after putting a flat mapping in place. The
extra work is actually to call the reset code via that mapping. I've been
working on this in my kexec series, which I'll continue with during 3.1.

Will

[1] plat-s3c24xx/cpu.c is an exception, but cpu_reset is only entered if the
    watchdog fails during hard reboot. The logic could be easily fixed up here
    so that arm_machine_restart is called instead.
