From: kernel@tekno-soft.it (Roberto Fichera)
Date: Fri, 5 Feb 2016 15:59:21 +0100
Subject: XIO2001 PCIe-to-PCI bridge is not detected on custom iMX6Q board
Message-ID: <56B4B8C9.8000505@tekno-soft.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm trying to get my custom board, based on iMX6Q SoC, to detect a TI XIO2001 PCIe-to-PCI bridge without
success up to now. PCI Kernel configuration looks

CONFIG_PCI_QUIRKS=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCI_MSI=y
CONFIG_PCI_ATS=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCIE_DW=y
CONFIG_PCI_IMX6=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
CONFIG_PCIE_PME=y

I'm getting the log below when booting a kernel v4.4
 
[    0.236822] PCI host bridge /soc/pcie at 0x01000000 ranges:
[    0.236844]   No bus range found for /soc/pcie at 0x01000000, using [bus 00-ff]
[    0.236891]   err 0x01f00000..0x01f7ffff -> 0x01f00000
[    0.236929]    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.237016]   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.557284] *imx6q-pcie 1ffc000.pcie: phy link never came up*
[    0.557874] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.557902] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.557920] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
[    0.557995] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.558012] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.558137] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.558209] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.558248] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    0.558448] pci 0000:00:00.0: supports D1
[    0.558463] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.559240] PCI: bus0: Fast back to back transfers disabled
[    0.559574] PCI: bus1: Fast back to back transfers enabled
[    0.559736] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.559764] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
[    0.559786] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.560561] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    0.560591] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
[    0.561007] aer 0000:00:00.0:pcie02: service driver aer loaded
 
root at voneus-janas-imx6q:~# lspci -vvv
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 290
        Region 0: Memory@01000000 (32-bit, non-prefetchable) [size=1M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        [virtual] Expansion ROM@01100000 [disabled] [size=64K]
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                Address: 000000007d8b2000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <8us
                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
        Kernel driver in use: pcieport
 
Do you have any suggestion how to solve this?

Thanks in advance,
Roberto Fichera.
