From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Jul 2018 11:37:49 +0900
Subject: [RFT 00/10] pinctrl: samsung: Remove ugly hack for sharing
 eint_wakeup_mask
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <CA+Ln22HdeSTqZSfh18rewK_w-q7Xhx6r_5djkuAkbXV=pT8rgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

2018?7?20?(?) 1:01 Krzysztof Kozlowski <krzk@kernel.org>:
>
> Hi All,
>
> Tests
> =====
> This is both request for comments and requests for tests. Only basic
> tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
> with max7768 RTC wakeup. Please kindly test it with devices capable of
> suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
> Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
> broken however changing external interrupt wakeup mask was not done
> on Exynos5433.
>
>
> Description
> ===========
> The Exynos/S5Pv210 machine suspend code needs to write the external
> interrupt mask during suspend.  The mask is controlled by pin controller
> driver: the exynos_wkup_irq_set_wake() in IRQ chip for these wakeup
> interrupts.
>
> Therefore pinctrl driver code exposed an exynos_get_eint_wake_mask()
> function which was later used as an extern in machine code.
>
> This is quite ugly way of combining driver and machine code,
> not portable triggering Sparse and GCC warnings.
>
>
> This might break suspend capability S5Pv210 on with older DTBs (thus
> breaks DTB compatibility), however:
> 1. just "might" because in case of using older DTB, the wakeup mask
>    will not be changed during suspend and default reset value (all
>    interrupts non-masked) should work,
> 2. mainline support for S5Pv210 with DTB is limited and suspend
>    to RAM already might be broken.

We probably should also add that it's highly unlikely that anyone
using S5PV210 actually uses a standalone DTB, since those systems
normally predated DT support in bootloaders and workarounds such as
chainloading or appended DTB are normally used.

>
>
> Dependencies
> ============
> 1. The first seven patches should be taken through one tree,
>    preferably samsung-pinctrl,
> 2. The DTS patch (7/10) for S5Pv210 should go into next cycle,
> 3. The remaining patches (8-10) should go after all previous,
>    so probably another release cycle.
>
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (10):
>   pinctrl: samsung: Define suspend and resume callbacks for all banks
>     and SoCs
>   pinctrl: samsung: Document suspend and resume members
>   pinctrl: samsung: Document hidden requirement about one external
>     wakeup
>   pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup
>     interrupts
>   ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and
>     Exynos5433
>   pinctrl: samsung: Write external interrupt mask
>   ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup
>     compatible
>   ARM: s5pv210: Remove legacy setting of external wakeup interrupts
>   ARM: exynos: Remove legacy setting of external wakeup interrupts
>   pinctrl: samsung: Remove legacy API for handling external wakeup
>     interrupts mask
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           | 11 ++-
>  arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
>  arch/arm/mach-exynos/common.h                      |  2 -
>  arch/arm/mach-exynos/suspend.c                     | 16 +++--
>  arch/arm/mach-s5pv210/common.h                     |  1 -
>  arch/arm/mach-s5pv210/pm.c                         | 16 +++--
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 78 +++++++++++++++++++---
>  drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 +++
>  include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
>  10 files changed, 136 insertions(+), 25 deletions(-)

Looking through the series, the idea seems to be very reasonable, so:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks for cleaning this up!

Best regards,
Tomasz
