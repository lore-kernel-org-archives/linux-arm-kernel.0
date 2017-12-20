From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Dec 2017 18:12:34 +0100
Subject: PROBLEM: Hard lockup on Armada-385 with mvebu-mbus driver
In-Reply-To: <e120203dd2d847e0844133f8fa460fa5@svr-chch-ex1.atlnz.lc> (Joshua
 Scott's message of "Tue, 19 Dec 2017 04:07:33 +0000")
References: <e120203dd2d847e0844133f8fa460fa5@svr-chch-ex1.atlnz.lc>
Message-ID: <87ind1fhml.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,
 
 On mar., d?c. 19 2017, Joshua Scott <Joshua.Scott@alliedtelesis.co.nz> wrote:

> Hard lockup on Armada-385 with mvebu-mbus driver.
>
>
> Hi,
>
>
> We've come across an issue where we get a hard lockup (no more console output, JTAG debugger unable to connect) after receiving CPU traffic from a Marvell switch-chip (connected via PCI). The issue usually occurs within a minute of beginning the traffic stream. The issue only occurs when both cores of the processor are enabled, switching to single-core, the issue is unreproducible.
>
>
> Comparing the kernel we are using (4.4.6) to the one supplied by Marvell (where the issue does not occur), we were able to narrow the minimal change to fix the issue to the following:
>
>
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index c43c3d2baf..9e6b94cdef 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -349,8 +349,6 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
>                 (attr << WIN_CTRL_ATTR_SHIFT)    |
>                 (target << WIN_CTRL_TGT_SHIFT)   |
>                 WIN_CTRL_ENABLE;
> -       if (mbus->hw_io_coherency)
> -               ctrl |= WIN_CTRL_SYNCBARRIER;
>

Without this then you have no more assurance that the dma transfer will
be coherent. I might be wrong but I am pretty sure it was the reason of
this bit. In the vendor kernel there are other changes around the MMU
configuration (that are not possible in mainline) that allow to not use
this bit. Maybe Thomas will be able to say more about it.


>         writel(base & WIN_BASE_LOW, addr + WIN_BASE_OFF);
>         writel(ctrl, addr + WIN_CTRL_OFF);
> @@ -1082,10 +1080,6 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
>         mbus->soc->setup_cpu_target(mbus);
>         mvebu_mbus_setup_cpu_target_nooverlap(mbus);
>  
> -       if (is_coherent)
> -               writel(UNIT_SYNC_BARRIER_ALL,
> -                      mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
> -
>         register_syscore_ops(&mvebu_mbus_syscore_ops);
>  
>         return 0;
>
>
> While we're not currently running the latest upstream kernel, it does appear that the offending lines above are still present in the latest upstream kernel. We're not yet sure exactly why this fixes the issue, but on our platform at least it does resolve the issue we were seeing.
>
>
> The main purpose of this email is to get the ball rolling on having
> this fix upstreamed, and perhaps to hear back from anyone involved
> with this code.


Recently I submitted some fixes in the dts to configure the L2 cache in
order to avoid the hard lockup. Did you try it?

cda80a82ac3e ("ARM: dts: mvebu: pl310-cache disable double-linefill")

It was merged at the end of the 4.14-rc released and is part of the 4.14
release now.

This patch is very ea sly backportable.

Gregory

>
>
>
> Cheers,
>
> Joshua Scott
>
>
>
> Environment:
>
>
> [root at awplus flash]# cat /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 1 (v7l)
> BogoMIPS        : 50.00
> Features        : half thumb fastmult vfp edsp vfpv3 tls vfpd32
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x4
> CPU part        : 0xc09
> CPU revision    : 1
>
> processor       : 1
> model name      : ARMv7 Processor rev 1 (v7l)
> BogoMIPS        : 50.00
> Features        : half thumb fastmult vfp edsp vfpv3 tls vfpd32
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x4
> CPU part        : 0xc09
> CPU revision    : 1
>
> Hardware        : Marvell Armada 380/385 (Device Tree)
> Revision        : 0000
> Serial          : 0000000000000000
>
>
>
> [root at awplus flash]# cat /proc/modules
> tipc 115327 248 - Live 0x7f0c3000
> ip6_udp_tunnel 1679 1 tipc, Live 0x7f0bf000
> udp_tunnel 2053 1 tipc, Live 0x7f0bb000
> br_netfilter 12045 0 - Live 0x7f0b5000
> sha256_generic 8941 0 - Live 0x7f0af000
> jitterentropy_rng 5909 0 - Live 0x7f0aa000
> echainiv 2007 0 - Live 0x7f0a6000
> drbg 13108 0 - Live 0x7f09f000
> platform_driver 98540 1 - Live 0x7f048000 (O)
> ipifwd 239474 18 platform_driver,[permanent], Live 0x7f000000 (PO)
>
>
>
> [root at awplus flash]# cat /proc/ioports
> 00001000-000fffff : PCI I/O
>
>
>
> [root at awplus flash]# cat /proc/iomem
> 00000000-3fffffff : System RAM
>   00008000-00628aab : Kernel code
>   00666000-006b3087 : Kernel data
> a0000000-dfffffff : PCI MEM
>   a0000000-a5ffffff : PCI Bus 0000:01
>     a0000000-a3ffffff : 0000:01:00.0
>       a0000000-a3ffffff : prestera
>     a4000000-a47fffff : 0000:01:00.0
>       a4000000-a47fffff : prestera
>     a4800000-a48fffff : 0000:01:00.0
>       a4800000-a48fffff : prestera
> f1010410-f1010417 : /soc/devbus-cs1
> f1010680-f10106cf : /soc/internal-regs/spi at 10680
> f1011000-f101101f : /soc/internal-regs/i2c at 11000
> f1012000-f101201f : serial
> f1018000-f101801f : /soc/internal-regs/pinctrl at 18000
> f1018100-f101813f : /soc/internal-regs/gpio at 18100
> f1018140-f101817f : /soc/internal-regs/gpio at 18140
> f1020704-f1020707 : /soc/internal-regs/watchdog at 20300
> f1020800-f102080f : /soc/internal-regs/cpurst at 20800
> f1020a00-f1020ccf : /soc/internal-regs/interrupt-controller at 20a00
> f1021070-f10210c7 : /soc/internal-regs/interrupt-controller at 20a00
> f1022000-f1022fff : /soc/internal-regs/pmsu at 22000
> f1058000-f10584ff : /soc/internal-regs/usb at 58000
> f1080000-f1081fff : /soc/pcie-controller/pcie at 1,0
> f10d0000-f10d0053 : /soc/internal-regs/flash at d0000
> f4800000-f487ffff : f4800000.nvs
>
>
> [root at awplus flash]# lspci -vvv
> 00:01.0 Class 0604: Device 11ab:6820 (rev 04)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff [empty]
>         Memory behind bridge: a0000000-a5ffffff [size=96M]
>         Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported ARIFwd-
>                 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 AtomicOpsCtl: ReqEn- EgressBlck-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>
> 01:00.0 Class 0200: Device 11ab:c804
>         Subsystem: Device 11ab:11ab
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 101
>         Region 0: Memory at a4800000 (64-bit, prefetchable) [size=1M]
>         Region 2: Memory at a0000000 (64-bit, prefetchable) [size=64M]
>         Region 4: Memory at a4000000 (64-bit, prefetchable) [size=8M]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <1us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <256ns, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF Not Supported
>                 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                 AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Kernel driver in use: ATL Marvell CPSS PCI
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
