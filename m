From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 16:24:42 +0800
Subject: [PATCH 2/2] arm: imx: support arm power off in cpuidle for i.mx6sx
In-Reply-To: <1418102919-29950-2-git-send-email-b20788@freescale.com>
References: <1418102919-29950-1-git-send-email-b20788@freescale.com>
 <1418102919-29950-2-git-send-email-b20788@freescale.com>
Message-ID: <20141216082441.GH2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 01:28:39PM +0800, Anson Huang wrote:
> This patch introduces an independent cpuidle driver for
> i.MX6SX, and supports arm power off in idle, totally
> 3 levels of cpuidle are supported as below:
> 
> 1. ARM WFI;
> 2. SOC in WAIT mode;
> 3. SOC in WAIT mode + ARM power off.
> 
> ARM power off can save at least 5mW power.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Looks pretty nice, except one small comment below.

> ---
>  arch/arm/mach-imx/Makefile         |    3 +-
>  arch/arm/mach-imx/common.h         |    4 ++
>  arch/arm/mach-imx/cpuidle-imx6sx.c |  107 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/cpuidle.h        |    5 ++
>  arch/arm/mach-imx/gpc.c            |   25 ++++++++-
>  arch/arm/mach-imx/mach-imx6sx.c    |    2 +-
>  arch/arm/mach-imx/pm-imx6.c        |    2 +-
>  7 files changed, 142 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx6sx.c

...

> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -205,7 +205,7 @@ void imx6q_set_int_mem_clk_lpm(bool enable)
>  	writel_relaxed(val, ccm_base + CGPR);
>  }
>  
> -static void imx6q_enable_rbc(bool enable)
> +void imx6q_enable_rbc(bool enable)

We may want to take the chance to rename it to imx6_enable_rbc().

Shawn

>  {
>  	u32 val;
>  
> -- 
> 1.7.9.5
> 
