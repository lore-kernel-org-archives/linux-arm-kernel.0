From: paul.burton@imgtec.com (Paul Burton)
Date: Tue, 9 Feb 2016 08:11:34 -0800
Subject: [PATCH V3 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to work on both  Zynq and Microblaze
In-Reply-To: <1455014518-8708-4-git-send-email-bharatku@xilinx.com>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
 <1455014518-8708-4-git-send-email-bharatku@xilinx.com>
Message-ID: <20160209161134.GA24244@NP-P-BURTON>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 04:11:56PM +0530, Bharat Kumar Gogada wrote:
> Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
> Zynq and Microblaze Architectures.
> With these modifications drivers/pci/host/pcie-xilinx.c, will
> work on both Zynq and Microblaze Architectures.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Changes:
> Removed unneccessary architecture dependent number of MSI's.
> Added #ifdef to pci_fixup_irqs which is ARM specific API.

Hi Bharat,

Why do you say pci_fixup_irqs is ARM-specific? It's declared in
include/linux/pci.h, defined in drivers/pci/setup-irq.c & used by
multiple architectures (alpha, arm, m68k, mips, sh, sparc, tile,
unicore32 from a quick grep).

Will you not break INTX-style interrupts by removing this?

Thanks,
    Paul

> ---
>  drivers/pci/host/pcie-xilinx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 13fec35..6cbce34 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -704,7 +704,9 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  #endif
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +#ifdef CONFIG_ARM
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
>  	pci_bus_add_devices(bus);
>  	platform_set_drvdata(pdev, port);
>  
> -- 
> 2.1.1
> 
