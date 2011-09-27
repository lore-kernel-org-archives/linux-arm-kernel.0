From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 Sep 2011 18:20:39 +0800
Subject: [PATCH v2 00/16] Switch GIC users (and omap2plus) to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110927102039.GC17997@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 12:02:19PM +0100, Marc Zyngier wrote:
> In order to support multiple primary interrupt controllers in the same
> image, it is necessary to use the MULTI_IRQ_HANDLER config option.
> 
> This patch series makes a first step in that direction by:
> - having the GIC code to provides a global handler,
> - make GIC users to provide this handler from their machine descriptor.
> 
> A side effect of this is that it forces OMAP2/3 platforms to be
> converted too in order to preserve the MULTI_OMAP feature. This leads
> to a certain simplification of the interrupt handling for the
> OMAP2/3/4 platforms.
> 
> The primary IRQ handlers have been written in C, and the performance
> degradation is hardly noticeable. Should some tests reveal a major
> increase in latency, it is always possible to restore the ASM version.
> 
> This series has been tested on VE (A9, A5, A15), PB11MP, Panda, IGEPv2
> and Harmony. Patches against next-20110926 plus my PPI series.
> 
> From v1:
> - Add forgotten patch to make global handler and MULTI_IRQ_HANDLER
>   mutually exclusive.
> - Introduce handle_IPI(), which is similar to do_IP() and callable
>   from C code.
> 
> Marc Zyngier (16):
>   ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually
>     exclusive
>   ARM: smp: Add an IPI handler callable from C code
>   ARM: GIC: Add global gic_handle_irq() function
>   ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
>   ARM: GIC: Add global gic_handle_irq_offset() function
>   ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: shmobile: convert smp platforms to gic_handle_irq()
>   ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
>   ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
>   ARM: GIC: Make MULTI_IRQ_HANDLER mandatory
> 
On imx6q:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
