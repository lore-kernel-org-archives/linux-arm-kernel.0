From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 22 Nov 2017 08:54:22 +0100
Subject: [PATCH 24/30] staging: rts5208: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-25-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-25-git-send-email-okaya@codeaurora.org>
Message-ID: <20171122075422.GD26583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:31:09AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/staging/rts5208/rtsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 89e2cfe..13b14fe 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -281,7 +281,7 @@ int rtsx_read_pci_cfg_byte(u8 bus, u8 dev, u8 func, u8 offset, u8 *val)
>  	u8 data;
>  	u8 devfn = (dev << 3) | func;
>  
> -	pdev = pci_get_bus_and_slot(bus, devfn);
> +	pdev = pci_get_domain_bus_and_slot(0, bus, devfn);

Ugh, this whole function should go away, but it's good enough for now,
I'll queue it up after -rc1 is out.

thanks,

greg k-h
