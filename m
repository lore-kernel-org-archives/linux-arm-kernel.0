From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 2 Aug 2017 11:49:24 -0600
Subject: [PATCH V6 2/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1501694304-16554-2-git-send-email-okaya@codeaurora.org>
References: <1501694304-16554-1-git-send-email-okaya@codeaurora.org>
 <1501694304-16554-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20170802114924.18dd30e2@w520.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  2 Aug 2017 13:18:24 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
> following a Function Level Reset (FLR) request to indicate that it is
> not ready to accept new requests. CRS is defined in PCIe r3.1, sec 2.3.1.
> Request Handling Rules and CRS usage in FLR context is mentioned in
> PCIe r3.1, sec 6.6.2. Function-Level Reset.
> 
> Adding a vendor ID read if this is a physical function before attempting
> to read any other registers on the endpoint. A CRS indication will only
> be given if the address to be read is vendor ID register.
> pci_bus_read_dev_vendor_id() knows how to deal with CRS returned values.
> 
> If pci_bus_read_dev_vendor_id() fails, it prints a user visible warning
> after provided 1 second timeout is reached. pci_flr_wait() will keep
> calling this function 60 times to allow up to 60 seconds to be consistent
> with the rest of the kernel CRS timeout handling.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2ed604a..01b28ac 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3813,30 +3813,40 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  
>  /*
>   * We should only need to wait 100ms after FLR for virtual functions.
> - * Wait for up to 1000ms for config space to return something other than -1.
> - * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
> - * dword because VFs don't implement the 1st dword.
> + * Wait for up to 60s for config space to return something other than -1.
> + * Intel IGD requires 300ms when an LCD panel is attached.  We use
> + * pci_bus_read_dev_vendor_id() for reading the vendor ID as it handles
> + * CRS gracefully.
>   */
>  static void pci_flr_wait(struct pci_dev *dev)
>  {
> -	int i = 0;
> +	u32 sleep = 1000, total = 0;
>  	u32 id;
> +	bool ret;
>  
>  	if (dev->is_virtfn) {
>  		msleep(100);
>  		return;
>  	}
>  
> +	/* don't touch the HW before waiting 100ms */
> +	msleep(100);
> +


Wouldn't it be better as:

	msleep(100);

	if (dev->is_virtfn)
		return;

Perhaps with a spec reference in a comment why we don't care about
checking config space for the vf.

>  	do {
> -		msleep(100);
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	} while (i++ < 10 && id == ~0);
> -
> -	if (id == ~0)
> -		dev_warn(&dev->dev, "Failed to return from FLR\n");
> -	else if (i > 1)
> -		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
> -			 (i - 1) * 100);
> +		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
> +						 sleep);
> +		if (ret)
> +			break;
> +		total += sleep;
> +		sleep *= 2;
> +	} while (total < 60000 && !ret);
> +
> +	if (!ret)
> +		dev_warn(&dev->dev, "Failed to return from FLR after %ds\n",
> +			 total);
> +	else if (total)
> +		dev_info(&dev->dev, "Required additional %ds to return from FLR\n",
> +			 total);
>  }

I'm not a big fan.  Nested exponential backoff is pretty nasty.  Are
there users of pci_bus_read_dev_vendor_id() that don't want a "still
trying" message?  It seems better to add that to the function than try
to wrap this bandage around it.  Thanks,

Alex
