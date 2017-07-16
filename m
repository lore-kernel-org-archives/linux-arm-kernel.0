From: vesa.jaaskelainen@vaisala.com (=?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?=)
Date: Sun, 16 Jul 2017 23:00:54 +0300
Subject: [RFC PATCH 0/2] device tree support for board revision
Message-ID: <1500235256-48937-1-git-send-email-vesa.jaaskelainen@vaisala.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Privously without using device trees system revision was carried over ATAGs.
Now with device tree system revision information is not carried at all. This
RFC proposes a method for this.

With ARM arch system revision information (as 4 digit hex string) has been
available in /proc/cpuinfo.

Respective change is needed to boot loader to provide board revision. U-boot
provides board_rev environment variable that holds string version of board
revision information.

With BeagleBone Black I was able to get following /proc/cpuinfo output:

processor       : 0
model name      : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 996.14
Features        : half thumb fastmult vfp edsp thumbee neon vfpv3 tls vfpd32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : Generic AM33XX (Flattened Device Tree)
Revision        : 000B
Serial          : 1614BBBK1211

Note: I set board_serial to serial# in u-boot to get serial number.

Reason why I deviced to go RFC approach was that there is kinda definition
problem here and possibilty that it might be a good idea to define more
than one field to device tree. Also there seems to be multiple ways that
people try to workaround the issues so it would be a good idea to
standardize the interfaces a bit.

One problem here is that what does actually those fields mean in
/proc/cpuinfo?

What does "Revision" mean? Does it mean board revision, device revision or
system revision?

Same goes for "Serial". Does it mean board serial, device serial or system
serial?

I see that "board" here would mean PCB or SoM module whose manufacturer
defines model name, serial number and revision.

Then we have "device" scope which I would see that it means PCB and chasis
of the device, and in chasis you might have label with information like
device model, serial number and revision. One device can consist of one or
more boards.

Then we have "system" scope which I would see that it means collection of
devices. System might have model and serial number (haven't seen one with
revision thou). It might be that "system" level is out-of-scope for device
tree interface level.

It may be that /proc/cpuinfo is wrong place to display this information but
as a result of this discussion I would like to see the standard way to pass
this information as it might be that bootloader can only access the
information (in case of multipurpose pin in chip). And the standard way for
user space to access this information.

Thanks,
Vesa J??skel?inen

Vesa J??skel?inen (2):
  Documentation: devicetree: root node board-revision property
    documentation
  arm: setup: Show the board revision from devicetree in cpuinfo

 Documentation/devicetree/booting-without-of.txt |  1 +
 arch/arm/kernel/setup.c                         | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.1.4
