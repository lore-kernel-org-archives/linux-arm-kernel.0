From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 16 Oct 2016 22:01:41 +0200
Subject: RK3288 USB issues with ath9k_htc Wi-Fi dongles on veyron devices
Message-ID: <1476648101.3885.14.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to use ath9k_htc Wi-Fi dongles with various rk3288 veyron devices,
which currently do not work.

I have a bunch of different dongles, that all work nicely with other devices.
The kernel I'm running is 4.9-rc1 and the USB connectors I'm using are linked to
OTG and HOST1 (both DWC2 controllers).

I have applied the latest version of Randy Li's patches, that fix an USB error
with these controllers. They do not fix my issue, or otherwise change the
behavior I'm seeing. The very same device running with the chromeos-3.14 kernel
works nicely and doesn't have this issue.

There are two different cases, that happen interchangeably and randomly:

1. The dongle is detected and the driver is probed but the first register reads
fail:

[??322.841142] usb 2-1: new high-speed USB device number 3 using dwc2
[??323.104591] usb 2-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
[??323.113489] usb 2-1: Direct firmware load for ath9k_htc/htc_9271-1.4.0.fw failed with error -2
[??323.122204] usb 2-1: ath9k_htc: Firmware htc_9271.fw requested
[??323.414012] usb 2-1: ath9k_htc: Transferred FW: htc_9271.fw, size: 51008
[??323.665556] ath9k_htc 2-1:1.0: ath9k_htc: HTC initialized with 33 credits
[??324.710992] ath: phy1: Timeout waiting for WMI command: WMI_REG_READ_CMDID
[??324.717899] ath: phy1: REGISTER READ FAILED: (0x4020, -110)
[??324.723525] ath: phy1: Mac Chip Rev 0x0f.3 is not supported by this driver
[??324.730416] ath: phy1: Unable to initialize hardware; initialization status: -95
[??324.737853] ath: phy1: Unable to initialize hardware; initialization status: -95
[??324.745296] ath9k_htc: Failed to initialize the device
[??324.755440] usb 2-1: ath9k_htc: USB layer deinitialized

2. The dongle is detected, the first few register reads succeed but register
reads fail as soon as the dongle enters power-saving mode:

[???68.070377] ath: phy0: Removed a station entry for VIF 0 (idx: 0)
[???68.078752] ath: phy0: Detach Interface at idx: 0
[???68.085260] ath: phy0: AWAKE -> FULL-SLEEP
[???68.090766] ath: phy0: FULL-SLEEP -> AWAKE
[???68.107512] ath: phy0: AWAKE -> FULL-SLEEP
[???68.112756] ath: phy0: Driver halt
[???68.117108] ath: phy0: Starting driver with initial channel: 2412 MHz
[???68.123577] ath: phy0: FULL-SLEEP -> AWAKE
[???69.191104] ath: phy0: Timeout waiting for WMI command: WMI_REG_READ_CMDID
[???69.197987] ath: phy0: REGISTER READ FAILED: (0x7044, -110)
[???70.231015] ath: phy0: Timeout waiting for WMI command: WMI_REG_RMW_CMDID

What could be causing these issues?

Cheers!

-- 
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161016/1b55bd2d/attachment.sig>
