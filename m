From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Apr 2016 08:22:48 -0500
Subject: [RFC PATCH 1/2] ARM/ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1460341353-15619-2-git-send-email-oss@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-2-git-send-email-oss@buserror.net>
Message-ID: <CAL_JsqKh=WPZjc_UkicCpdEOnR5Tz2AhzOSXdYTBLRG2HPGb8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2016 at 9:22 PM, Scott Wood <oss@buserror.net> wrote:
> Erratum A-008585 says that the ARM generic timer "has the potential to
> contain an erroneous value for a small number of core clock cycles
> every time the timer value changes" and that the workaround is to
> reread TVAL and count registers until successive reads return the same
> value.
>
> This erratum can be found on LS1021A (32-bit), LS1043A (64-bit), and
> LS2080A (64-bit).
>
> This patch is loosely based on work by Priyanka Jain and Bhupesh
> Sharma.
>
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  .../devicetree/bindings/arm/arch_timer.txt         |  4 ++
>  arch/arm/boot/dts/ls1021a.dtsi                     |  1 +
>  arch/arm/include/asm/arch_timer.h                  | 71 +++++++++++++++++++---
>  arch/arm/include/asm/vdso_datapage.h               |  1 +
>  arch/arm/kernel/vdso.c                             |  1 +
>  arch/arm/vdso/vgettimeofday.c                      |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  1 +
>  arch/arm64/include/asm/arch_timer.h                | 35 ++++++++---
>  arch/arm64/include/asm/vdso_datapage.h             |  1 +
>  arch/arm64/kernel/asm-offsets.c                    |  1 +
>  arch/arm64/kernel/vdso.c                           |  2 +
>  arch/arm64/kernel/vdso/gettimeofday.S              | 14 ++++-
>  drivers/clocksource/arm_arch_timer.c               |  5 ++
>  14 files changed, 121 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> index e774128..7117fbd 100644
> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> @@ -25,6 +25,10 @@ to deliver its interrupts via SPIs.
>  - always-on : a boolean property. If present, the timer is powered through an
>    always-on power domain, therefore it never loses context.
>
> +- fsl,erratum-a008585 : A boolean property. Indicates the presence of
> +  QorIQ erratum A-008585, which says reading the timer is unreliable
> +  unless the same value is returned by back-to-back reads.

Bindings need to go to the DT list.

An excellent example of how not having specific compatible strings
will bite you latter.

Rob
