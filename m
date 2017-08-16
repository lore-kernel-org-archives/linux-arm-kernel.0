From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Aug 2017 21:33:03 +0200
Subject: [PATCH net RESEND] PCI: fix oops when try to find Root Port for
 a PCI device
In-Reply-To: <20170815170331.GA4099@bhelgaas-glaptop.roam.corp.google.com>
References: <1502810688-12420-1-git-send-email-dingtianhong@huawei.com>
 <20170815170331.GA4099@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170816193303.GA14147@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 12:03:31PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 15, 2017 at 11:24:48PM +0800, Ding Tianhong wrote:
> > Eric report a oops when booting the system after applying
> > the commit a99b646afa8a ("PCI: Disable PCIe Relaxed..."):
> > ...
> 
> > It looks like the pci_find_pcie_root_port() was trying to
> > find the Root Port for the PCI device which is the Root
> > Port already, it will return NULL and trigger the problem,
> > so check the highest_pcie_bridge to fix thie problem.
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

I've started seeing this crash on Tegra K1 as well. Here's the device
for which it oopses:

00:02.0 PCI bridge: NVIDIA Corporation TegraK1 PCIe x1 Bridge (rev a1) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 391
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 13000000-130fffff [size=1M]
        Prefetchable memory behind bridge: 0000000020000000-00000000200fffff [size=1M]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Subsystem: NVIDIA Corporation TegraK1 PCIe x1 Bridge
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
                Address: 000000fcfffff000  Data: 0000
        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
                Mapping Address Base: 00000000fee00000
        Capabilities: [80] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
                        ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd On, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range AB, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Kernel driver in use: pcieport

> > Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
> 
> This also
> 
> Fixes: c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum")
> 
> which added pci_find_pcie_root_port().  Prior to this Relaxed Ordering
> series, we only used pci_find_pcie_root_port() in a Chelsio quirk that
> only applied to non-integrated endpoints, so we didn't trip over the
> bug.
> 
> > Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> > Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
> > Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> > ---
> >  drivers/pci/pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index af0cc34..7e2022f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -522,7 +522,8 @@ struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
> >  		bridge = pci_upstream_bridge(bridge);
> >  	}
> >  
> > -	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> > +	if (highest_pcie_bridge &&
> > +	    pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> >  		return NULL;
> >  
> >  	return highest_pcie_bridge;
> > -- 
> 
> I think structuring the fix as follows is a little more readable:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc3456dc1..587cd7623ed8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -522,10 +522,11 @@ struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
>  		bridge = pci_upstream_bridge(bridge);
>  	}
>  
> -	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> -		return NULL;
> +	if (highest_pcie_bridge &&
> +	    pci_pcie_type(highest_pcie_bridge) == PCI_EXP_TYPE_ROOT_PORT)
> +		return highest_pcie_bridge;
>  
> -	return highest_pcie_bridge;
> +	return NULL;
>  }
>  EXPORT_SYMBOL(pci_find_pcie_root_port);

In case of Tegra, dev actually points to the root port. Now if I read
the above code correctly, highest_pcie_bridge will still be NULL in that
case, which in turn will return NULL from pci_find_pcie_root_port(). But
shouldn't it really return dev?

The patch that I used to fix the issue is this:

--->8---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2c712dcfd37d..dd56c1c05614 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -514,7 +514,7 @@ EXPORT_SYMBOL(pci_find_resource);
  */
 struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
 {
-       struct pci_dev *bridge, *highest_pcie_bridge = NULL;
+       struct pci_dev *bridge, *highest_pcie_bridge = dev;
 
        bridge = pci_upstream_bridge(dev);
        while (bridge && pci_is_pcie(bridge)) {
--->8---

That works correctly if this function ends up being called on the PCIe
root port, though perhaps that's not what this function is supposed to
do. It's somewhat unclear from the kerneldoc what the function should
be doing when called on a root port device itself.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170816/43f256a9/attachment-0001.sig>
