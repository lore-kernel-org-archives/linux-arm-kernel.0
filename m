From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 22 Oct 2012 11:18:30 +0300
Subject: [PATCH V3 3/5] ARM: tegra: decouple uncompress.h and debug-macro.S
In-Reply-To: <1350686507-3022-3-git-send-email-swarren@wwwdotorg.org>
References: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
 <1350686507-3022-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121022081830.GH3196@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +#define checkuart(rp, rv, lhu, bit, uart) \
> +               /* Load address of CLK_RST register */ \
> +               movw    rp, #TEGRA_CLK_RST_DEVICES_##lhu & 0xffff ; \
> +               movt    rp, #TEGRA_CLK_RST_DEVICES_##lhu >> 16 ; \
> +               /* Load value from CLK_RST register */ \
> +               ldr     rp, [rp, #0] ; \
> +               /* Test UART's reset bit */ \
> +               tst     rp, #(1 << bit) ; \
> +               /* If set, can't use UART; jump to save no UART */ \
> +               bne     90f ; \
> +               /* Load address of CLK_OUT_ENB register */ \
> +               movw    rp, #TEGRA_CLK_OUT_ENB_##lhu & 0xffff ; \
> +               movt    rp, #TEGRA_CLK_OUT_ENB_##lhu >> 16 ; \
> +               /* Load value from CLK_OUT_ENB register */ \
> +               ldr     rp, [rp, #0] ; \
> +               /* Test UART's clock enable bit */ \
> +               tst     rp, #(1 << bit) ; \
> +               /* If clear, can't use UART; jump to save no UART */ \
> +               beq     90f ; \
> +               /* Passed all tests, load address of UART registers */ \
> +               movw    rp, #TEGRA_UART##uart##_BASE & 0xffff ; \
> +               movt    rp, #TEGRA_UART##uart##_BASE >> 16 ; \
> +               /* Jump to save UART address */ \
> +               b 91f
> 

Maybe make this a subroutine?

Cheers,

Peter.
