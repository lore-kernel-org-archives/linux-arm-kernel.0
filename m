From: bones@secretlab.ca (John Bonesio)
Date: Wed, 26 Jan 2011 13:22:51 -0800
Subject: [RFC 0/2] Appended Device Tree
Message-ID: <20110126212220.6723.28773.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This not intended to be merged. This is a request for comments on the approach
being taken.

The following series implements a prototype/proof of concept for allowing a
device-tree binary (dtb) to be appended to the end of zImage. The dtb can be
appended with a command like:
   cat zImage myboard.dtb > zImage_w_dtb.

The purpose is to allow a single kernel to be built for multiple boards/systems
and allow a simple process to apply the right device tree right before the
kernel image is written into flash. This way the system that applies the
device tree doesn't have to have the full gnu compiler set installed.

The old behavior has not changed. If a dtb is not appended, the kernel will
still boot as expected.

The frst patch detects if a dtb is present at the end of the zImage and uses
it, if present. The second patch merges in a couple of key atags, if present,
into the appended device-tree, if found.

With the new kernel config option enabled, this patch adds 11400 bytes to
zImage. The kernel code itself doesn't change size.
The first patch in this series adds 96 bytes to zImage.
The second patch in this series adds 11304 bytes to zImage.

These numbers vary depending on the kernel version, probably due to alignment requirements.


---

John Bonesio (2):
      ARM:boot:device tree: Allow the device tree binary to be appended to zImage
      ARM:boot:device tree: Merge specific atags into the device tree


 arch/arm/Kconfig                  |    7 ++++
 arch/arm/boot/compressed/Makefile |   31 ++++++++++++++++---
 arch/arm/boot/compressed/atags.c  |   50 +++++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S   |   59 ++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/compressed/misc.c   |   58 +++++++++++++++++++++++++++++++++++-
 5 files changed, 196 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/compressed/atags.c

-- 
Signature
