From: alexander.h.duyck@intel.com (Alexander Duyck)
Date: Mon, 05 May 2014 13:00:20 -0700
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5KEbvziVxg-9o45-chp=6U2JnW=ffk1p85GKFyWXiX8CQ@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>	<CF7EA37A.4676A%matthew.vick@intel.com>	<CAHH3p5JFc3jgeK7OFd1rtgDS3gjRdjiPr3LwwqfyKMPGSTwMWA@mail.gmail.com>	<CF7FD060.46A87%matthew.vick@intel.com>	<CAHH3p5J8V6uWEzbCoT+x-6_2x1q=nc=_oMn0qnnj113FmeuW6A@mail.gmail.com>	<9B4A1B1917080E46B64F07F2989DADD6533627A5@ORSMSX114.amr.corp.intel.com>	<CAHH3p5KEPXw5mxP-13evd774nyO5C13ky0=fCaZPCNVx1gh3Ow@mail.gmail.com>	<CAHH3p5LaRwgdECxsO4OZSdWEhGt232yj-3347kYEStP6NLg2xg@mail.gmail.com>	<5360041A.7030005@intel.com>	<CAHH3p5L6WM3FaZ19Tw9vUcsk+kERfBKnGC2BRtnftJR1pbSF7g@mail.gmail.com>	<5367AE02.8030802@intel.com>
 <CAHH3p5KEbvziVxg-9o45-chp=6U2JnW=ffk1p85GKFyWXiX8CQ@mail.gmail.com>
Message-ID: <5367EDD4.5090901@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So like I said the AER tells the tale.

Note this bit in y our AER config on the IGB NIC:
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-

You see the part that has "UESta: DLP+".  That means that there was a
Data Link protocol error if I am not mistaken.  As a result, as soon as
you turn on the Bus Master Enable the device will issue a message
indicating a Fatal Error to the root complex.  I suspect your root
complex is responding to the Fatal Error by hanging the system.

My advice would be to first find out what is causing the DLP error and
prevent it from happening.  It is likely something related to the PCIe
bus the device is connected to.

Then in the meantime you might be able to also work around the issue by
reading/writing the value from the Uncorrectable Status register back
onto itself to clear the error bit and prevent the message from being
sent.  If nothing else you can probably just write all 0xFF's via setpci
to the register to clear it.  You just need to make sure none of the
UESTa bits are set before you set the BME.

Thanks,

Alex

On 05/05/2014 11:34 AM, shiv prakash Agarwal wrote:
> 1. Below is lspci output for IGB NIC and E1000E NIC
> 2. Although we are seeing this on ARM platform, but we need to root
> cause as to why this occurs?
> 
> a) IGB NIC
> 01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
> Connection (rev 03)
>         Subsystem: Intel Corporation Ethernet Server Adapter I210-T1
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx+
>         Interrupt: pin A routed to IRQ 130
>         Region 0: Memory at 32100000 (32-bit, non-prefetchable) [size=1M]
>         Region 3: Memory at 32200000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at 12100000 [disabled] [size=1M]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [a0] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Latency L0 <2us, L1 <16us
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-, Selectable De-emphasis: -6dB
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn-
>         Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-24-64-ef
>         Capabilities: [1a0 v1] Transaction Processing Hints
>                 Device specific mode supported
>                 Steering table in TPH capability structure
>         Kernel driver in use: igb
> 
> 
> b) E1000E NIC:
> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> Connection
>         Subsystem: Intel Corporation Gigabit CT2 Desktop Adapter
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 130
>         Region 0: Memory at 32180000 (32-bit, non-prefetchable) [size=128K]
>         Region 1: Memory at 32100000 (32-bit, non-prefetchable) [size=512K]
>         Region 2: I/O ports at 1000 [disabled] [size=32]
>         Region 3: Memory at 321a0000 (32-bit, non-prefetchable) [size=16K]
>         [virtual] Expansion ROM at 12100000 [disabled] [size=256K]
>         Capabilities: [c8] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Latency L0 <128ns, L1 <64us
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
>                 Vector table: BAR=3 offset=00000000
>                 PBA: BAR=3 offset=00002000
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn-
>         Capabilities: [140 v1] Device Serial Number 68-05-ca-ff-ff-12-c3-cb
>         Kernel driver in use: e1000e
> 
> 
> 
> On Mon, May 5, 2014 at 8:58 PM, Alexander Duyck
> <alexander.h.duyck at intel.com <mailto:alexander.h.duyck@intel.com>> wrote:
> 
>     On 05/04/2014 11:55 PM, shiv prakash Agarwal wrote:
>     > + linux-arm-kernel mailing list.
>     >
>     > Thanks Alex,
>     >
>     > 1. So overall issue is any memory/config space access hangs(logs
>     above)
>     > if bus master enable bit is set on IGB NIC card,this is not observed
>     > with E1000E NIC cards on same platform.
>     >
>     > 2. Above issue is repro'able on my ARM platform, not x86 ubuntu. Not
>     > sure how much its related to ARM though.
>     >
>     > 3. I saw below differences in lspci -vvv output b/w e1000e and
>     igb, I am
>     > not sure if this has anything to do with above issue.
>     > RC config is same for both cases.
>     >
>     > IGB / E1000E
>     >
>     > Command Status: INTx+/INTx-
>     > PM Status:           NoSoftRst+/NoSoftRst-
>     > DevCap:                FLReset-/FLReset+
>     > No Dev/Link2 Cap/Sta Registers for E1000E
>     > Some differences in AER Registers
>     >
>     > 4. Any idea, if this card is verified on ARM by anybody?
>     >
> 
>     It seems like you are glossing over the obvious issue.  You said it
>     yourself, this works fine on x86.  Therefore this is likely VERY related
>     to ARM, or at least your specific ARM platform configuration.
> 
>     You also mention "some differences in the AER Registers", how about you
>     tell us what was different there since as I pointed out that could tell
>     us if there is some error the device detected that is triggering the
>     problem, or better yet could you just send us the lspci -vvv output from
>     the problem system.  That would give us much more to work with and help
>     us to understand what the issue is.
> 
>     Thanks,
> 
>     Alex
> 
> 
> 
