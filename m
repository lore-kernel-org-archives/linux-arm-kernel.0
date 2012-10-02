From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 2 Oct 2012 22:01:30 +0200
Subject: [PATCH 1/3] ARM: tegra: simplify DEBUG_LL UART selection options
In-Reply-To: <1349204866-21810-1-git-send-email-swarren@wwwdotorg.org>
References: <1349204866-21810-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121002200130.GA31363@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:07:44PM -0600, Stephen Warren wrote:
[...]
>  choice
> -        prompt "Default low-level debug console UART"
> -        default TEGRA_DEBUG_UART_NONE
> +        prompt "Low-level debug console UART"
> +        default TEGRA_DEBUG_UART_AUTO_ODMDATA
>  
> -config TEGRA_DEBUG_UART_NONE
> -        bool "None"
> +config TEGRA_DEBUG_UART_AUTO_ODMDATA

The first item in a list of choices is automatically selected as the
default, so technically the default is redundant here. I suppose it
doesn't hurt to be explicit.

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> index 0b0a5f5..0913d1f 100644
> --- a/arch/arm/mach-tegra/common.c
> +++ b/arch/arm/mach-tegra/common.c
> @@ -44,14 +44,13 @@
>   * kernel is loaded. The data is declared here rather than debug-macro.S so
>   * that multiple inclusions of debug-macro.S point at the same data.
>   */
> -#define TEGRA_DEBUG_UART_OFFSET (TEGRA_DEBUG_UART_BASE & 0xFFFF)
>  u32 tegra_uart_config[3] = {
>  	/* Debug UART initialization required */
>  	1,
>  	/* Debug UART physical address */
> -	(u32)(IO_APB_PHYS + TEGRA_DEBUG_UART_OFFSET),
> +	0,
>  	/* Debug UART virtual address */
> -	(u32)(IO_APB_VIRT + TEGRA_DEBUG_UART_OFFSET),
> +	0,
>  };

I don't quite see how this is supposed to work now. Won't the debug.S
code fail if these fields are set to 0?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/6e8b6ce5/attachment.sig>
