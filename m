From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:42 +0200
Subject: [PATCH v2 00/11] Kbuild: fix -Wmissing-include-path warnings
Message-ID: <20160615154553.3177021-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This warning is enabled at "make W=1" level, and found a bunch of
actual problems in code that adds -I flags to nonexisting directories.
All of these are harmless, but clearly wrong.

Kbuild itself also adds a bunch of extra directories, including in
some cases those outside of the kernel tree (e.g. ../../include),
which can have surprising consequences.

This series fixes all the warnings I found with -Wmissing-include-dirs
enabled on ARM randconfigs and x86 allmodconfig. The non-Kbuild
patches can all be applied independently, while we probably want
the Kbuild stuff to be kept as a series, if we decide to merge them.

I have added my test patch at the end, mainly to see if the Kbuild
bot finds any other warnings on additional architectures.

	Arnd

Arnd Bergmann (11):
  Kbuild: don't add ../../ to include path
  Kbuild: avoid duplicate include path
  Kbuild: always prefix objtree in LINUXINCLUDE
  Kbuild: arch: look for generated headers in obtree
  Kbuild: don't add obj tree in additional includes
  ARM: don't include removed directories
  ARM: hide mach-*/ include for ARM_SINGLE_ARMV7M
  drm: amd: remove broken include path
  net: skfb: remove obsolete -I cflag
  rtlwifi: don't add include path for rtl8188ee
  [EXPERIMENTAL] Kbuild: enable -Wmissing-include-dirs by default

 Makefile                                                | 16 ++++++++++------
 arch/alpha/boot/Makefile                                |  2 +-
 arch/arm/Makefile                                       |  2 ++
 arch/arm/mach-mvebu/Makefile                            |  3 +--
 arch/arm/mach-realview/Makefile                         |  3 +--
 arch/arm/mach-s5pv210/Makefile                          |  2 +-
 arch/powerpc/boot/Makefile                              |  2 +-
 arch/powerpc/kvm/Makefile                               |  2 +-
 arch/s390/boot/compressed/Makefile                      |  4 ++--
 arch/um/Makefile                                        |  4 ++--
 arch/x86/boot/Makefile                                  |  2 +-
 arch/x86/realmode/rm/Makefile                           |  2 +-
 drivers/gpu/drm/amd/acp/Makefile                        |  2 --
 drivers/net/fddi/skfp/Makefile                          |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile |  2 +-
 scripts/Kbuild.include                                  |  2 +-
 scripts/Makefile.lib                                    |  7 ++++---
 17 files changed, 31 insertions(+), 28 deletions(-)

-- 
2.9.0
