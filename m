From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 17 Mar 2015 15:15:01 +0000
Subject: [PATCH] PCI: mvebu: add suspend/resume support
In-Reply-To: <1426604145-12335-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426604145-12335-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150317151501.GC3368@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thomas,

On Tue, Mar 17, 2015 at 03:55:45PM +0100, Thomas Petazzoni wrote:
> This commit implements suspend/resume support for the mvebu PCIe host
> driver. Without this commit, the system will panic at resume time when
> PCIe devices are connected.
> 
> Note that we have to use the ->suspend_noirq() and ->resume_noirq()
> hooks, because at resume time, the PCI fixups are done at
> ->resume_noirq() time, so the PCIe controller has to be ready at this
> point.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 1309cfb..1ab8635 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -129,6 +129,7 @@ struct mvebu_pcie_port {
>  	size_t memwin_size;
>  	phys_addr_t iowin_base;
>  	size_t iowin_size;
> +	u32 saved_pcie_stat;

nit:  It's already in the pcie port struct, why not just call it saved_state?

Either way,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
