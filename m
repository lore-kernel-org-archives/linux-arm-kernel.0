From: robherring2@gmail.com (Rob Herring)
Date: Thu, 01 Sep 2011 09:20:54 -0500
Subject: [PATCH] mach-ux500: unlock I&D l2x0 caches before init
In-Reply-To: <1314870093-5758-1-git-send-email-linus.walleij@stericsson.com>
References: <1314870093-5758-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E5F94C6.7020609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 09/01/2011 04:41 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Apparently U8500 U-Boot versions may leave the l2x0 locked down
> before executing the kernel. Make sure we unlock it before we
> initialize the l2x0. This fixes a performance problem reported
> by Jan Rinze.
> 

Just when you think a bootloader wouldn't muck with something like this...

I'll ask the obvious question: As this is u-boot, can't this be fixed in
u-boot?

> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Rabin Vincent <rabin.vincent@stericsson.com>
> Cc: Adrian Bunk <adrian.bunk@movial.com>
> Reported-by: Jan Rinze <janrinze@gmail.com>
> Tested-by: Robert Marklund <robert.marklund@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/cache-l2x0.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
> index 9d09e4d..96ef556 100644
> --- a/arch/arm/mach-ux500/cache-l2x0.c
> +++ b/arch/arm/mach-ux500/cache-l2x0.c
> @@ -70,3 +70,18 @@ static int ux500_l2x0_init(void)
>  }
>  
>  early_initcall(ux500_l2x0_init);
> +
> +static int ux500_l2x0_unlock(void)
> +{
> +	/*
> +	 * Unlock Data and Instruction Lock if locked. Ux500 U-Boot versions
> +	 * apparently locks both caches before jumping to the kernel.
> +	 */
> +	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_D) & 0xFF)
> +		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
> +
> +	if (readl_relaxed(l2x0_base + L2X0_LOCKDOWN_WAY_I) & 0xFF)
> +		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);

Do you really need to read the register first?

Can't this just be done unconditionally in l2x0_init for everyone. I
doubt anyone wants to lock down ways. You would need to adjust for
16-way support.

Rob
