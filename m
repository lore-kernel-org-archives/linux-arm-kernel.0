From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 11 Nov 2009 15:29:22 +0100
Subject: orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!)
In-Reply-To: <200911091006.15757.dk-arm-linux@gmx.de>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<20091109094958.4ba72970@marrow.netinsight.se>
	<200911091006.15757.dk-arm-linux@gmx.de>
Message-ID: <200911111529.23176.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

> Am Montag 09 November 2009 09:49:58 schrieb Simon Kagstrom:
> > On Mon, 9 Nov 2009 09:33:46 +0100
> > Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> > 
> > > Ronan Shitrit from marvell gave me the information to clear bit 2 of physical
> > > address 0xf1020100 to enable bus scanning.
> > > I don't know what this really does but it helped to get my kernel up and running.
> > 

I've tested again:

with 2.6.22.18 marvell stock kernel my fpga behing the pcie->pci bridge works as expected.
Here is the output of lscpi:

sh-3.2# uname -a
Linux DB88FXX81 2.6.22.18 #1 Wed Apr 22 20:31:28 IST 2009 armv5tejl GNU/Linux
sh-3.2#


sh-3.2# lspci -vv
00:01.0 Class 0604: Device 11ab:2211 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=240
        I/O behind bridge: 00001000-00004fff
        Memory behind bridge: e8000000-ebffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [48] Express (v1) PCI/PCI-X Bridge, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] #11ab
        Capabilities: [221] #f0e8
        Capabilities: [f1e] #2a0
        Capabilities: [e80] #187

01:08.0 Class ff00: Device 1731:0101 (rev 10)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr+ DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Region 1: I/O ports@<ignored>
        Kernel driver in use: ArtistaNET-III frame buffer driver


If I switch to mainline linux kernel (there is no difference between openrd, vanilla, orion.git kernels!) my problems start:
I have to patch openrd_init() as follows:

diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
index 77617c7..670312b 100644
--- a/arch/arm/mach-kirkwood/openrd_base-setup.c
+++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
+#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -76,9 +77,21 @@ static void __init openrd_base_init(void)

 static int __init openrd_base_pci_init(void)
 {
+       u32 cpu_config_reg;
+       void __iomem *base;
+
+       base = ioremap(0xf1020100, 4);
+       if (base)
+       {
+               cpu_config_reg = readl(base);
+               cpu_config_reg &= ~(1 << 2);
+               writel(cpu_config_reg, base);
+               printk("register 0x20100: %x\n", readl(base));
+       }
+       iounmap(base);
        if (machine_is_openrd_base())
                kirkwood_pcie_init();
-
+
        return 0;
  }
 subsys_initcall(openrd_base_pci_init);
----
to allow my system to boot up and after succesfully boot my pci device isn't reachable - without any errors / warnings!
I've enabled printk (echo 8 > /proc/sys/kernel/printk) and still no console output.


sh-3.2# uname -a
Linux DB88FXX81 2.6.32-rc6-00014-g92bdfb9-dirty #3 PREEMPT Wed Nov 11 15:10:49 CET 2009 armv5tel GNU/Linux
sh-3.2#
sh-3.2# lspci -vv
00:00.0 Class 0580: Device 11ab:6281 (rev 02)
        Subsystem: Device 11ab:11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory@<ignored> (64-bit, prefetchable)
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] Express (v1) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

00:01.0 Class 0604: Device 11ab:2211 (rev 01)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00004fff
        Memory behind bridge: e0000000-e3ffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort+ >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [48] Express (v1) PCI/PCI-X Bridge, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-

01:08.0 Class ff00: Device 1731:0101 (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr+ DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=64M]
        Region 1: I/O ports@<unassigned> [disabled]

sh-3.2#



I hope someone from marvell will help me to solve this problem. I don't want to stick with 2.6.22 kernel!

It looks like the problem during boot up will show me that something went wrong but I've absolutely no idea
how to solve this problem :(


Many thanks for helping,
Dieter


> > You have that in the functional specification for the kirkwood
> > processors:
> > 
> >   http://www.marvell.com/files/products/embedded_processors/kirkwood/FS_88F6180_9x_6281_OpenSource.pdf
> > 
> > See Appendix A for the register set and lookup address 0x20100 (the CPU
> > configuration register). Bit 2 in that register turns on/off error
> > propagation:
> > 
> >               Mbus-L Error propogation
> >               For a list of errors see "Error Handling".
> >               0 = NoErrProp: Error indications are not propagated to Mbus-L. The
> >                   transactions are completed normally.
> >               1 = ErrProp: Error indications are propagated to Mbus-L.
> > 
> > and clearing it sounds quite a bit like hiding the real problem :-).
> > 
> 
> I've seen this and you're absolutely right. Thats why I've posted!
> 
> > 
> > Probably it's best to try to find out what's causing this error (see
> > the Error Handling section of the PCIe chapter in the reference manual
> > above) so that that a proper fix can be implemented!
> 
> And here my problems are starting ;)
> How can I implement error handling for that kind of reported errors?
> I'm sorry but I've absolutely no idea.
> 
> > 
> > // Simon
> 
> Many thanks,
> Dieter
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
