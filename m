From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 10 Nov 2016 13:38:43 -0500
Subject: [PATCH V2 5/5] PCI: handle CRS returned by device after FLR
In-Reply-To: <1474056395-21843-6-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
 <1474056395-21843-6-git-send-email-okaya@codeaurora.org>
Message-ID: <f006cd09-f21f-1d3c-d613-0bbca0a2e236@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/16/2016 4:06 PM, Sinan Kaya wrote:
> An endpoint is allowed to issue CRS following an FLR request to indicate
> that it is not ready to accept new requests. Changing the polling mechanism
> in FLR wait function to go read the vendor ID instead of the command/status
> register. A CRS indication will only be given if the address to be read is
> vendor ID.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e913467..1def11e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3729,7 +3729,8 @@ static void pci_flr_wait(struct pci_dev *dev)
>  
>  	do {
>  		msleep(100);
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> +		pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
> +					   60 * 1000);

We found out during Mellanox CX3 testing that the card returns the vendor
ID earlier during FLR while other cards are OK with this implementaiton. 

I think we need both of the reads to support the CRS for the endpoints
and also the command id register read to make sure endpoint init is complete.


>  	} while (i++ < 10 && id == ~0);
>  
>  	if (id == ~0)
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
