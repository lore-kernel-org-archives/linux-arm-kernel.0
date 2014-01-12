From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 12 Jan 2014 21:13:10 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
Message-ID: <87eh4dot61.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Both with a LaCie 2.5" USB 3.0 Rugged Mini disk (powered by the port)
and a 3.5" SATA disk connected via an ICY DOCK MB981U3S-1S dock station
(external power), I can transfer huge files w/o issue but I get the
following when transferring small files (e.g. copy of some debian
directory to a folder on the disk):

# cp -rf /lib/ /bin/ /sbin/ /opt /var/ /usr/ test/
[  327.130045] xhci_hcd 0000:02:00.0: xHCI host not responding to stop endpoint command.
[  327.137899] xhci_hcd 0000:02:00.0: Assuming host is dying, halting host.
[  327.144644] xhci_hcd 0000:02:00.0: HC died; cleaning up
[  327.150065] usb 3-2: USB disconnect, device number 2
[  327.155190] sd 4:0:0:0: Device offlined - not ready after error recovery
[  327.170110] sd 4:0:0:0: [sdc] Unhandled error code
[  327.174921] sd 4:0:0:0: [sdc]  
[  327.178075] sd 4:0:0:0: [sdc] CDB: 
[  327.181601] end_request: I/O error, dev sdc, sector 4949712
[  327.187188] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 318767104 size 8388608 starting block 618744)
[  327.200604] Buffer I/O error on device sdc1, logical block 618458
[  327.206711] Buffer I/O error on device sdc1, logical block 618459
[  327.212818] Buffer I/O error on device sdc1, logical block 618460
[  327.218922] Buffer I/O error on device sdc1, logical block 618461
[  327.225030] Buffer I/O error on device sdc1, logical block 618462
[  327.231137] Buffer I/O error on device sdc1, logical block 618463
[  327.237240] Buffer I/O error on device sdc1, logical block 618464
[  327.243347] Buffer I/O error on device sdc1, logical block 618465
[  327.249451] Buffer I/O error on device sdc1, logical block 618466
[  327.255557] Buffer I/O error on device sdc1, logical block 618467
[  327.261717] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618782)
[  327.275162] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618812)
[  327.288603] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618842)
[  327.302043] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618872)
[  327.315483] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618902)
[  327.328922] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618932)
[  327.342362] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618962)
[  327.355803] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618992)
[  327.369243] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 619022)
[  327.390294] sd 4:0:0:0: [sdc] Unhandled error code
[  327.395102] sd 4:0:0:0: [sdc]  
[  327.398254] sd 4:0:0:0: [sdc] CDB: 
[  327.401775] end_request: I/O error, dev sdc, sector 4949952
[  327.413642] Aborting journal on device sdc1-8.
[  327.418381] EXT4-fs error (device sdc1): ext4_journal_check_start:56: Detected aborted journal
[  327.427057] EXT4-fs (sdc1): Remounting filesystem read-only
[  327.432645] EXT4-fs (sdc1): previous I/O error to superblock detected
[  327.439119] EXT4-fs (sdc1): ext4_writepages: jbd2_start: 0 pages, ino 7342793; err -30
[  327.447223] JBD2: Error -5 detected when updating journal superblock for sdc1-8.
[  327.465498] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
[  327.470799] sd 4:0:0:0: [sdc]  
[  327.476202] EXT4-fs (sdc1): I/O error while writing superblock


Previous trace is obtained on a NETGEAR ReadyNAS 102 (Marvell Armada 370
based NAS) using current 3.13.0-rc7. The NAS has a Fresco Logic FL1009
XHCI controller: 

$ uname -a
Linux proof 3.13.0-rc7.rn102-00126-g228fdc083b01-dirty #43 Sun Jan 12 15:31:22 CET 2014 armv7l GNU/Linux

$ lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 SATA controller: Marvell Technology Group Ltd. Device 9170 (rev 12)
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

$ lspci -vvvv
...
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02) (prog-if 30 [XHCI])
        Subsystem: Fresco Logic Device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 104
        Region 0: Memory at e0100000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at e0110000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory@e0111000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
                Vector table: BAR=2 offset=00000000
                PBA: BAR=4 offset=00000000
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: xhci_hcd

I decided to do the same tests with the disk connected to a NETGEAR
ReadyNAS Duo v2 (Kirkwood 88F6282 based one) with the same kernel
version. The main difference is the XHCI controller, i.e. a NEC
Corporation uPD720200 as shown below. On the Duo v2, I cannot reproduce
the issue (did the test twice), which *may* indicate the bug is somewhat
related to FL1009 controller (missing quirk, some feature the uPD720200
does not have, etc). 

$ Linux mood 3.13.0-rc7.duov2-00126-g228fdc083b01-dirty #10 Sat Jan 11 15:58:11 CET 2014 armv5tel GNU/Linux

$ lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 04)

$lspci -vvvv
...
01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 04) (prog-if 30 [XHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory@e0000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
                Vector table: BAR=0 offset=00001000
                PBA: BAR=0 offset=00001080
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
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
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Capabilities: [140 v1] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
        Capabilities: [150 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Kernel driver in use: xhci_hcd

If you have any idea, or patches, I can test those.

Cheers,

a+
