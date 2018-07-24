From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 21:41:42 +0200
Subject: [RFT v2 06/10] pinctrl: samsung: Write external wakeup interrupt
 mask
In-Reply-To: <20180723175302.22535-7-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-7-krzk@kernel.org>
Message-ID: <20180724194142.22nav7lfpouzd57o@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 07:52:58PM +0200, Krzysztof Kozlowski wrote:
> The pinctrl driver defines an IRQ chip which handles external wakeup
> interrupts, therefore from logical point of view, it is the owner of
> external interrupt mask.  The register controlling the mask belongs to
> Power Management Unit address space so it has to be accessed with PMU
> syscon regmap handle.
> 
> This mask should be written to hardware during system suspend.  Till now
> ARMv7 machine code was responsible for this which created a dependency
> between pin controller driver and arch/arm/mach code.
> 
> Try to rework this dependency so the pinctrl driver will write external
> wakeup interrupt mask during late suspend.
> 
> Impact on ARMv7 designs (S5Pv210 and Exynos)
> ============================================
> This duplicates setting mask with existing machine code
> arch/arm/mach-exynos/suspend.c and arch/arm/mach-s5pv210/pm.c but it is
> not a problem - the wakeup mask register will be written twice.  The
> machine code will be cleaned up later.
> 
> The difference between implementation here and ARMv7 machine code
> (arch/arm/mach-*) is the time of writing the mask:
> 1. The machine code is writing the mask quite late during system suspend
>    path, after offlining secondary CPUs and just before doing actual
>    suspend.
> 2. The implementation in pinctrl driver uses late suspend ops, therefore it
>    will write the mask much earlier.  Hopefully late enough, after all
>    drivers will enable or disable its interrupt wakeup
>    (enable_irq_wake() etc).
> 
> Impact on ARMv8 designs (Exynos5433 and Exynos7)
> ================================================
> The Suspend to RAM was not supported and external wakeup interrupt mask
> was not written to HW.  This change brings us one step closer to
> supporting Suspend to RAM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c    | 50 ++++++++++++++++++++++++++++-
>  drivers/pinctrl/samsung/pinctrl-samsung.h   |  3 ++
>  include/linux/soc/samsung/exynos-regs-pmu.h |  2 ++
>  3 files changed, 54 insertions(+), 1 deletion(-)

Thanks, applied all previous, up to this one.

Best regards,
Krzysztof
