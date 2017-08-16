From: davem@davemloft.net (David Miller)
Date: Tue, 15 Aug 2017 17:26:02 -0700 (PDT)
Subject: [PATCH net RESEND] PCI: fix oops when try to find Root Port
 for a PCI device
In-Reply-To: <20170815170331.GA4099@bhelgaas-glaptop.roam.corp.google.com>
References: <1502810688-12420-1-git-send-email-dingtianhong@huawei.com>
 <20170815170331.GA4099@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170815.172602.828619829770973735.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 15 Aug 2017 12:03:31 -0500

> On Tue, Aug 15, 2017 at 11:24:48PM +0800, Ding Tianhong wrote:
>> Eric report a oops when booting the system after applying
>> the commit a99b646afa8a ("PCI: Disable PCIe Relaxed..."):
>> ...
> 
>> It looks like the pci_find_pcie_root_port() was trying to
>> find the Root Port for the PCI device which is the Root
>> Port already, it will return NULL and trigger the problem,
>> so check the highest_pcie_bridge to fix thie problem.
> 
> The problem was actually with a Root Complex Integrated Endpoint that
> has no upstream PCIe device:
> 
>   00:05.2 System peripheral: Intel Corporation Device 0e2a (rev 04)
>         Subsystem: Intel Corporation Device 0e2a
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>                         ExtTag- RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal+ Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
> 
>> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
> 
> This also
> 
> Fixes: c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum")
> 
> which added pci_find_pcie_root_port().  Prior to this Relaxed Ordering
> series, we only used pci_find_pcie_root_port() in a Chelsio quirk that
> only applied to non-integrated endpoints, so we didn't trip over the
> bug.
 ...
> I think structuring the fix as follows is a little more readable:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc3456dc1..587cd7623ed8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

I've integrated all of this feedback and the other Fixes: tag and applied it
to 'net', thanks.
