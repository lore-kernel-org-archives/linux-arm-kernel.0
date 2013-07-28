From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Jul 2013 11:22:39 +0200
Subject: [PATCH] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for exynos5440
In-Reply-To: <51F4C3D1.2060901@linaro.org>
References: <0e7d01ce8840$82f79070$88e6b150$@org>
 <0eaf01ce8863$89d3c4e0$9d7b4ea0$@org> <51F4C3D1.2060901@linaro.org>
Message-ID: <1877730.qZVs3NAG5h@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 of July 2013 09:10:09 Daniel Lezcano wrote:
> On 07/24/2013 01:47 PM, Kukjin Kim wrote:
> > Amit Daniel Kachhap wrote:
> >> This patch skips the deep C1(AFTR -Arm off top running) state for
> >> exynos5440
> >> soc as this soc does not support this state. All the cpu's only
> >> allows the basic
> >> C0 state.
> >> 
> >> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >> ---
> >> 
> >>  arch/arm/mach-exynos/cpuidle.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> >> exynos/cpuidle.c
> >> index 17a18ff..9a776a1 100644
> >> --- a/arch/arm/mach-exynos/cpuidle.c
> >> +++ b/arch/arm/mach-exynos/cpuidle.c
> >> @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
> >> 
> >>  		device->cpu = cpu_id;
> >>  		
> >>  		/* Support IDLE only */
> >> 
> >> -		if (cpu_id != 0)
> >> +		if (soc_is_exynos5440() || cpu_id != 0)
> >> 
> >>  			device->state_count = 1;
> >>  		
> >>  		ret = cpuidle_register_device(device);
> >> 
> >> --
> >> 1.7.1
> > 
> > Applied, thanks.
> 
> You shouldn't have. This patch means exynos5540 has no cpuidle driver at
> all. It should be fixed in the Kconfig to unselect CONFIG_CPU_IDLE for
> an exynos5540.

To shed more light on this, let me add that you need to register a cpuidle 
driver only if you have more states than a simple WFI or you need some 
crazy steps to enter WFI. Default setup falls back to generic ARM WFI. 
(Daniel, do we get the nice idle stats as provided by cpuidle core then?)

Anyway, Exynos cpuidle is using an initcall to initialize and we support 
multiple Exynos SoCs in single zImage, so deselecting CONFIG_CPU_IDLE is 
not an option. Considering multiplatform requirements, the driver has to 
be modified to initialize only on supported platforms, either by:

 a) dropping the initcall and calling the init function directly from 
arch/arm/mach-exynos

 or

 b) checking if machine we are running on is supported, which would mean a 
long list of all Exynos SoCs that needs to be checked.

An evolution of option a) is registering a platform device somewhere in 
arch/arm/mach-exynos and making exynos-cpuidle a platform driver. The 
problem is that you must register a static platform device from arch code, 
because cpuidle is not a real hardware block that can be put into device 
tree.

Best regards,
Tomasz
