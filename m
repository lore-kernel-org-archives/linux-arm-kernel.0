From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 13:56:32 -0400 (EDT)
Subject: Git pull request: support the appending of a DTB to zImage
Message-ID: <alpine.LFD.2.00.1109141311340.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

	git://git.linaro.org/people/nico/linux zImage_DTB_append

This series enables the concatenation of a zImage and a DTB file 
together, and a compatibility wrapper converting some ATAGs into DT 
properties, for systems with a bootloader that cannot accommodate the 
normal passing of a device tree.

This code has been around for quite a while, with a couple revisions 
posted and commented on the mailing list.  This is in use by a couple 
platforms moving to DT already.

I was hoping to clean the Makefile part a bit with the use of some new 
Kbuild feature, but that is not in mainline yet, and it is not clear if 
that would work correctly in this case, so I prefer revisiting that part 
later if a good way to improve the build really shows up.

Based on v3.1-rc4 for the next merge window.

John Bonesio (1):
      ARM: zImage: Allow the appending of a device tree binary

Nicolas Pitre (5):
      ARM: zImage: ensure it is always a multiple of 64 bits in size
      ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
      ARM: zImage: gather some string functions into string.c
      ARM: zImage: allow supplementing appended DTB with traditional ATAG data
      ARM: zImage: prevent constant copy+rebuild of lib1funcs.S

 arch/arm/Kconfig                        |   32 ++++++
 arch/arm/boot/compressed/.gitignore     |    9 ++
 arch/arm/boot/compressed/Makefile       |   32 ++++++-
 arch/arm/boot/compressed/atags_to_fdt.c |   97 +++++++++++++++++++
 arch/arm/boot/compressed/head.S         |  121 ++++++++++++++++++++++--
 arch/arm/boot/compressed/libfdt_env.h   |   15 +++
 arch/arm/boot/compressed/misc.c         |   42 +--------
 arch/arm/boot/compressed/string.c       |  127 +++++++++++++++++++++++++
 arch/arm/boot/compressed/vmlinux.lds.in |    4 +
 9 files changed, 427 insertions(+), 52 deletions(-)
