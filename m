From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Nov 2014 14:33:50 +0100
Subject: [PATCH] ARM: common: edma: edma_pm_resume may be unused
In-Reply-To: <4363971.teBOlf16kG@wuerfel>
References: <4363971.teBOlf16kG@wuerfel>
Message-ID: <20141121133350.GR27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Fri, Nov 21, 2014 at 11:52:51AM +0100, Arnd Bergmann wrote:
> The recently introduced resume hook in the edma driver
> is not referenced when CONFIG_PM_SLEEP is not set, which
> results in a compile warning in keystone_defconfig builds.
> 
> This adds an appropriate #ifdef.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Joel Fernandes <joelf@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Fixes: a2b1175131: ("ARM: common: edma: add suspend resume hook")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm applying this as the obvious fixup on top of the next/drivers
> branch.
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 24a2857f2285..5662a872689b 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1810,6 +1810,7 @@ static int edma_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int edma_pm_resume(struct device *dev)
What about

-static int edma_pm_resume(struct device *dev)
+static int __maybe_unused edma_pm_resume(struct device *dev)

instead?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
