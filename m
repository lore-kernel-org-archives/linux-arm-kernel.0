From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 17:10:27 +0100
Subject: [PATCH 0/3] ARM: move cpu_resume() to .text section
Message-ID: <1427213430-28463-1-git-send-email-ard.biesheuvel@linaro.org>
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

Ard Biesheuvel (3):
  ARM: move cpu_resume() to .text section
  ARM: exynos: move resume code to .text section
  ARM: s5pv210: move resume code to .text section

 arch/arm/kernel/sleep.S       | 15 ++++++---------
 arch/arm/mach-exynos/sleep.S  |  9 +--------
 arch/arm/mach-s5pv210/sleep.S |  2 +-
 3 files changed, 8 insertions(+), 18 deletions(-)

-- 
1.8.3.2
