From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 28 Jan 2015 17:13:02 -0600
Subject: [PATCH] drivers: of: fix resources freeing in
 of_pci_get_host_bridge_resources()
In-Reply-To: <1422381705-5380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1422381705-5380-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150128231302.GB17623@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:01:45PM +0000, Lorenzo Pieralisi wrote:
> In the function of_pci_get_host_bridge_resources() if the parsing of
> ranges fails, previously allocated resources inclusive of bus_range
> are not freed and are not expected to be freed by the function caller
> on error return.
> 
> This patch fixes the issues by adding code that properly frees resources
> and bus_range before exiting the function with an error return value.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>

Applied to pci/host-generic for v3.20, thanks!

> ---
>  drivers/of/of_pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 88471d3..60dc36c 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -140,6 +140,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base)
>  {
> +	struct pci_host_bridge_window *window;
>  	struct resource *res;
>  	struct resource *bus_range;
>  	struct of_pci_range range;
> @@ -225,7 +226,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  conversion_failed:
>  	kfree(res);
>  parse_failed:
> +	list_for_each_entry(window, resources, list)
> +		kfree(window->res);
>  	pci_free_resource_list(resources);
> +	kfree(bus_range);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> -- 
> 2.2.1
> 
