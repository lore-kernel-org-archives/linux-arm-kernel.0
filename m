From: eric@anholt.net (Eric Anholt)
Date: Wed, 23 Mar 2016 18:52:33 -0700
Subject: RPi3 arm64 port status
Message-ID: <87lh58k5ge.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I spent today working on getting aarch64 working on the Raspberry Pi 3.
Here's what I've got so far:

U-Boot branch mostly based on srwarren's work:
https://github.com/anholt/u-boot/tree/rpi_dev

(Check the commit messages there for necessary config.txt contents)

My linux tree:
https://github.com/anholt/linux/tree/bcm2837-64

Linux is booting to the point of initializing MMC.  As of recently, I'm
seeing MMC hangs at boot, and I haven't tracked down what's changed.

I haven't implemented SMP yet.  Just like the 2836, the firmware has the
secondaries spinlooping in a little bit of firmware memory, watching a
channel of the the inter-processor mailboxes.  When the secondary sees
the channel get a value, it jumps to it.  This is the same on the new
64-bit chips, even though the register we're communicating through is
only 32 bits.

So, in my branch I hacked smp_spin_table.c to only writel.  I was
thinking I might be able to add a DT parameter (cpu-release-size = <4>?
cpu-release-size-32?) to control using writel vs writeq.  However, I'm
getting weird IPIs immediately after:

[    0.795797] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.959619] release addr 0x000000004000009c
[    1.041792] CPU0: Unknown IPI message 0x11
[    1.121542] CPU0: Unknown IPI message 0x13
[    1.201522] CPU0: Unknown IPI message 0x16
[    1.281106] CPU0: Unknown IPI message 0x17
[    1.361320] CPU0: Unknown IPI message 0x19
[    1.440721] CPU0: Unknown IPI message 0x1b
[    1.521121] release addr 0x00000000400000ac
[    1.603336] CPU0: Unknown IPI message 0x11
[    1.683298] CPU0: Unknown IPI message 0x13
[    1.763220] CPU0: Unknown IPI message 0x16
[    1.842886] CPU0: Unknown IPI message 0x17
[    1.922792] CPU0: Unknown IPI message 0x19
[    2.002674] CPU0: Unknown IPI message 0x1b
[    2.082831] release addr 0x00000000400000bc
[    2.164807] CPU0: Unknown IPI message 0x11
[    2.245091] CPU0: Unknown IPI message 0x13
[    2.325265] CPU0: Unknown IPI message 0x16
[    2.405086] CPU0: Unknown IPI message 0x17
[    2.485416] CPU0: Unknown IPI message 0x19
[    2.565068] CPU0: Unknown IPI message 0x1b
[    2.645891] ASID allocator initialised with 65536 entries
[    2.784436] EFI services will not be available.
[    3.916963] CPU1: failed to come online
[    5.026662] CPU2: failed to come online
[    6.136777] CPU3: failed to come online
[    6.211751] Brought up 1 CPUs
[    6.269406] SMP: Total of 1 processors activated.
[    6.361572] CPU: All CPU(s) started at EL2

so something's still broken.

With MMC drivers disabled, I get to the point of trying NFS root
mounting, except that DWC2 hasn't found the network adapter (there's a
probe of a root hub, then nothing else).  It's not clear if this is a
64-bit specific problem or what.

Just thought people might like to know how things are going for aarch64
on the Pi.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/182665fe/attachment.sig>
