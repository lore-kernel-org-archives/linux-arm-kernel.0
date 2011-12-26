From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 26 Dec 2011 14:51:27 +0400
Subject: [PATCH] arm/tegra: Support Tegra30 in decompressor UART setup
In-Reply-To: <1324587719-32731-1-git-send-email-swarren@nvidia.com>
References: <1324587719-32731-1-git-send-email-swarren@nvidia.com>
Message-ID: <4EF851AF.60203@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-12-2011 1:01, Stephen Warren wrote:

> On Tegra20, the UART clock runs at 216MHz, whereas on Tegra30 it runs at
> 408MHz. Modify arch_decomp_setup() to detect Tegra20-vs-Tegra30 at run-
> time, and program the correct divisor.

> This makes uncompressor messages work correctly on Tegra30. This also
> fixes early printk, assuming zImage is used and this setup code runs.

> Signed-off-by: Stephen Warren<swarren@nvidia.com>
> ---
>   arch/arm/mach-tegra/include/mach/uncompress.h |   20 ++++++++++++++++++--
>   1 files changed, 18 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
> index 4e83237..61d6e08 100644
> --- a/arch/arm/mach-tegra/include/mach/uncompress.h
> +++ b/arch/arm/mach-tegra/include/mach/uncompress.h
[...]
> @@ -45,15 +47,29 @@ static inline void flush(void)
>
>   static inline void arch_decomp_setup(void)
>   {
> +	u8 *distctr = (u8 *)(TEGRA_ARM_INT_DIST_BASE +
> +			     GIC_DIST_CTR);
> +	u32 ctlrs, div;
>   	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
>   	int shift = 2;
>
>   	if (uart == NULL)
>   		return;
>
> +	/*
> +	 * Tegra20 has 4 interrupt controllers
> +	 * Tegra30 has 5 interrupt controllers
> +	 * Future SoCs may need additional means of identification
> +	 */
> +	ctlrs = (*distctr) & 0x1f;

    () not necessary.

WBR, Sergei
