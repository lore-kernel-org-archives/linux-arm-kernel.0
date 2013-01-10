From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jan 2013 10:16:44 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <50EE3ADA.2070100@gmail.com>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <20130109204804.GS3931@n2100.arm.linux.org.uk> <50EE3ADA.2070100@gmail.com>
Message-ID: <201301101016.44708.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013, Rob Herring wrote:
> > 
> > What I actually suggested is that we should be aiming for the DT side
> > of things to get to the point where DT is just another single platform
> > as far as that code goes, and that DT should describe the hardware
> > sufficiently well that we don't have multiple machine_desc things to
> > select via DT - so a DT kernel would have exactly one machine_desc (or
> > maybe even zero! - with the linker script check conditional on !CONFIG_OF)
> > 
> > That then gets rid of the issue entirely.
> 
> I agree completely. I look at mach-highbank (and mach-virt) as what else
> needs to be done in terms of refactoring or moving to DT.

It's also what we are doing on arm64 from the start, where there is
no machine descriptor already. Any experience we make with arm64 will
also help us improve arm in the long run, I hope.

> That's certainly a long term goal, but what is the short term solution?

I'd certainly be happy with

* removing the intentional build error for ARCH_MULTIPLATFORM, but leaving
  it in for !ARCH_MULTIPLATFORM
* having mach-virt enabled by default on ARCH_MULTIPLATFORM, and only
  visible for EXPERT.
* making mach-virt compatible with all CPUs starting with ARM7.

That would make allnoconfig, allyesconfig and allmodconfig work (besides
all the other bugs) on qemu at least, avoid build errors with randconfig
and make it hard enough to build a kernel that doesn't run on anything.

	Arnd
