From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Oct 2017 12:32:12 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
 <20171004101425.GB23092@leverpostej>
 <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
Message-ID: <20171004113212.GC23092@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 12:10:40PM +0100, Catalin Marinas wrote:
> On Wed, Oct 04, 2017 at 11:14:26AM +0100, Mark Rutland wrote:
> > On Wed, Oct 04, 2017 at 10:48:05AM +0100, Suzuki K Poulose wrote:
> > > Make sure the MRS emulation is enabled early enough, such that the
> > > early userspace applications (e.g, those run from initrd) could
> > > use the facility without crashing them.
> > > 
> > > Fixes: commit 77c97b4ee2129 ("arm64: cpufeature: Expose CPUID registers by emulation")
> > > Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: Dave Martin <Dave.martin@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: stable at vger.kernel.org
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > This looks sensible, but shouldn't we do the same for other
> > late_inicalls can affect initrd userspace?
> > 
> > e.g. armv8_deprecated_init, fpsimd_init, sys_reg_genericv8_init?
> 
> I think we should, though not all of them are concerned with the user
> code. For example, fpsimd_init() takes care of the pm/hotplug aspect and
> nothing to do with user space.

My worry was that without the pm/hotplug notifiers, things could go
wrong during the initrd. e.g. we could lose userspace fp state without
the pm notifier, or userspace could trigger hotplpug that we wouldn't
manage correctly

So even if it's not directly userspace related, it can affect (or can be
affected by) initrd userspace.

> That said, making it core_initcall() is probably not a bad thing (just
> a statement that it is concerned with the core initialisation), as
> long as all the other infrastructure it registers with is up.

Sure.

> For Suzuki's patch, I was thinking of enabling emulation before we
> register the HWCAP_CPUID bit (setup_elf_hwcaps). However, that means we
> have to bring it before smp_cpus_done(). It's not really worth it as we
> don't expect any user space at that point.

I think so long as we bring it up before *any* userspace can run, it
doesn't matter if we set the hwcaps earlier.

Thanks,
Mark.
