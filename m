From: tinamdar@apm.com (Tanmay Inamdar)
Date: Thu, 19 Feb 2015 14:53:35 -0800
Subject: [PATCH] pci: host: xgene: fix incorrectly returned address by
 map_bus
In-Reply-To: <1424214840-26498-1-git-send-email-fkan@apm.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
Message-ID: <CACoXjcn7HYSjgtbx1dvQuL0xjrjCn4F_KgRs7Mj2-=OEE6jeyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 3:14 PM, Feng Kan <fkan@apm.com> wrote:
>
> The generic accessor functions for pci-xgene uses map_bus
> call that returns the base address but did not add the additional
> offset.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/pci/host/pci-xgene.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index aab5547..ee082c0 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>         return false;
>  }
>
> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>                               int offset)
>  {
>         struct xgene_pcie_port *port = bus->sysdata;
> @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>                 return NULL;
>
>         xgene_pcie_set_rtdid_reg(bus, devfn);
> -       return xgene_pcie_get_cfg_base(bus);
> +       return xgene_pcie_get_cfg_base(bus) + offset;
>  }
>
>  static struct pci_ops xgene_pcie_ops = {


Acked-by: Tanmay Inamdar <tinamdar@apm.com>

>
> --
> 1.9.1
>
