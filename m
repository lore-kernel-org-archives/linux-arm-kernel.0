From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Mar 2014 10:50:32 -0500
Subject: [PATCH 05/75] ARM: l2c: remove unnecessary UL-suffix to mask
 values
In-Reply-To: <E1WTYUW-0004WD-UP@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUW-0004WD-UP@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_Jsq+qaQ=CtqMKbd5Fcp1YAY+E40mS24kWe8RMwb2Bz1A9kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:14 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> They're u32, they're not unsigned long.  The UL suffix is not required
> here.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-highbank/highbank.c   | 2 +-
>  arch/arm/mach-imx/mach-vf610.c      | 2 +-
>  arch/arm/mach-imx/system.c          | 2 +-
>  arch/arm/mach-mvebu/armada-370-xp.c | 2 +-
>  arch/arm/mach-rockchip/rockchip.c   | 2 +-
>  arch/arm/mach-socfpga/socfpga.c     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index c7de89b263dd..38e1dc3b4c6e 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -69,7 +69,7 @@ static void __init highbank_init_irq(void)
>         if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
>             of_find_compatible_node(NULL, NULL, "arm,pl310-cache")) {
>                 highbank_smc1(0x102, 0x1);
> -               l2x0_of_init(0, ~0UL);
> +               l2x0_of_init(0, ~0);

What about changing these callers to use l2x0_of_init(void) and
creating l2x0_of_init_legacy(val, mask) for ones that need the aux
ctrl setup? We do want to encourage people to either setup aux ctrl in
the bootloader or via DT properties.

Rob
