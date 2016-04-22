From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 22 Apr 2016 15:11:43 +0200
Subject: [PATCH 03/11] clk: tegra: Add DFLL DVCO reset control for Tegra210
In-Reply-To: <1461321071-6431-4-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-4-git-send-email-pchiu@nvidia.com>
Message-ID: <20160422131143.GL9047@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:31:03PM +0800, Penny Chiu wrote:
> The DVCO present in the DFLL IP block has a separate reset line,
> exposed via the CAR IP block.  This reset line is asserted upon SoC
> reset.  Unless something (such as the DFLL driver) deasserts this
> line, the DVCO will not oscillate, although reads and writes to the
> DFLL IP block will complete.
> 
> Signed-off-by: Penny Chiu <pchiu@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c         | 68 ++++++++++++++++++++++++++++++++
>  include/dt-bindings/reset/tegra210-car.h | 12 ++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 include/dt-bindings/reset/tegra210-car.h
> 
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
> index d3709b1..3d70b38 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/clk/tegra.h>
>  #include <dt-bindings/clock/tegra210-car.h>
> +#include <dt-bindings/reset/tegra210-car.h>
>  
>  #include "clk.h"
>  #include "clk-id.h"
> @@ -39,6 +40,9 @@
>  #define CLK_SOURCE_CSITE 0x1d4
>  #define CLK_SOURCE_EMC 0x19c
>  
> +#define RST_DFLL_DVCO 0x2f4
> +#define DVFS_DFLL_RESET_SHIFT 0

It'd be more idiomatic to make this:

	#define DVFS_DFLL_RESET (1 << 0)

and use that below instead of hard-coding the 1 << and shifting by the
define.

> +
>  #define PLLC_BASE 0x80
>  #define PLLC_OUT 0x84
>  #define PLLC_MISC0 0x88
> @@ -2781,6 +2785,68 @@ static void __init tegra210_clock_apply_init_table(void)
>  }
>  
>  /**
> + * tegra210_car_barrier - wait for pending writes to the CAR to complete
> + *
> + * Wait for any outstanding writes to the CAR MMIO space from this CPU
> + * to complete before continuing execution.  No return value.
> + */
> +static void tegra210_car_barrier(void)
> +{
> +	readl_relaxed(clk_base + RST_DFLL_DVCO);
> +}

If you use the plain readl() and writel() functions, do you still need
the barrier? Or is there actually a requirement from the hardware to
flush writes by reading from any of the registers?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/d47054db/attachment.sig>
