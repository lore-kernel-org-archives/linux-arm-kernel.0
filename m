From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 14 Feb 2016 14:12:42 -0800
Subject: linux-next: arm64 no longer boots with initramfs in qemu tests
Message-ID: <20160214221242.GA23489@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

my qemu tests for arm64 fail to boot in linux-next, starting with next-20160209.
Primary error is

  VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
  Please append a correct "root=" boot option; here are the available partitions:
  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

but that doesn't mean much since I try to boot an initramfs.

A bisect attempt points to 'arm64: move kernel image to base of vmalloc area',
but that doesn't really help since some of the bisect attempts fail to build
with linker errors. Just for reference, a bisect log is attached.

Comparing console logs between 4.5-rc3 and next-20160212, one key difference is
that the kernel now displays

  Moving initrd from [88000000-889ae7ff] to [5d251000-5dbff7ff]

which was not the case before. Turns out RAM ends at 60000000, so the address
appears to be a bit odd (4.5-rc3 shows initramfs at a lower address).
My qemu test runs with 512MB RAM. If I increase the RAM size to 2G,
the "Moving" message is no longer displayed. However, I still get the same
error.

Qemu command line:

qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt \
	-nographic -smp 1 -m 512 -kernel arch/arm64/boot/Image \
	-initrd rootfs.arm64.cpio -append "console=ttyAMA0"

Configuration is defconfig. Initramfs can be copied from
	https://github.com/groeck/linux-build-test/blob/master/rootfs/arm64/rootfs.arm64.cpio

Please let me know if there is anything I can do to help tracking down
the problem.

Guenter

---
bisect log:

# bad: [64d9a3617b3b8bc0734ba97caeb433b7019c6187] Add linux-next specific files for 20160212
# good: [388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95] Linux 4.5-rc3
git bisect start 'next-20160212' 'v4.5-rc3'
# bad: [597dc9d36e8bc04941b61b26ac7aa3f8a33aba53] Merge remote-tracking branch 'sound-asoc/for-next'
git bisect bad 597dc9d36e8bc04941b61b26ac7aa3f8a33aba53
# bad: [50d4eb6f1f993ca4a3da8c0aa6b807bcf0bd502a] Merge remote-tracking branch 'hid/for-next'
git bisect bad 50d4eb6f1f993ca4a3da8c0aa6b807bcf0bd502a
# good: [b80f982a1a4a6e091235e31906fc0c1cc8c76307] Merge remote-tracking branch 'samsung-krzk/for-next'
git bisect good b80f982a1a4a6e091235e31906fc0c1cc8c76307
# bad: [5278da7e981882dbf23d8dcd5a7ce4d92ff24ba9] Merge remote-tracking branch 'nfsd/nfsd-next'
git bisect bad 5278da7e981882dbf23d8dcd5a7ce4d92ff24ba9
# bad: [d4cf2a954fb2a40acb1c91a55ccaca987fb367ea] Merge remote-tracking branch 'microblaze/next'
git bisect bad d4cf2a954fb2a40acb1c91a55ccaca987fb367ea
# good: [1bdf65407f5d226fbaf1798ffee76e5d12a6ed8e] Merge remote-tracking branch 'tegra/for-next'
git bisect good 1bdf65407f5d226fbaf1798ffee76e5d12a6ed8e
# bad: [f59ba4eb5629fc1a7afe596ab1e84720b893472b] arm64: move back to generic memblock_enforce_memory_limit()
git bisect bad f59ba4eb5629fc1a7afe596ab1e84720b893472b
# good: [a9262c0ff6c56e45e3abb901d7166b4fe2f4d285] arm64: mm: add functions to walk tables in fixmap
git bisect good a9262c0ff6c56e45e3abb901d7166b4fe2f4d285
# good: [80a5c2655c25f4f8e92bf12207d2f90f771585ac] arm64: add support for ioremap() block mappings
git bisect good 80a5c2655c25f4f8e92bf12207d2f90f771585ac
# good: [e7f7cf4021c3b711f5eec19727aa88bf7532db51] arm64: decouple early fixmap init from linear mapping
git bisect good e7f7cf4021c3b711f5eec19727aa88bf7532db51
# bad: [752af28bd7117bd877caafce1600edf69c5bd7e4] arm64: move kernel image to base of vmalloc area
git bisect bad 752af28bd7117bd877caafce1600edf69c5bd7e4
# good: [6a26b548a2c42652229d15b7b8361382f4182dfc] arm64: kvm: deal with kernel symbols outside of linear mapping
git bisect good 6a26b548a2c42652229d15b7b8361382f4182dfc
# first bad commit: [752af28bd7117bd877caafce1600edf69c5bd7e4] arm64: move kernel image to base of vmalloc area
