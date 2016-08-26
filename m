From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 26 Aug 2016 12:11:55 -0500
Subject: [PATCH] drivers/perf: arm-pmu: Fix handling of SPI lacking
 "interrupt-affinity" property
In-Reply-To: <1468939142-23693-1-git-send-email-marc.zyngier@arm.com>
References: <1468939142-23693-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOi56cXFCZoMox3XrJvsQAXHa1uxOBPEKO266B2yYONv3pTY7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Jul 19, 2016 at 9:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Patch 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt
> affinity mask") added support for partitionned PPI setups, but
> inadvertently broke setups using SPIs without the "interrupt-affinity"
> property (which is the case for UP platforms).
>
> This patch restore the broken functionnality by testing whether the
> interrupt is percpu or not instead of relying on the using_spi flag
> that really means "SPI *and* interrupt-affinity property".
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 19a469a58720 ("drivers/perf: arm-pmu: Handle per-interrupt affinity mask")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

kernelci.org detected boot failures on bcm2835-rpi-b in mainline[1]
and was bisected down to this patch.  I verified that reverting this
patch on top of mainline gets bcm2835-rpi-b booting again.

I haven't been closely tracking this change, but a quick glance and it
looks like this platform is possibly missing IRQ properties from its
PMU node?  The DT for this platform simply has:

        arm-pmu {
            compatible = "arm,arm1176-pmu";
        };

Kevin

[1] https://kernelci.org/boot/id/57bb4d9259b514895348b564/
