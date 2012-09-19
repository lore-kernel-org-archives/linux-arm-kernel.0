From: takacs.aron@infracont.hu (=?ISO-8859-2?Q?Tak=E1cs_=C1ron?=)
Date: Wed, 19 Sep 2012 09:23:44 +0200
Subject: Fwd: PXA270 flash
In-Reply-To: <505970C1.7060804@infracont.hu>
References: <505970C1.7060804@infracont.hu>
Message-ID: <50597300.1060707@infracont.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

I have the following problem:
I have been using a PXA270 based board (Toradex Colibri) with linux
-.6.35.5. Now I decided to move to linux-3.6-rc4. At first I made a
simple 'make colibri_pxa270_defconfig'+ 'make vmlinux' to build the
kernel. It builds ok, it can be started from u-boot, but it doesn't find
the onboard flash. The boot messages are the following:

[    0.697232] physmap platform flash device: 02000000 at 00000000
[    1.653417] CFI: Found no physmap-flash.0 device at location zero
[    1.664090] physmap-flash physmap-flash.0: map_probe failed

I don't know if it is related to the flash problem but there is another
interesting message right at the beginning of the boot process:

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.6.0-rc4 (roni at Roni-laptop) (gcc version
4.6.3 (S2
[    0.000000] BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc
space   <<<<<<<<<
[    0.000000] Run Mode clock: 208.00MHz (*16)
[    0.000000] Turbo Mode clock: 520.00MHz (*2.5, active)
[    0.000000] Memory clock: 208.00MHz (/2)
[    0.000000] System bus clock: 208.00MHz


When I run the 2.6.35.5 kernel on the same board, it finds the flash and
the partitions on it too.
Information: The Colibri board has two 16bit flash chips put on the
32bit bus (parallel).
I have traced down the problem to the flash probing routine
'cfi_qry_mode_on()'. With the 2.6.35.5 kernel it writes 0xf000f0 and
then 0x980098 to the flash to put it into query mode (cfi_util.c:57-58).
Then it reads (in function cfi_qry_present() at cfi_utils:37-39)
0x510051, 0x520052, 0x590059 from the flash. 51, 52, 59 are the ascii
values for 'Q', 'R', and 'Y' as expected.
In the case of the 3.6-rc4 kernel the values given to the
'__raw_writel()' function@map.h:421 are 0xf000f0 and 0x980098. It
seems to be ok.
But the values read back are: 0x510000, 0x520000, 0x590000. I think
these should be 0x510051, 0x520052, 0x590059 as are in the case of the
2.6.35.5 kernel.

Now, I am stuck with it. I have tried it with linux-3.5.4 and
linux-3.6-rc6, too. The situation is the same.
Could somebody please help me solving this? I don't know what I am doing
wrong.
Thank you for your help!

Best regards,

     ?ron

p.s.: Sorry for my poor English, I hope you understand the problem!
