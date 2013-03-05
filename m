From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 21:54:22 +0000
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303052124.04101.arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303052150.24947.heiko@sntech.de> <201303052124.04101.arnd@arndb.de>
Message-ID: <201303052154.22857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Arnd Bergmann wrote:
> The s3c64xx_dma code is also interesting because
> it has both an implementation of the s3c_dma interface in
> arch/arm/mach-s3c64xx/dma.c and one using the generic interface in
> drivers/dma/amba-pl08x.c. 

This actually brings me to an interesting idea: the s3c64xx SPI driver
is used with the regular dmaengine API and pl330 on S5P and Exynos,
but with the s3c-dma interface and pl080 on S3C64xx.

If we just convert S3C64xx to use the pl080 dmaengine driver
instead, we can apply my SPI patch without breaking anything.

We still need a solution for the ASoC drivers, but they are
not as essential. We could probably move the wrapper files
from plat-samsung/*dma*.c to sounds/soc/samsung when that becomes
the only remaining user.

There is also drivers/mmc/host/s3cmci.c, which uses the s3c-dma
interface, but it is only used on s3c24xx, not s3c64xx or later.

	Arnd
