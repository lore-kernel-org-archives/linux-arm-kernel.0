From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Nov 2014 15:57:37 +0000
Subject: [PATCH v1] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <2837195.5EVM7cu8cA@wuerfel>
References: <1416652956-24207-1-git-send-email-js07.lee@gmail.com>
 <20141124150652.GF15872@e104818-lin.cambridge.arm.com>
 <2837195.5EVM7cu8cA@wuerfel>
Message-ID: <20141124155737.GG15872@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 03:26:10PM +0000, Arnd Bergmann wrote:
> On Monday 24 November 2014 15:06:53 Catalin Marinas wrote:
> > On Sat, Nov 22, 2014 at 10:42:36AM +0000, Jungseung Lee wrote:
> > > diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> 
> > In general we put the #ifdef outside the function:
> > 
> > #if __LINUX_ARM_ARCH__ >= 7 && !defined(CONFIG_ARM_LPAE)
> > static inline bool cpu_has_classic_pxn(void)
> > {
> > 	unsigned int vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> > 	return vmsa == 4;
> > }
> > #else
> > static inline bool cpu_has_classic_pxn(void)
> > {
> > 	return false;
> > }
> > #endif
> > 
> > I used __LINUX_ARM_ARCH__ instead of CONFIG_CPU_V7 to cope with kernel
> > images built for both v6 and v7. You could also check for
> > cpu_architecture() >= 7, though with a bit of performance impact.
> 
> Regarding the style, I think the best way to express it is
> 
> 	if (__LINUX_ARM_ARCH__ >= 7 && !IS_ENABLED(CONFIG_ARM_LPAE) && (vmsa == 4))
> 		return true;
> 	return false;

We want to avoid read_cpuid_ext() if pre-v7. But something along these
lines would work.

> This way you can avoid the #ifdef and still get the compile-time
> optimization.
> 
> Checking for (__LINUX_ARM_ARCH__ >= 6 && cpu_architecture >= 7) would
> also make it work for a combined armv6/v7 kernel.

Yes.

-- 
Catalin
