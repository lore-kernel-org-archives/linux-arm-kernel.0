From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 16 Feb 2012 15:33:12 +0530
Subject: [PATCH 2/3] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
In-Reply-To: <20120215182825.18884.40972.stgit@kaulin.local>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182825.18884.40972.stgit@kaulin.local>
Message-ID: <4F3CD460.7000306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 15 February 2012 11:58 PM, Tony Lindgren wrote:
> Otherwise omap_device_build() and omap_mux related functions
> can't be marked as __init when twl is build as a module.
>
> If a board is using GPIO pins or regulators configured by an
> external chip, such as TWL PMIC on I2C bus, the board must
> mark those MMC controllers as deferred. Additionally both
> omap_hsmmc_init() and omap_hsmmc_late_init() must be called
> by the board.
>
> For MMC controllers using internal GPIO pins for card
> detect and regulators the slots don't need to be marked
> deferred. In this case calling omap_hsmmc_init() is sufficient.
>
> Note that this patch does not change the behaviour for
> board-4430sdp.c board-omap4panda.c. These boards wrongly
> rely on the omap_hsmmc.c init function callback to configure
> the PMIC GPIO interrupt lines on external chip. If the PMIC
> interrupt lines are not configured during init, they will
> fail.

I tested these patches on omap3 beagle and card detect seems
to be broken. See my comment below on why.

>
> Reported-by: Russell King<rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> ---
>   arch/arm/mach-omap2/board-2430sdp.c          |    2
>   arch/arm/mach-omap2/board-3430sdp.c          |    5 +
>   arch/arm/mach-omap2/board-4430sdp.c          |    4 -
>   arch/arm/mach-omap2/board-am3517evm.c        |    2
>   arch/arm/mach-omap2/board-cm-t35.c           |    6 +
>   arch/arm/mach-omap2/board-devkit8000.c       |    4 +
>   arch/arm/mach-omap2/board-igep0020.c         |    7 +-
>   arch/arm/mach-omap2/board-ldp.c              |    2
>   arch/arm/mach-omap2/board-omap3beagle.c      |    4 +
>   arch/arm/mach-omap2/board-omap3evm.c         |    5 +
>   arch/arm/mach-omap2/board-omap3logic.c       |    2
>   arch/arm/mach-omap2/board-omap3pandora.c     |    6 +
>   arch/arm/mach-omap2/board-omap3stalker.c     |   12 ++-
>   arch/arm/mach-omap2/board-omap3touchbook.c   |    4 +
>   arch/arm/mach-omap2/board-omap4panda.c       |    4 -
>   arch/arm/mach-omap2/board-overo.c            |    5 +
>   arch/arm/mach-omap2/board-rm680.c            |    2
>   arch/arm/mach-omap2/board-rx51-peripherals.c |    2
>   arch/arm/mach-omap2/board-zoom-peripherals.c |    6 +
>   arch/arm/mach-omap2/hsmmc.c                  |  107 +++++++++++++++++++-------
>   arch/arm/mach-omap2/hsmmc.h                  |   12 ++-
>   21 files changed, 147 insertions(+), 56 deletions(-)
>

[]...
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index e921e3b..60f0501 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -413,7 +413,7 @@ static struct omap2_hsmmc_info mmc[] = {
>   		.caps		= MMC_CAP_4_BIT_DATA,
>   		.gpio_cd	= -EINVAL,
>   		.gpio_wp	= -EINVAL,
> -
> +		.deferred	= true,
>   	},
>   	{
>   		.mmc		= 2,
> @@ -422,6 +422,7 @@ static struct omap2_hsmmc_info mmc[] = {
>   		.gpio_cd	= -EINVAL,
>   		.gpio_wp	= -EINVAL,
>   		.ocr_mask	= 0x00100000,	/* 3.3V */
> +		.deferred	= true,
>   	},
>   	{}	/* Terminator */
>   };
> @@ -471,7 +472,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>
>   	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
>   	mmc[0].gpio_cd = gpio + 0;
> -	omap2_hsmmc_init(mmc);
> +	omap_hsmmc_late_init(mmc);

omap_hsmmc_late_init() in some way needs to pass on the gpio_cd
value onto the driver via platform_data which its currently not.
better still, I think we should just populate them statically in
omap2_hsmmc_info struct above, so omap_hsmmc_init() takes care
of it already.

[]...
>
> +void omap_hsmmc_late_init(struct omap2_hsmmc_info *controllers)
> +{
> +	struct platform_device *pdev;
> +	int res;
> +
> +	for (; controllers->mmc; controllers++) {
> +		if (!controllers->deferred)
> +			continue;
> +
> +		pdev = controllers->pdev;
> +		if (!pdev)
> +			continue;
> +
> +		res = omap_device_register(pdev);
> +		if (res) {
> +			pr_err("Could not late init MMC %s\n",
> +			       controllers->name);
> +			continue;
> +		}
> +	}
> +}

regards,
Rajendra
