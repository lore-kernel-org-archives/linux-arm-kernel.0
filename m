From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Apr 2017 19:03:07 +0100
Subject: [PATCH] arm64: arch_timer: mark errata handlers as __maybe_unused
In-Reply-To: <20170419173737.3846098-1-arnd@arndb.de>
References: <20170419173737.3846098-1-arnd@arndb.de>
Message-ID: <0ed3eee7-1bac-92a1-1e54-08ecd69c032b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/17 18:37, Arnd Bergmann wrote:
> In some rare randconfig builds, we end up with two functions being entirely
> unused:
> 
> drivers/clocksource/arm_arch_timer.c:342:12: error: 'erratum_set_next_event_tval_phys' defined but not used [-Werror=unused-function]
>  static int erratum_set_next_event_tval_phys(unsigned long evt,
> drivers/clocksource/arm_arch_timer.c:335:12: error: 'erratum_set_next_event_tval_virt' defined but not used [-Werror=unused-function]
>  static int erratum_set_next_event_tval_virt(unsigned long evt,
> 
> We could add an #ifdef around them, but we would already have to check for
> several symbols there and there is a chance this would get more complicated
> over time, so marking them as __maybe_unused is the simplest way to avoid the
> harmless warnings.
> 
> Fixes: 01d3e3ff2608 ("arm64: arch_timer: Rework the set_next_event workarounds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ah, well spotted. You need CONFIG_ARM64_ERRATUM_858921, but none of
CONFIG_HISILICON_ERRATUM_161010101 or CONFIG_FSL_ERRATUM_A008585.
Dreadful stuff.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
