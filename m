From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 11 May 2018 10:24:48 +0100
Subject: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <20180511022751.9096-1-samuel@sholland.org>
References: <20180511022751.9096-1-samuel@sholland.org>
Message-ID: <9d12075e-745d-b7d7-9847-f1493fc8647e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/05/18 03:27, Samuel Holland wrote:
> Hello,
> 
> Several people (including me) have experienced extremely large system
> clock jumps on their A64-based devices, apparently due to the
> architectural timer going backward, which is interpreted by Linux as
> the timer wrapping around after 2^56 cycles.

So I experienced this before, though I didn't see actual clock jumps,
only that subsequent reads of CNTVCT_EL0, both directly via mrs and
indirectly via CLOCK_MONOTONIC, from userland (triggered by a directed
test) *sometimes* went backwards, with a number of '1's in the lower bits.
But that didn't happen on every boot, and I was suspecting that some
timer setup was missing on the hardware/firmware side. And later on I
failed to reproduce it anymore.
So do you see it on every boot, with recent U-Boot/ATF?

Cheers,
Andre.

> Investigation led to discovery of some obvious problems with this SoC's
> architectural timer, and this patch series introduces what I believe is
> the simplest workaround. More details are in the commit message for
> patch 1. Patch 2 simply enables the workaround in the device tree.
> 
> Thanks,
> Samuel
> 
> Samuel Holland (2):
>   arm64: arch_timer: Workaround for Allwinner A64 timer instability
>   arm64: dts: allwinner: a64: Enable A64 timer workaround
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
>  drivers/clocksource/Kconfig                   | 11 ++++++++
>  drivers/clocksource/arm_arch_timer.c          | 39 +++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> --
> 2.16.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
