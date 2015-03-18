From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Mar 2015 14:04:47 -0400
Subject: [PATCH RFC/RFT 0/6] MCPM refactoring and major backend simplification
Message-ID: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After 3 years in the field and new platforms using MCPM, it is time to
look at what can be improved.  It has become obvious that most backends
are reimplementing the same overall code structure which ought to be better
abstracted into the core code.

Things can be simplified greatly by moving all the locking handling to the
core code, leaving machine specific backend only with simple and straight
forward small operations performed under lock protection. It will no longer
be necessary for backend authors to know about all the MCPM subtleties for
their code to be "right". The low-level MCPM locking primitives could also
become private to the MCPM core which is a plus for maintenance.

The diffstat also shows a clear benefit.  Despite the addition of new
documentation, the number of removed lines is significant, especially for
backend code.

To avoid a flag day, the new scheme is introduced in parallel to the
existing backend interface. I would like for this series to hit mainline
during the next merge window, and those new backends also queued for the
next merge window could be merged in parallel even if they are not
converted yet. Then, during the next cycle those backends could be
converted over and the backward compatibility removed.

The hisi04 backend, though, is instead converted to raw SMP operations
as it currently doesn't benefit from MCPM at all and doesn't fit well
with the new backend structure.

This series can also be obtained from the following Git repository:

	http://git.linaro.org/people/nicolas.pitre/linux.git mcpm

Everything was compile tested, however runtime testing only happened
on TC2.  Reviews and test results are appreciated.

 arch/arm/common/mcpm_entry.c       | 202 +++++++++++++++++----
 arch/arm/include/asm/mcpm.h        |  65 ++++++-
 arch/arm/mach-exynos/mcpm-exynos.c | 246 ++++++--------------------
 arch/arm/mach-hisi/platmcpm.c      | 127 +++++---------
 arch/arm/mach-vexpress/dcscb.c     | 197 +++++++--------------
 arch/arm/mach-vexpress/tc2_pm.c    | 291 +++++++++----------------------
 6 files changed, 474 insertions(+), 654 deletions(-)


Nicolas
