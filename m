From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 12:33:51 +0100
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
In-Reply-To: <20141106105246.GO4042@n2100.arm.linux.org.uk>
References: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
 <20141104063235.GG13562@quad.lixom.net>
 <20141106105246.GO4042@n2100.arm.linux.org.uk>
Message-ID: <7467543.qEZBkbRV4B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 10:52:47 Russell King - ARM Linux wrote:
> Unfortunately, this totally screws multiplatform support - with this
> merged, we now can enable all CPUs from ARM720T upwards into a single
> kernel - and that is illegal.
> 
> The problem is that Integrator can be ARM720T all the way up to ARMv6.
> So, when ARCH_INTEGRATOR is enabled, you are presented with the
> individual CPUs which the platform supports as options to select.
> This results in randconfig seeing all the CPU options, which it can
> then enable, resulting in:
> 
> CONFIG_CPU_ARM720T=y
> CONFIG_CPU_ARM920T=y
> CONFIG_CPU_ARM922T=y
> CONFIG_CPU_ARM926T=y
> CONFIG_CPU_ARM1020=y
> CONFIG_CPU_ARM1022=y
> CONFIG_CPU_ARM1026=y
> CONFIG_CPU_V6=y
> CONFIG_CPU_V6K=y
> CONFIG_CPU_V7=y
> 
> which then causes:
> 
> arch/arm/include/asm/cmpxchg.h:114:2: error: #error "SMP is not supported on this platform"
> arch/arm/include/asm/atomic.h:137:2: error: #error SMP not supported on pre-ARMv6 CPUs
> 
> Integrator doesn't fit into the "is it a pre-ARMv6 or not" platform
> structure chosen in the early days of multiplatform support, because
> it straddles that boundary.

I've thought about this issue before but hadn't realized that the patches
as they went into arm-soc already cause the problem.

I think it would be best to replace all the lines like

	bool "Support ARM926T processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB

with

	bool "Support ARM926T processor" if ARCH_MULTI_V5 || MACH_REALVIEW_EB

and ignore whether ARCH_INTEGRATOR is set or not. Since we have the
generic default platform for multiplatform kernels now, in theory you
could always have any other CPU enabled without even needing an
ARCH_* symbol, as long as the drivers are all present.

	Arnd
