From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 09 Dec 2014 13:38:09 +0100
Subject: [PATCH] arm64: psci: Fix build breakage without PM_SLEEP
In-Reply-To: <2290734.BRljGaICu4@wuerfel>
References: <1418125716-18528-1-git-send-email-k.kozlowski@samsung.com>
 <2290734.BRljGaICu4@wuerfel>
Message-ID: <1418128689.19339.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-12-09 at 13:29 +0100, Arnd Bergmann wrote:
> On Tuesday 09 December 2014 12:48:36 Krzysztof Kozlowski wrote:
> > Fix build failure of defconfig when PM_SLEEP is disabled (e.g. by
> > disabling SUSPEND) and CPU_IDLE enabled:
> > 
> > arch/arm64/kernel/psci.c:543:2: error: unknown field ?cpu_suspend? specified in initializer
> >   .cpu_suspend = cpu_psci_cpu_suspend,
> >   ^
> > arch/arm64/kernel/psci.c:543:2: warning: initialization from incompatible pointer type [enabled by default]
> > arch/arm64/kernel/psci.c:543:2: warning: (near initialization for ?cpu_psci_ops.cpu_prepare?) [enabled by default]
> > make[1]: *** [arch/arm64/kernel/psci.o] Error 1
> > 
> > The cpu_operations.cpu_suspend field exists only if ARM64_CPU_SUSPEND is
> > defined, not CPU_IDLE.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > 
> 
> No objection to fixing this obvious build bug, but why do we even have
> an ARM64_CPU_SUSPEND option? On ARM32 we only have the respective option
> because we have a random collection of platform specific drivers that
> use the symbols, but that's not the case on ARM64.

I believe because of cpuidle. It's the same as on ARM32: the cpu_suspend
is used by both PM_SLEEP and CPU_IDLE.

Best regards,
Krzysztof
