From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 17 Oct 2013 16:31:46 -0700
Subject: [PATCH 4/6] PCI: imx6: Probe the PCIe in fs_initcall()
In-Reply-To: <1381853200-5534-5-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-5-git-send-email-marex@denx.de>
Message-ID: <CAJ+vNU0rJY0xMCpJxFQ1ue7Gnfe+49Xv3=2zawCTzHEd_eAK0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 9:06 AM, Marek Vasut <marex@denx.de> wrote:
> Probe the PCIe driver in fs_initcall() instead of module_init()
> to assure that pci_assign_unassigned_resources(); will be called
> early. This function is called in dw_pcie_host_init(), which is
> in turn called from imx6_add_pcie_port(), which is called from
> imx6_pcie_probe() . If this is not called early, we will hit
> resource collisions since pcieport driver is then probed way too
> late.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 94e4d0f..ca8c5de 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -586,7 +586,7 @@ static int __init imx6_pcie_init(void)
>  {
>         return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
>  }
> -module_init(imx6_pcie_init);
> +fs_initcall(imx6_pcie_init);
>
>  MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
>  MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
> --
> 1.8.4.rc3
>

Acked-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>

Tim
