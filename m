From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 21 Feb 2017 12:04:24 -0500
Subject: [PATCH V3 2/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1475473021-14251-3-git-send-email-okaya@codeaurora.org>
References: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
 <1475473021-14251-3-git-send-email-okaya@codeaurora.org>
Message-ID: <ac667a77-028d-d5da-f574-61f787fec72c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

I'm coming back to work on this. 

On 10/3/2016 1:37 AM, Sinan Kaya wrote:
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
> index c8749b9..7580b00 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3725,7 +3725,8 @@ static void pci_flr_wait(struct pci_dev *dev)
>  
>  	do {
>  		msleep(100);
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);

Your comment here puzzled me. 

https://patchwork.kernel.org/patch/8331851/

"Self nak on this one, didn't account for VFs not implementing the first
dword.  Thanks,"

I'm trying to add Configuration Request Retry Status (CRS) support to FLR
with this patch. 

Basically, the root port will return 0xFFFF0001 only when a config read
request is sent to the vendor ID register and CRS visibility is set.
The SW needs to poll until this special read ID disappears. See the
implementation note on Configuration Request Retry Status in PCIE
specification for details.

pci_bus_read_dev_vendor_id implements this loop for us.

You are saying that there are VFs that do not implement vendor ID register.
Can you give some history on this?


> +		pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
> +					   60 * 1000);
>  	} while (i++ < 10 && id == ~0);
>  
>  	if (id == ~0)
> 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
