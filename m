From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 01 Jul 2013 17:15:01 -0700
Subject: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 28 Jun 2013 15:05:08 +0530")
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <871u7hom0q.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> is available to enable Alarm Wakeup feature. This register needs to be
> properly handled for the rtcwake to work properly.
>
> Platforms using such IP should set "ti,am3352-rtc" in rtc device dt
> compatibility node.
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-doc at vger.kernel.org

Acked-by: Kevin Hilman <khilman@linaro.org>

...with a minor nit below...

> ---
> :100644 100644 b47aa41... 5a0f02d... M	Documentation/devicetree/bindings/rtc/rtc-omap.txt
> :100644 100644 761919d... 666b0c2... M	drivers/rtc/rtc-omap.c
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    6 ++-
>  drivers/rtc/rtc-omap.c                             |   56 +++++++++++++++++---
>  2 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index b47aa41..5a0f02d 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -1,7 +1,11 @@
>  TI Real Time Clock
>  
>  Required properties:
> -- compatible: "ti,da830-rtc"
> +- compatible:
> +	- "ti,da830-rtc"  - for RTC IP used similar to that on DA8xx SoC family.
> +	- "ti,am3352-rtc" - for RTC IP used similar to that on AM335x SoC family.
> +			    This RTC IP has special WAKE-EN Register to enable
> +			    Wakeup generation for event Alarm.
>  - reg: Address range of rtc register set
>  - interrupts: rtc timer, alarm interrupts in order
>  - interrupt-parent: phandle for the interrupt controller
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 761919d..666b0c2 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -72,6 +72,8 @@
>  #define OMAP_RTC_KICK0_REG		0x6c
>  #define OMAP_RTC_KICK1_REG		0x70
>  
> +#define OMAP_RTC_IRQWAKEEN		0x7C
> +

nit: letters in hex numbers are usually lower-case.


Kevin
