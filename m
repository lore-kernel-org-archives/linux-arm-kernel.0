From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Nov 2016 15:25:46 +0000
Subject: [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for system suspend
In-Reply-To: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161103152545.GB25852@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:29:22PM +0100, Neil Armstrong wrote:
> Thie patchset is a very experiment patchset to support the System Suspend
> feature of the Amlogic Meson GX SoCs.
> 
> These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
> parameter to enter system suspend.

This sounds like a violation of the CPU_SUSPEND semantics.

> A small driver is added to properly fill the platform_suspend_ops and make
> to correct SMC call.

Ignoring the fact that this is a blatant violation of the PSCI CPU_SUSPEND
semantics, this certainly should not be a separate driver.

> In order to wake up from an alarm, these SoCs have a special memory mapped
> register where an alarm time delay in seconds is stored.
> In order to reuse the RTC wakealarm feature, implement a fake RTC device
> that uses the system time to calculate a delay to write to the register.
> 
> Note that this RFC is here to seek a better way to handle these platform
> specific features.
> 
> Neil Armstrong (3):
>   ARM64: meson: Add Amlogic Meson GX PM Suspend
>   rtc: Add Amlogic Virtual Wake RTC
>   ARM64: dts: meson-gxbb: Add support for PM and Virtual RTC
> 
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   9 ++
>  drivers/firmware/meson/Kconfig              |   6 +
>  drivers/firmware/meson/Makefile             |   1 +
>  drivers/firmware/meson/meson_gx_pm.c        |  86 +++++++++++++++
>  drivers/rtc/Kconfig                         |  10 ++
>  drivers/rtc/Makefile                        |   1 +
>  drivers/rtc/rtc-meson-vrtc.c                | 164 ++++++++++++++++++++++++++++
>  7 files changed, 277 insertions(+)
>  create mode 100644 drivers/firmware/meson/meson_gx_pm.c
>  create mode 100644 drivers/rtc/rtc-meson-vrtc.c
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
