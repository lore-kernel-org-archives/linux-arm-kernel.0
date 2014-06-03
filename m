From: holgerschurig@gmail.com (Holger Schurig)
Date: Tue, 3 Jun 2014 17:45:16 +0200
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
 <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
 <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <CAOpc7mHHOmEcvnSDTc+9eyCtLyMBvR2aU36XFcddT4pa0f2KOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for you help.

Okay, first I enabled SION, I used MX6QDL_PAD_GPIO_16__ENET_REF_CLK
0x4001b0a8. Barebox still worked, Linux not.

As soon as I set GPR1[21], Barebox can no longer boot via TFTP:

barebox:/ initrd
Kernel + Initrd via TFTP
eth0: error frame: 0x4c226028 0x00000804
T eth0: error frame: 0x4c226048 0x00000804
T eth0: error frame: 0x4c226050 0x00000810
T eth0: error frame: 0x4c226098 0x00000804
T error: First block is not block 1 (2)
could not open /mnt/image/boot/initrd.img.gz: Invalid argument
handler failed with: Invalid argument
barebox:/


Also, it looks like Linux itself sets this bit, don't know where.
Because after barebox couldn't boot via TFTP anymore, I changed
barebox back to not set it:

barebox:/ md 0x20e0004+4
020e0004: ff0d001b                                           ....
barebox:/ initrd
Kernel + Initrd via TFTP

Loading ARM Linux zImage '/mnt/linux/arch/arm/boot/zImage'
OS image not yet relocated
Loading initrd GZIP compressed '/mnt/image/boot/initrd.img.gz'
initrd image not yet relocated
Passing control to ARM zImage handler
no OS load address, defaulting to 0x10708000
no initrd load address, defaulting to 0x109ca000
commandline: console=ttymxc0,115200n8 quiet root=/dev/ram rdinit=/sbin/init

Starting kernel at 0x10708000, initrd at 0x109ca000, oftree at 0x10a9b000...

/ # devmem 0x20e0004
0xFF2D301B


Here, Barebox shows it's not set, and Linux (busybox' devmem command)
show that it's set. I did the obvious thing and cleared that bit in
Linux (via devmem 0x20e0004 32 0xFF0D301B), but that didn't make
"ifconfig eth0 192.168.233.198" work, in both cases the same error
messages:

fec 2188000.ethernet eth0: MDIO write timeout
fec 2188000.ethernet eth0: MDIO read timeout
fec 2188000.ethernet eth0: MDIO write timeout
fec 2188000.ethernet eth0: could not attach to PHY
ifconfig: SIOCSIFFLAGS: Connection timed out


I wonder if I need to turn on this anatop clock?  How?
