From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 21 Aug 2017 09:53:56 -0400
Subject: [PATCH v11 2/4] PCI: Factor out pci_bus_wait_crs()
In-Reply-To: <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <9cb3006d-31d0-e57a-fd3e-c32914e8ba42@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/18/2017 5:32 PM, Bjorn Helgaas wrote:
> +	if ((*l & 0xffff) != 0x0001)
> +		return true;	/* not a CRS completion */
>  

This version certainly looks cleaner. However, it breaks pci_flr_wait().

If some root port doesn't support CRS and returns 0xFFFFFFFF, pci_bus_wait_crs()
function returns true. pci_flr_wait() prematurely bails out from here.


pci_flr_wait()
{

+	ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
+	if (ret)
+		return;

}

We can change the return code to false above but then we break pci_bus_read_dev_vendor_id()
function. 

That's why, I was interested in creating a pci_bus_crs_visibility_supported() helper
function that would check for the magic 0x0001 value and return true. Otherwise, false. 

pci_bus_read_dev_vendor_id() would do this

pci_bus_read_dev_vendor_id()
{
	...
	if (pci_bus_crs_visibility_supported())
		return pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);

	return true
}

Similar pattern for pci_flr_wait().


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
