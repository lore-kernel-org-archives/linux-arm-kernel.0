From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 08:10:26 +0100
Subject: [PATCH 4/6] arm: mx5: always use __mxc_cpu_type to check cpu type
In-Reply-To: <1291903716-31388-4-git-send-email-richard.zhao@freescale.com>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<1291903716-31388-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101209071026.GI17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 10:08:34PM +0800, Richard Zhao wrote:
> Every SoC in mach-mx5 calls mxc_set_cpu_type to set cpu type.
I don't like that.  Your change makes the usage of cpu_is_mx51() for
single-machine builds more expensive.

> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/mxc.h |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
> index 4abbdd1..04afa33 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc.h
> @@ -129,10 +129,8 @@ extern unsigned int __mxc_cpu_type;
>  #ifdef CONFIG_ARCH_MX5
>  # ifdef mxc_cpu_type
>  #  undef mxc_cpu_type
> -#  define mxc_cpu_type __mxc_cpu_type
> -# else
> -#  define mxc_cpu_type MXC_CPU_MX51
>  # endif
> +# define mxc_cpu_type __mxc_cpu_type
>  # define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
>  # define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
>  #else
Here is a bug.  cpu_is_mx53 will never be true for a mx5-only build.
(That is currently always true for images supporting mx5.)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
