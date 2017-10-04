From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Oct 2017 12:36:29 +0100
Subject: [PATCH] arm64: Enable MRS emulation early
In-Reply-To: <20171004113207.GT3611@e103592.cambridge.arm.com>
References: <20171004094805.24009-1-suzuki.poulose@arm.com>
 <20171004101425.GB23092@leverpostej>
 <20171004111040.vumbc3bk7sj2enc6@armageddon.cambridge.arm.com>
 <20171004113207.GT3611@e103592.cambridge.arm.com>
Message-ID: <20171004113628.t4gv7srwpvbwwbsl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 12:32:07PM +0100, Dave P Martin wrote:
> On Wed, Oct 04, 2017 at 12:10:40PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 04, 2017 at 11:14:26AM +0100, Mark Rutland wrote:
> > > On Wed, Oct 04, 2017 at 10:48:05AM +0100, Suzuki K Poulose wrote:
> > > > Make sure the MRS emulation is enabled early enough, such that the
> > > > early userspace applications (e.g, those run from initrd) could
> > > > use the facility without crashing them.
> > > > 
> > > > Fixes: commit 77c97b4ee2129 ("arm64: cpufeature: Expose CPUID registers by emulation")
> > > > Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> > > > Cc: James Morse <james.morse@arm.com>
> > > > Cc: Dave Martin <Dave.martin@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: stable at vger.kernel.org
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > This looks sensible, but shouldn't we do the same for other
> > > late_inicalls can affect initrd userspace?
> > > 
> > > e.g. armv8_deprecated_init, fpsimd_init, sys_reg_genericv8_init?
> > 
> > I think we should, though not all of them are concerned with the user
> > code. For example, fpsimd_init() takes care of the pm/hotplug aspect and
> > nothing to do with user space. That said, making it core_initcall() is
> > probably not a bad thing (just a statement that it is concerned with the
> > core initialisation), as long as all the other infrastructure it
> > registers with is up.
> > 
> > For Suzuki's patch, I was thinking of enabling emulation before we
> > register the HWCAP_CPUID bit (setup_elf_hwcaps). However, that means we
> > have to bring it before smp_cpus_done(). It's not really worth it as we
> > don't expect any user space at that point.
> 
> I don't think the hwcaps shouldn't change after entry to userspace,
> so it really doesn't matter whether HWCAP_CPUID is set before or
> after registration: for userspace it should all already have happened.

Good point, I forgot about this.

> It looks to me like all initcalls are called in the same kernel thread
> that execs the initramfs init process, before the exec.
> 
> So I still don't see how a built-in late initcall can not have been
> called before entry to userspace.
> 
> The patch seems to demonstrate that I'm wrong though.
> What am I missing?

I also wondered about this. I think is the kernel invoking modprobe
before the actual init/linuxrc in an initrd.

-- 
Catalin
