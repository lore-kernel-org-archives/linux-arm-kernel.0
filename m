From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 19:48:23 +0800
Subject: [PATCH 1/1] arm: imx7d: correct chip version information
In-Reply-To: <1450129582-4261-1-git-send-email-Frank.Li@freescale.com>
References: <1450129582-4261-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20151221114823.GH4703@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 03:46:22PM -0600, Frank Li wrote:
> show correct soc version infomation.

s/infomation/information

I feel you should write your commit log and comments a bit more
seriously.  The commit log above is not even a sentence.

For arch/arm/ patches sent to me, please use "ARM" rather than "arm" as
subject prefix.

> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/mach-imx/anatop.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index 231bb25..23a4fc1 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -151,7 +151,14 @@ void __init imx_init_revision_from_anatop(void)
>  		revision = IMX_CHIP_REVISION_1_5;
>  		break;
>  	default:
> -		revision = IMX_CHIP_REVISION_UNKNOWN;
> +		/*
> +		 * Fail back to return raw register value instead of 0xff.
> +		 * It will be easy know version information in SOC if it
> +		 * can't recongized by known version. And some chip like
> +		 * i.MX7D soc digprog value match linux version format,
> +		 * needn't map again and direct use register value.
> +		 */

There are quite a few grammar issues in this piece of comment.  Please
fix them.

> +		revision = digprog & 0xff;

I'm fine with it.  But we should be clear about that with this change,
the "unknown revision" message in imx_print_silicon_rev() will never work
then for digprog.

Shawn

>  	}
>  
>  	mxc_set_cpu_type(digprog >> 16 & 0xff);
> -- 
> 2.5.2
> 
> 
