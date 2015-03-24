From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 18:52:26 +0100
Subject: [PATCH v2 0/4] ARM veneer and .text/.data fixes for large kernels
Message-ID: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of the ARM sleep.S files put the resume code in the data
section. This was originally done for convenience, so that the
data it touches is always in range of a simple 'adr' PC relative
reference. However, code in the data section is problematic for
large kernels, where branched go out of range and the linker
is unaware that the contents of .data are in fact executable code
for which it could emit veneers.

So instead, move everything back to .text, and fix up the one
remaining straight adr reference by changing it into an explicit
PC relative reference.

Note that we could probably drop the b_far/bl_far patches if we
merge these patches instead.

Now includes the PIC veneer patch with Nico's ack added.

Ard Biesheuvel (4):
  ARM: force linker to use PIC veneers
  ARM: move cpu_resume() to .text section
  ARM: exynos: move resume code to .text section
  ARM: s5pv210: move resume code to .text section

 arch/arm/Makefile             |  2 +-
 arch/arm/kernel/sleep.S       | 15 ++++++---------
 arch/arm/mach-exynos/sleep.S  | 23 +++++++++++++----------
 arch/arm/mach-s5pv210/sleep.S |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

-- 
1.8.3.2
