From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 18 May 2018 14:51:54 -0500
Subject: [PATCH v7 2/2] PCI: mediatek: Using chained IRQ to setup IRQ
 handle
In-Reply-To: <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
 <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20180518195154.GB41790@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 01:47:33PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Using irq_chip solution to setup IRQs in order to consist
> with IRQ framework.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 206 ++++++++++++++++++++++-----------------
>  1 file changed, 115 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index c3dc549..dabf1086 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> ...

> -static int mtk_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			    irq_hw_number_t hwirq)
> +static struct msi_domain_info mtk_msi_domain_info = {

I think this patch should be amended to include this:

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..368b70d9371b 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -193,7 +193,7 @@ config PCIE_MEDIATEK
 	bool "MediaTek PCIe controller"
 	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
 	depends on OF
-	depends on PCI
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on


Lorenzo, if you want to fold that in and update your branch, I can pull it.
If not, I can add a patch on top, which should only break compile-testing
bisection.
