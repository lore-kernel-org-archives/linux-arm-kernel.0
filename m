From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Oct 2012 23:13:07 +0100
Subject: [PATCH V3 3/5] ARM: tegra: decouple uncompress.h and debug-macro.S
In-Reply-To: <50857340.4010403@wwwdotorg.org>
References: <1350686507-3022-1-git-send-email-swarren@wwwdotorg.org>
 <1350686507-3022-3-git-send-email-swarren@wwwdotorg.org>
 <20121022081830.GH3196@tbergstrom-lnx.Nvidia.com>
 <50857340.4010403@wwwdotorg.org>
Message-ID: <20121022221307.GO21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 10:24:32AM -0600, Stephen Warren wrote:
> On 10/22/2012 02:18 AM, Peter De Schrijver wrote:
> >> +
> >> +#define checkuart(rp, rv, lhu, bit, uart) \
> >> +               /* Load address of CLK_RST register */ \
> >> +               movw    rp, #TEGRA_CLK_RST_DEVICES_##lhu & 0xffff ; \
> >> +               movt    rp, #TEGRA_CLK_RST_DEVICES_##lhu >> 16 ; \
> >> +               /* Load value from CLK_RST register */ \
> >> +               ldr     rp, [rp, #0] ; \
> >> +               /* Test UART's reset bit */ \
> >> +               tst     rp, #(1 << bit) ; \
> >> +               /* If set, can't use UART; jump to save no UART */ \
> >> +               bne     90f ; \
> >> +               /* Load address of CLK_OUT_ENB register */ \
> >> +               movw    rp, #TEGRA_CLK_OUT_ENB_##lhu & 0xffff ; \
> >> +               movt    rp, #TEGRA_CLK_OUT_ENB_##lhu >> 16 ; \
> >> +               /* Load value from CLK_OUT_ENB register */ \
> >> +               ldr     rp, [rp, #0] ; \
> >> +               /* Test UART's clock enable bit */ \
> >> +               tst     rp, #(1 << bit) ; \
> >> +               /* If clear, can't use UART; jump to save no UART */ \
> >> +               beq     90f ; \
> >> +               /* Passed all tests, load address of UART registers */ \
> >> +               movw    rp, #TEGRA_UART##uart##_BASE & 0xffff ; \
> >> +               movt    rp, #TEGRA_UART##uart##_BASE >> 16 ; \
> >> +               /* Jump to save UART address */ \
> >> +               b 91f
> >>
> > 
> > Maybe make this a subroutine?
> 
> The addruart macro (which in turn uses the checkuart macro) is only
> allowed to use 3 registers; rp, rv, rtmp. I'm also not 100% sure if the
> stack is guaranteed to be set up when addruart is called either. So, I
> don't think making this a function is possible.

There's no stack.  Remember, this stuff can be inserted as early as the
front of the kernel assembly code, where there is _nothing_ - the MMU
is off so virtual addresses are meaningless.  etc.
