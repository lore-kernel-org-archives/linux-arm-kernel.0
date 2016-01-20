From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 21:31:16 +0100
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <569FE8A9.4080700@openwrt.org>
References: <569D71F3.7000408@openwrt.org>
 <20160120195722.GU19062@n2100.arm.linux.org.uk>
 <569FE8A9.4080700@openwrt.org>
Message-ID: <1504723.MNMEXN8hkX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 January 2016 21:06:01 Felix Fietkau wrote:
> > 
> > config CPU_SW_DOMAIN_PAN
> >       bool "Enable use of CPU domains to implement privileged no-access"
> >       depends on MMU && !ARM_LPAE
> >       default y
> >       help
> >         Increase kernel security by ensuring that normal kernel accesses
> >         are unable to access userspace addresses.  This can help prevent
> >         use-after-free bugs becoming an exploitable privilege escalation
> >         by ensuring that magic values (such as LIST_POISON) will always
> >         fault when dereferenced.
> > 
> >         Note: This option is incompatible with ARM11 MPcore and must not
> >         be used with kernels which are to run on this CPU, whether in SMP
> >         or UP mode.
> > 
> >         CPUs with low-vector mappings use a best-efforts implementation.
> >         Their lower 1MB needs to remain accessible for the vectors, but
> >         the remainder of userspace will become appropriately inaccessible.
> > 
> > Unfortunately, that's still going to lead to people hitting this, and
> > possibly wasting a long time debugging it needlessly - but I don't
> > have any better solution for this.
>
> We should at least add a dependency to disable this when support for a
> known ARM11 MPCore platform is selected. Maybe add a CPU_MPCORE bool for
> this.

Just depending on (!ARCH_CNS3XXX && !REALVIEW_EB_ARM11MP &&
!MACH_REALVIEW_PB11MP) would be sufficient technically, but adding a
CPU_ARM11MPCORE seems a little nicer.

The downside is that it departs from the the idea that starting with
ARMv6 we only have configuration symbols for the architecture level
(CPU_V6, CPU_V7), but we also have a CPU_PJ4 symbol that breaks this
rule.

If we add the CPU_ARM11MPCORE symbol, we may also want to update
CONFIG_SMP to depend on (CPU_ARM11MPCORE || CPU_V7) instead of CPU_V6K,
and we can force-enable SMP_ON_UP whenever (CPU_V6 && !CPU_ARM11MPCORE)

	Arnd
