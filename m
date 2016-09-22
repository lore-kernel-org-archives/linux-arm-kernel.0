From: briannorris@chromium.org (Brian Norris)
Date: Thu, 22 Sep 2016 10:15:11 -0700
Subject: [PATCH] PCI: rockchip: fix uninitialized variable use
In-Reply-To: <20160922094018.2138640-1-arnd@arndb.de>
References: <20160922094018.2138640-1-arnd@arndb.de>
Message-ID: <20160922171510.GA113955@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 11:39:59AM +0200, Arnd Bergmann wrote:
> The newly added pcie-rockchip driver fails to initialize the
> io_size variable if the DT doesn't provide ranges for the PCI
> I/O space, as found by building it with -Wmaybe-uninitialized:
> 
> drivers/pci/host/pcie-rockchip.c: In function 'rockchip_pcie_probe':
> drivers/pci/host/pcie-rockchip.c:1007:6: warning: 'io_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This adds an appropriate initialization immediately in front of
> the loop, so the io_size is zero as expected afterwards for that
> case.
> 
> Fixes: abe17181b16f ("PCI: rockchip: Add Rockchip PCIe controller support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pcie-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c3593e633ccd..8bedc1e1ef80 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1078,6 +1078,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		goto err_vpcie;
>  
>  	/* Get the I/O and memory ranges from DT */
> +	io_size = 0;
>  	resource_list_for_each_entry(win, &res) {
>  		switch (resource_type(win->res)) {
>  		case IORESOURCE_IO:

I feel like we've fixed this one before, but then it's been refactored
many times along the way...

Reviewed-by: Brian Norris <briannorris@chromium.org>
