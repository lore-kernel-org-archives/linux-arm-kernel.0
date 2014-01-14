From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 14 Jan 2014 22:54:14 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos>
Message-ID: <87bnzekz5l.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sarah,

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:

>> I can add the following:
>> 
>> 2) I just tested the copy of the small files using the ICY DOCK
>> MB981U3S-1S connected to my ReadyNAS 102 *on a 3.11.7 kernel*
>> and it completed successfully. 
>
> Please try a 3.13-rc7 kernel after running `git revert 35773dac5f86`.

I tried current 3.13.0-rc8 w/ 35773dac5f86 reverted and the result is
the same:

Powering the dock station:

[   70.530128] usb 3-1: new SuperSpeed USB device number 2 using xhci_hcd
[   70.550649] usb 3-1: New USB device found, idVendor=174c, idProduct=5106
[   70.557368] usb 3-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[   70.564529] usb 3-1: Product: AS2105
[   70.568112] usb 3-1: Manufacturer: ASMedia
[   70.572222] usb 3-1: SerialNumber: 00000000000000000000
[   70.579174] usb-storage 3-1:1.0: USB Mass Storage device detected
[   70.586379] scsi4 : usb-storage 3-1:1.0
[   71.590415] scsi 4:0:0:0: Direct-Access     ASMT     2105             0    PQ: 0 ANSI: 6
[   71.601630] sd 4:0:0:0: Attached scsi generic sg2 type 0
[   76.968663] sd 4:0:0:0: [sdc] 488281250 512-byte logical blocks: (250 GB/232 GiB)
[   76.976800] sd 4:0:0:0: [sdc] Write Protect is off
[   76.982190] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.028598]  sdc: sdc1 sdc2
[   77.035729] sd 4:0:0:0: [sdc] Attached SCSI disk


Starting the copy after mounting the disk and creating test/:

# cp -r /bin/ /lib /sbin /opt /etc /usr test/
[  398.130048] xhci_hcd 0000:02:00.0: xHCI host not responding to stop endpoint command.
[  398.137905] xhci_hcd 0000:02:00.0: Assuming host is dying, halting host.
[  398.144650] xhci_hcd 0000:02:00.0: HC died; cleaning up
[  398.150337] usb 3-1: USB disconnect, device number 2
[  398.155472] sd 4:0:0:0: Device offlined - not ready after error recovery
[  398.170111] sd 4:0:0:0: [sdc] Unhandled error code
[  398.174923] sd 4:0:0:0: [sdc]  
[  398.178076] sd 4:0:0:0: [sdc] CDB: 
[  398.181606] end_request: I/O error, dev sdc, sector 235538432
[  398.187367] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7347656 (offset 0 size 323584 starting block 29442334)
[  398.200175] Buffer I/O error on device sdc1, logical block 29442048
[  398.206457] Buffer I/O error on device sdc1, logical block 29442049
[  398.212739] Buffer I/O error on device sdc1, logical block 29442050
[  398.219016] Buffer I/O error on device sdc1, logical block 29442051
[  398.225298] Buffer I/O error on device sdc1, logical block 29442052
[  398.231579] Buffer I/O error on device sdc1, logical block 29442053
[  398.237857] Buffer I/O error on device sdc1, logical block 29442054
[  398.244137] Buffer I/O error on device sdc1, logical block 29442055
[  398.250418] Buffer I/O error on device sdc1, logical block 29442056
[  398.256696] Buffer I/O error on device sdc1, logical block 29442057
[  398.264481] sd 4:0:0:0: [sdc] Unhandled error code
[  398.269290] sd 4:0:0:0: [sdc]  
[  398.272466] sd 4:0:0:0: [sdc] CDB: 
[  398.275980] end_request: I/O error, dev sdc, sector 235538672
[  398.281744] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7347656 (offset 0 size 323584 starting block 29442364)
[  398.294606] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7347656 (offset 0 size 323584 starting block 29442383)

>> 2) on current 3.13.0-rc7 kernel (w/ Bj?rn patch applied just in case), I
>
> Which patch are you referring to?

This one:

  Commit 60e453a940ac ("USBNET: fix handling padding packet")
  added an extra SG entry in case padding is necessary, but
  failed to update the initialisation of the list. This can
  cause list traversal to fall off the end of the list,
  resulting in an oops.
  
  Fixes: 60e453a940ac ("USBNET: fix handling padding packet")
  Reported-by: Thomas Kear <thomas@kear.co.nz>
  Cc: Ming Lei <ming.lei@canonical.com>
  Signed-off-by: Bj?rn Mork <bjorn@mork.no>
  

>> just transferred 40GB through a Logitec LAN-GT JU3H3 (it is based on an
>> ASIX AX88179) connected to my ReadyNAS Duo v2 (NEC XHCI controller) at
>> an average rate of 82MB/s. Bottom line: no issue. When I try to do the
>> same on my ReadyNAS 102, I immediately get complaints:
>
> Was the ReadyNAS 102 with the Fresco Logic host running 3.13.0-rc7 as
> well?

Yes. Summary is:

 - RN102 w/ 3.11.7: OK
 - RN102 w/ 3.13-rc7: KO
 - Duo v2 w/ 3.13.0-rc7: OK

>> [  383.280429] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  383.280892] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  411.620073] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
>> [  411.620750] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  411.621727] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.066651] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
>> [  412.067233] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.068196] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.242708] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
>> [  412.243333] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.244246] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.417956] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
>> [  412.418516] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.419473] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
>> [  412.545330] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
>
> Those messages are normal.  It just means the device transferred less
> data than the host asked for, which is part of normal USB operation.
>
> Does the dock work despite the messages?

no

> Please send me the output of `sudo lspci -vvv -n` for the ReadyNAS 102
> Fresco Logic host.

# lspci -vvv -n
00:01.0 0604: 11ab:7846 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00010000-00010fff
        Memory behind bridge: e0000000-e00fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:02.0 0604: 11ab:7846 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0100000-e01fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:00.0 0106: 1b4b:9170 (rev 12) (prog-if 01 [AHCI 1.0])
        Subsystem: 1b4b:9170
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 105
        Region 0: I/O ports at 10010 [size=8]
        Region 1: I/O ports at 10020 [size=4]
        Region 2: I/O ports at 10018 [size=8]
        Region 3: I/O ports at 10024 [size=4]
        Region 4: I/O ports at 10000 [size=16]
        Region 5: Memory at e0010000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM@e0000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: d0020a04  Data: 0f10
        Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
        Kernel driver in use: ahci

02:00.0 0c03: 1b73:1009 (rev 02) (prog-if 30 [XHCI])
        Subsystem: 1b73:0000
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
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
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
