From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 15:18:41 +0200
Subject: [PATCH 0/2] arm64: restrict initrd placement to guarantee linear
 region coverage
Message-ID: <1459343923-16283-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit a7f8de168ace ("arm64: allow kernel Image to be loaded anywhere
in physical memory"), we need to take some extra care to ensure that the linear
region covers the kernel image if the [disjoint] placement of system RAM in
the physical address space spans a larger distance than we can cover with the
linear mapping.

A related issue, which is not currently covered, may occur if the kernel Image
is loaded high up in physical memory while the initrd is placed close to the
beginning of memory, in a way that does not allow the linear mapping to cover
both entirely. This will currently go undetected by relocate_initrd(), and will
crash the kernel as soon as it tries to access the initrd contents.

Rather than updating relocate_initrd() to deal with this case as well, this
series replaces it with
a) a new arm64 boot protocol requirement to place the kernel Image and the
   initrd within a reasonable distance of each other, so that the linear region
   issue described above can no longer occur,
b) code to add back the memory covered by the initrd if it was removed from the
   linear region due to a mem= kernel command line parameter, which is the use
   case relocate_initrd() was designed to address in the first place.

This way, we can remove relocate_initrd() entirely, and simply rely on the
placement of initrd by the bootloader. The only side effect is that the mem=
limit could be relaxed somewhat (i.e., by the size of the initrd) if the initrd
is placed outside of the memory that is covered by the mem= parameter. This is
entirely under the control of the bootloader, and if this is a concern, the
bootloader should pass mem= and initrd= arguments which are mutually consistent.

Ard Biesheuvel (2):
  arm64: add the initrd region to the linear mapping explicitly
  arm64: remove the now unneeded relocate_initrd()

 Documentation/arm64/booting.txt |  4 ++
 arch/arm64/kernel/setup.c       | 64 --------------------
 arch/arm64/mm/init.c            | 29 +++++++++
 3 files changed, 33 insertions(+), 64 deletions(-)

-- 
2.5.0
