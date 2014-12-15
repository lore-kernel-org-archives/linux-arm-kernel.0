From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 15 Dec 2014 18:32:44 +0000
Subject: [PATCH] arm64: psci: Fix build breakage without PM_SLEEP
In-Reply-To: <20141215174622.GE14631@e104818-lin.cambridge.arm.com>
References: <1418125716-18528-1-git-send-email-k.kozlowski@samsung.com>
 <2290734.BRljGaICu4@wuerfel> <1418128689.19339.3.camel@AMDC1943>
 <20141209161511.GI31129@e104818-lin.cambridge.arm.com>
 <20141212150608.GA4853@e102568-lin.cambridge.arm.com>
 <20141215174622.GE14631@e104818-lin.cambridge.arm.com>
Message-ID: <20141215183244.GA721@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 05:46:22PM +0000, Catalin Marinas wrote:
> On Fri, Dec 12, 2014 at 03:06:08PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Dec 09, 2014 at 04:15:11PM +0000, Catalin Marinas wrote:
> > > On Tue, Dec 09, 2014 at 12:38:09PM +0000, Krzysztof Kozlowski wrote:
> > > > On wto, 2014-12-09 at 13:29 +0100, Arnd Bergmann wrote:
> > > > > On Tuesday 09 December 2014 12:48:36 Krzysztof Kozlowski wrote:
> > > > > > Fix build failure of defconfig when PM_SLEEP is disabled (e.g. by
> > > > > > disabling SUSPEND) and CPU_IDLE enabled:
> > > > > > 
> > > > > > arch/arm64/kernel/psci.c:543:2: error: unknown field 'cpu_suspend' specified in initializer
> > > > > >   .cpu_suspend = cpu_psci_cpu_suspend,
> > > > > >   ^
> > > > > > arch/arm64/kernel/psci.c:543:2: warning: initialization from incompatible pointer type [enabled by default]
> > > > > > arch/arm64/kernel/psci.c:543:2: warning: (near initialization for 'cpu_psci_ops.cpu_prepare') [enabled by default]
> > > > > > make[1]: *** [arch/arm64/kernel/psci.o] Error 1
> > > > > > 
> > > > > > The cpu_operations.cpu_suspend field exists only if ARM64_CPU_SUSPEND is
> > > > > > defined, not CPU_IDLE.
> > > > > > 
> > > > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > > > 
> > > > > 
> > > > > No objection to fixing this obvious build bug, but why do we even have
> > > > > an ARM64_CPU_SUSPEND option? On ARM32 we only have the respective option
> > > > > because we have a random collection of platform specific drivers that
> > > > > use the symbols, but that's not the case on ARM64.
> > > > 
> > > > I believe because of cpuidle. It's the same as on ARM32: the cpu_suspend
> > > > is used by both PM_SLEEP and CPU_IDLE.
> > > 
> > > I guess at some point we can replace (as a separate patch)
> > > ARM64_CPU_SUSPEND with PM_SLEEP.
> > > 
> > > But what I don't fully understand, we can enable CPU_IDLE without
> > > ARM64_CPU_SUSPEND. However, the cpuidle-arm64.c driver will fail to
> > > link since it calls cpu_suspend(). Wouldn't it be better if
> > > ARM64_CPU_SUSPEND depends on CPU_PM (or replaced by it) rather than
> > > PM_SLEEP?
> > 
> > I think that ARM64_CPU_SUSPEND should depend on PM_SLEEP || CPU_IDLE,
> 
> That's what we do with CPU_PM, we select it if SUSPEND || CPU_IDLE
> (PM_SLEEP is default yes if SUSPEND).
> 
> > if CPU_IDLE is enabled it is certainly because some idle states are
> > expected to be present, true, not all of them lose context (which is
> > why ARM64_CPU_SUSPEND is needed, to save/restore context and clean
> > it to RAM), but I think that's too fine grain, making it depend on
> > CPU_IDLE should be ok.
> > 
> > Having CPU_IDLE enabled without arm64 cpuidle driver enabled (which
> > selects ARM64_CPU_SUSPEND) is useless at the moment.
> 
> Ah, so we can force a selection even if it doesn't meet its
> dependencies like PM_SLEEP (which depends on SUSPEND).
> 
> Can we just get rid of ARM64_CPU_SUSPEND altogether and use CPU_PM
> instead?

Yes, it looks like the best option to me, I will put together a
patch shortly.

Thanks,
Lorenzo
