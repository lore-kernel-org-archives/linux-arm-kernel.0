From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 10:59:36 +0100
Subject: [PATCH v3 1/6] PCI: designware: remove wrong io_base assignment
In-Reply-To: <44d133d5ebd4f7b9e8b817aa8bae12f690e70000.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <44d133d5ebd4f7b9e8b817aa8bae12f690e70000.1448270813.git.stanimir.varbanov@linaro.org>
Message-ID: <6048361.Am0T3g77Bd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 11:28:58 Stanimir Varbanov wrote:
> The io_base is used to keep the cpu physical address parsed
> from ranges dt property. After issue pci_remap_iospace the
> io_base has been assigned with io->start, which is not correct
> cause io->start is a PCI bus address.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077c37ea..02a7452bdf23 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  					 ret, pp->io);
>  				continue;
>  			}
> -			pp->io_base = pp->io->start;
>  			break;
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;

I was surprised to see such an obvious bug here, as we had spent a lot of
time trying to get it right. However, it broke only recently and it's
worth mentioning what commit did it, so

Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The bug is present in 4.4-rc1 and we should get your fix merged into 4.4
as well, while all the other patches in your series are presumably for 4.5.

	Arnd
