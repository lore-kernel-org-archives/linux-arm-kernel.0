From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Sep 2017 09:44:48 +0200
Subject: [PATCH 2/2] of: configure DMA for host1x devices
In-Reply-To: <20170924090454.28116-2-mperttunen@nvidia.com>
References: <20170924090454.28116-1-mperttunen@nvidia.com>
 <20170924090454.28116-2-mperttunen@nvidia.com>
Message-ID: <20170925074448.GB12494@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 24, 2017 at 12:04:54PM +0300, Mikko Perttunen wrote:
> Devices in the host1x bus rely on the old behavior of of_dma_configure
> to set up DMA ops. Add a check for them into of_dma_configure.
> 
> We must do the check using a string comparison instead of using
> pointers since the host1x bus can be compiled into a module.
> 
> Fixes: 723288836628 ("of: restrict DMA configuration")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/of/device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 64b710265d39..12368418cd33 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -104,6 +104,9 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>  		if (!dev_is_pci(dev) &&
>  #ifdef CONFIG_ARM_AMBA
>  		    dev->bus != &amba_bustype &&
> +#endif
> +#if IS_ENABLED(CONFIG_TEGRA_HOST1X)
> +		    !(dev->bus && !strcmp("host1x", dev->bus->name)) &&
>  #endif
>  		    dev->bus != &platform_bus_type)
>  			return ret == -ENODEV ? 0 : ret;

Maybe a slightly better solution would be to add a dev_is_host1x()
function that returns dev->bus == &host1x_bus_type if TEGRA_HOST1X is
enabled and returns false otherwise. That way we can have a "proper"
check for the bus type and avoid the #if in this file.

It's slightly more complicated because of the dependencies between the
DT and Tegra DRM trees, but I'm sure we can get Rob to either give his
Acked-by on the drivers/of/device.c change or carry the Tegra DRM patch
in the DT tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/9c58ca02/attachment.sig>
