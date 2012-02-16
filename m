From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Thu, 16 Feb 2012 15:54:15 +0100
Subject: ARM: add xz kernel compression support
Message-ID: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset applies on Linus' tree

It adds xz support to the ARM tree. x86 already has it, so let's have it too!
My benchmarks below show that xz is better than lzma in terms of image size
and uncompression time.

My benchmarks below show that xz is better than lzma in terms of image size
and uncompression time.

lzma and xz remain pretty bad in terms of boot time, but they may be useful
in cases where RAM usage and kernel size are critical (booting on FPGAs in early
CPU design?).

However, on fast CPUs like OMAP4 with slow storage, xz is almost as good as
lzo, but uses much less space. Therefore, it can be a good compromise.

This patch and all other compression options were tested on two boards:
- OMAP4430 Panda board
- AT91SAM9623 USB-A9263 board from Calao Systems

Results on OMAP4 Panda
----------------------

Booting from MMC

Comp.           Size            Loading time    Uncompressing time      Total time
gzip            3355768         2.213376        0.501500                2.714876
lzma            2488144         1.647410        1.399552                3.046962
xz              2366192         1.566978        1.299516                2.866494
lzo             3697840         2.471497        0.160596                2.632093
None            6965644         4.626749        0                       4.626749

Results on Calao Systems USB-A9263 (AT91)
-----------------------------------------

Booting from NAND

Compression     Size            Loading time    Uncompressing time      Total time
gzip            2386936         5.843289        0.935495                6.778784
lzma            1794344         4.465542        6.513644                10.979186
xz              1725360         4.308605        4.816191                9.124796
lzo             2608624         6.351539        0.447336                6.798875
None            4647908         11.080560       0                       11.080560

Loading time: between "reading uImage" and "OK" (right before "Starting kernel")
Compression time measured by:
~/bin/grabserial -v -d /dev/ttyUSB0 -e 15 -t -m "Uncompressing Linux" -i "done," > booting-lzo.log
