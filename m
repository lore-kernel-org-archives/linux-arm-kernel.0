From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 25 Jan 2015 19:22:04 -0800
Subject: [PATCH] clk: zynq: Force CPU_2X clock to be ungated
In-Reply-To: <1422056653-11271-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1422056653-11271-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <3b7e448a3a9c4d8a8f566ef01160ba89@BY2FFO11FD041.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-01-23 at 03:44PM -0800, Soren Brinkmann wrote:
> The CPU_2X clock does not have a classical in kernel user, but is,
> amongst other things, required for OCM and debug access. Make sure this
> clock does not mistakenly disabled during boot up by enabling it in the
> platforms clock driver.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> I just noticed this on Linus' latest tip. I can't remember having had issues
> connecting the debugger before, but it might be a candidate for stable in case
> people report something like that.

I bisected this down to commit:

ae43b3289186480f81c78bb63d788a85a3631f47 is the first bad commit
commit ae43b3289186480f81c78bb63d788a85a3631f47
Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date:   Fri Nov 14 09:48:57 2014 +0100

    ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12
    
    This patch adds runtime PM support to pl330 DMA engine driver.
    
    The runtime power management for pl330 DMA driver allows gating of AMBA
    clock (PDMA) in FSYS clock domain, when the device is not processing any
    requests. This is necessary to enter low power modes on Exynos SoCs
    (e.g. LPA on Exynos4x12 or W-AFTR on Exynos3250).
    
    Runtime PM resuming of the device may happen in atomic context (during
    call device_issue_pending()) so pm_runtime_irq_safe() is used. This will
    lead only to disabling/enabling of the clock but this is sufficient for
    gating the clock and for reducing energy usage.
    
    Driver uses runtime PM callbacks from amba/bus.c driver only.
    
    Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
    Acked-by: Vinod Koul <vinod.koul@intel.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

:040000 040000 16e0cb02587254ea396e9d913d7997ac63bd3d49 97c1ee366f0790e65df00e85d06b2bcd07aa9f58 M      drivers

which makes sense, since the PL330 clock in Zynq is the mentioned
CPU_2X_CLK. I guess the additional runtime_pm in the driver causes the
clock to be gated which causes the issues for the mentioned other users
of this clock.
Looks like this patch got introduced in the 3.19 merge window. Hence,
stable should be off the table.

	S?ren
