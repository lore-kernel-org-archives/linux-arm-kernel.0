From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 18 Jul 2013 09:21:06 +0200
Subject: [PATCH 3/3] arm: zynq: slcr: Use read-modify-write for
 register writes
In-Reply-To: <1374081015-31431-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
 <1374081015-31431-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20130718072106.GB15514@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:10:15AM -0700, S?ren Brinkmann wrote:
> zynq_slcr_cpu_start/stop() ignored the current register state when
> writing to a register. Fixing this by implementing proper
> read-modify-write.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/mach-zynq/slcr.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index 44a4ab6..1836d5a 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -61,11 +61,11 @@ void zynq_slcr_system_reset(void)
>   */
>  void zynq_slcr_cpu_start(int cpu)
>  {
> -	/* enable CPUn */
> -	writel(SLCR_A9_CPU_CLKSTOP << cpu,
> -	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> -	/* enable CLK for CPUn */
> -	writel(0x0 << cpu, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> +	u32 reg = readl(zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> +	reg &= ~(SLCR_A9_CPU_RST << cpu);
> +	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> +	reg &= ~(SLCR_A9_CPU_CLKSTOP << cpu);
> +	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
>  }
>  
>  /**
> @@ -74,9 +74,9 @@ void zynq_slcr_cpu_start(int cpu)
>   */
>  void zynq_slcr_cpu_stop(int cpu)
>  {
> -	/* stop CLK and reset CPUn */
> -	writel((SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu,
> -	       zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> +	u32 reg = readl(zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
> +	reg |= (SLCR_A9_CPU_CLKSTOP | SLCR_A9_CPU_RST) << cpu;
> +	writel(reg, zynq_slcr_base + SLCR_A9_CPU_RST_CTRL_OFFSET);
>  }
>  

Hi!

Why do you also remove the comments? In my opinion they can stay.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
