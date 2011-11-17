From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 17 Nov 2011 10:22:28 +0530
Subject: [PATCH v3] ARM: gic: allow GIC to support non-banked setups
In-Reply-To: <1321359452-22821-1-git-send-email-marc.zyngier@arm.com>
References: <1321359452-22821-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAJuYYwReJq8M+Q-K8hNo4zLJ_JDhnQjw2tbbj4ELc=oJ4vrnSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2011 17:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The GIC support code is heavily using the fact that hardware
> implementations are exposing banked registers. Unfortunately, it
> looks like at least one GIC implementation (EXYNOS) offers both
> the distributor and the CPU interfaces at different addresses,
> depending on the CPU.
>
> This problem is solved by allowing the distributor and CPU interface
> addresses to be per-cpu variables for the platforms that require it.
> The EXYNOS code is updated not to mess with the GIC internals while
> handling interrupts, and struct gic_chip_data is back to being private.
> The DT binding for the gic is updated to allow an optional "cpu-offset"
> value, which is used to compute the various base addresses.
>
> Finally, a new config option (GIC_NON_BANKED) is used to control this
> feature, so the overhead is only present on kernels compiled with
> support for EXYNOS.
>
> Tested on Origen (EXYNOS4) and Panda (OMAP4).
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> This is a minor update on the previous version, simply adding a
> config option so that normal platforms don't have to pay the
> price of the get_base() indirection.
>
> Any comment is welcome, specially on the DT binding update.
>
> ?Documentation/devicetree/bindings/arm/gic.txt | ? ?4 +
> ?arch/arm/common/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?3 +
> ?arch/arm/common/gic.c ? ? ? ? ? ? ? ? ? ? ? ? | ?133 +++++++++++++++++++++----
> ?arch/arm/include/asm/hardware/gic.h ? ? ? ? ? | ? 24 ++---
> ?arch/arm/mach-exynos/cpu.c ? ? ? ? ? ? ? ? ? ?| ? 16 +---
> ?arch/arm/mach-exynos/platsmp.c ? ? ? ? ? ? ? ?| ? 28 +-----
> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?7 files changed, 132 insertions(+), 77 deletions(-)
>

Tested on Exynos4210 based Origen board with 'cpu-offset = <0x8000>'
property in GIC device node and device tree enabled kernel. Thanks for
this patch.

Tested-by: Thomas Abraham <thomas.abraham@linaro.org>
