From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 25 Jun 2016 09:20:40 -0700
Subject: orion5x: initrd fails to load due to reserved memory
Message-ID: <20160625162040.GA15367@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I ported Debian to the HP Media Vault mv2120 (based on orion5x) many
years ago.  Debian stable (jessie), based on 3.16 kernel, works fine.
A user told me a few months ago that the version of Debian currently
in development (based on 4.6) doesn't boot.

The boot loader loads the kernel to 0x400000 and the ramdisk 0x200000
after that location, i.e. at 0x600000:

Booting the image (@ 0x400000) with RamDisk (@ 0x600000)...

Unfortunately, with 4.x, this leads to:

INITRD: 0x00600040+0x00727f12 overlaps in-use memory region - disabling initrd

Interestingly, when I change the load address to 0x500000/0x700000 it
boots fine (even though this is spanning 0x600000).

I've no idea how memory management works or how to find out who is
reserving that memory region, but I'm wondering if there's some
solution.  For example, would it be possible to express somehow in the
mv2120 board file that this memory region must be available for the
boot loader?

FWIW, if someone has serial console access, this can be fixed easily
because $loadAddr is used from the u-boot environment (0x400000 is
merely the default).  However, in the past you didn't need serial
console access too boot Debian so I wonder if there's a possible
kernel fixed.  (OTOH, I don't know how many users there are left given
how old this device is.)

-- 
Martin Michlmayr
http://www.cyrius.com/
