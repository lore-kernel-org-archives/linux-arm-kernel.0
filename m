From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 24 Aug 2016 15:50:59 -0500
Subject: [PATCH v1] arm64:pci: fix the IOV device enabled crash issue in
 designware
In-Reply-To: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
Message-ID: <20160824205059.GG23914@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Jingoo, Pratyush, Michal, S?ren, Ley]

On Tue, Aug 23, 2016 at 02:01:12PM +0800, Po Liu wrote:
> When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
> VF devices. A crash log occurred. This found to be access the IOV devices
> config space failure issue.

What was the actual crash?  The mere fact that we made a config read fail
should not cause a crash.  We might erroneously prevent access to VF
devices, but it shouldn't crash.  So maybe there's another bug elsewhere
that we should fix first.

> The read/write config space from host would judge the pcie device plugin
> or not by:
> 
> if (bus->primary == pp->root_bus_nr && dev > 0)
>     return 0;

I'm guessing other drivers have the same issue, e.g.,
altera_pcie_valid_config(), xilinx_pcie_valid_device().

Can you look through them and fix them all at once?

> Although all pcie devices for dev(coming from the device and function
> number) is zero. But the dev is not zero for VF. So remove the
> condition.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
>  drivers/pci/host/pcie-designware.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 12afce1..dd20eb2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -670,13 +670,6 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  	if (bus->number == pp->root_bus_nr && dev > 0)
>  		return 0;
>  
> -	/*
> -	 * do not read more than one device on the bus directly attached
> -	 * to RC's (Virtual Bridge's) DS side.
> -	 */
> -	if (bus->primary == pp->root_bus_nr && dev > 0)
> -		return 0;
> -
>  	return 1;
>  }
>  
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
