From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 14 Jan 2011 16:27:07 -0800
Subject: [PATCH 4/6] dmaengine: at_hdmac: use subsys_initcall instead of
	module_init
In-Reply-To: <1294843150-6962-3-git-send-email-nicolas.ferre@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
	<1294843150-6962-3-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <AANLkTikY53tOv1eCtMcTqrmy52WawLZdp3Vnq24ozHJ1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 6:39 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> From: Eric Xu <hong.xu@atmel.com>
>
> Use subsys_initcall instead of module_init in order to keep DMA engine rolling
> before other peripheral drivers.
>
> Signed-off-by: Eric Xu <hong.xu@atmel.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> ?drivers/dma/at_hdmac.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 4f83431..a1a0fc6 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1209,7 +1209,7 @@ static int __init at_dma_init(void)
> ?{
> ? ? ? ?return platform_driver_probe(&at_dma_driver, at_dma_probe);
> ?}
> -module_init(at_dma_init);
> +subsys_initcall(at_dma_init);

If this matters shouldn't we also do this?

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1b61d3a..4d14626 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -90,7 +90,7 @@ config DW_DMAC
          can be integrated in chips such as the Atmel AT32ap7000.

 config AT_HDMAC
-       tristate "Atmel AHB DMA support"
+       bool "Atmel AHB DMA support"
        depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
        select DMA_ENGINE
        help
