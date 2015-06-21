From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 21 Jun 2015 10:24:18 +0200
Subject: [PATCH v7 00/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <CAP=VYLpSrTvXRovWo4G7AXWv1OKFQRpQR255hS5z+=h4+XOLhg@mail.gmail.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150619142444.GA15234@gondor.apana.org.au>
 <CAP=VYLqQynCNRTpm4JnOxeO6DH_739fO2QNcDMxaXqCKCHiTtQ@mail.gmail.com>
 <CAP=VYLpSrTvXRovWo4G7AXWv1OKFQRpQR255hS5z+=h4+XOLhg@mail.gmail.com>
Message-ID: <20150621102418.2ea74910@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sat, 20 Jun 2015 20:14:08 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Sat, Jun 20, 2015 at 4:32 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > On Fri, Jun 19, 2015 at 10:24 AM, Herbert Xu
> > <herbert@gondor.apana.org.au> wrote:
> >> On Thu, Jun 18, 2015 at 03:46:16PM +0200, Boris Brezillon wrote:
> >>> Hello,
> >>>
> >>> This patch series adds a new driver supporting Marvell's CESA IP.
> >>> This driver addresses some limitations of the existing one.
> >>> >From a performance and CPU load point of view the most important
> >>> limitation in the existing driver is the lack of DMA support, thus
> >>> preventing us from chaining crypto operations.
> >>
> >> All applied to cryptodev.  Thanks a lot!
> >
> > It seems this breaks linux-next allmodconfig on i386:
> 
> Similar breakage for s390 and sparc it seems:
> 
> drivers/crypto/marvell/cesa.c:353:2: error: implicit declaration of
> function 'phys_to_dma' [-Werror=implicit-function-declaration]
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/12445415/
> http://kisskb.ellerman.id.au/kisskb/buildresult/12445345/
> 
> If the CESA IP is only available on a single arch then
> adding an arch dependency might be the easiest fix,
> since phys_to_dma seems sparsely implemented.

Indeed. Here is a patch fixing that.

Thanks,

Boris

--- >8 ---

>From 891d4e5f185c39cd34b5859a1a63850ef997514d Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Sun, 21 Jun 2015 10:17:54 +0200
Subject: [PATCH] crypto: marvell/CESA: enforce dependency on ARM

The CESA driver calls phys_to_virt() which is not available on all
architectures.
Enforce the dependency on ARM so that other architectures won't compile
the driver even if COMPILE_TEST is set.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Suggested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index cdca762..b374d5d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -176,7 +176,7 @@ config CRYPTO_DEV_MV_CESA
 
 config CRYPTO_DEV_MARVELL_CESA
 	tristate "New Marvell's Cryptographic Engine driver"
-	depends on (PLAT_ORION || ARCH_MVEBU || COMPILE_TEST) && HAS_DMA && HAS_IOMEM
+	depends on (PLAT_ORION || ARCH_MVEBU || COMPILE_TEST) && HAS_DMA && HAS_IOMEM && ARM
 	select CRYPTO_AES
 	select CRYPTO_DES
 	select CRYPTO_BLKCIPHER
-- 
1.9.1



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
