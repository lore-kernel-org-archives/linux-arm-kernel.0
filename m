From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2016 10:26:44 +0100
Subject: [PATCH 00/12] Fixing TI Keystone2 kexec
Message-ID: <20160428092644.GX19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes are required for TI Keystone2 kexec to be functional.  TI
Keystone2 has the run-time view of physical memory above 4GiB, but with
a boot time alias below 4GiB which can only be used during the early
boot.

This means we need to translate run-time physical addresses (which the
kernel uses) to boot-time physical addresses, which, having discussed
with Eric, is what the kexec tools and kexec kernel API requires.

We publish a special set of boot time resources in /proc/iomem, which
the (modified) kexec tools look for in preference to the normal resources.
Hence, if these are found, the kexec tools make use of these resources,
and thus kexec tools use the boot-time view of physical memory.

The first three patches have been sitting in linux-next for a while.
I'm going to put the next ARM specific three into linux-next next week.

I've sent Eric over a month ago all the patches, including the kexec
tools patches, but I've heard nothing back.  I'm at a loss how to
make progress on these patches - and as I'm being hassled about this,
I'm going to be hassling the community about it, possibly with regular
re-posts until there is some progress.

 Documentation/kdump/kdump.txt     | 13 ++------
 arch/arm/boot/dts/keystone.dtsi   |  8 +++++
 arch/arm/include/asm/kexec.h      | 24 +++++++++++++++
 arch/arm/include/asm/memory.h     | 38 ++++++++++++++++++-----
 arch/arm/kernel/machine_kexec.c   |  2 +-
 arch/arm/kernel/setup.c           | 65 +++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-keystone/keystone.c |  7 +----
 arch/arm/mm/idmap.c               |  2 +-
 arch/ia64/kernel/machine_kexec.c  |  2 +-
 include/linux/kexec.h             | 42 +++++++++++++++++++++++--
 kernel/kexec.c                    |  3 +-
 kernel/kexec_core.c               | 30 +++++++++---------
 kernel/ksysfs.c                   |  4 +--
 13 files changed, 193 insertions(+), 47 deletions(-)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
