From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 00:19:32 +0000
Subject: [PATCH] Fix latest regression - pgtable.h (was: [GIT PULL v3]
	pxa: patches for v2.6.38-rc)
In-Reply-To: <20110115000215.GS15996@n2100.arm.linux.org.uk>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
	<20110114214900.GP15996@n2100.arm.linux.org.uk>
	<20110115000215.GS15996@n2100.arm.linux.org.uk>
Message-ID: <20110115001932.GT15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 12:02:15AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 09:49:00PM +0000, Russell King - ARM Linux wrote:
> > I also need to remove asm/pgtable.h from arch/arm/mach-pxa/generic.c:
> >   CC      arch/arm/mach-pxa/generic.o
> > In file included from arch/arm/include/asm/pgtable.h:461,
> >                  from arch/arm/mach-pxa/generic.c:26:
> > include/asm-generic/pgtable.h: In function ?ptep_test_and_clear_young?:
> > include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type
> 
> Looking through kautobuild, it seems this also affects
> arch/arm/mach-sa1100/generic.c too, and is a recently introduced
> regression (within the last 24 hours) in mainline.

Hmm, it not only affects PXA, SA1100, but also H720x as well.  Let's kill
all instances with one patch:

8<-----
Subject: [PATCH] ARM: Fix build regression on SA11x0, PXA, and H720x targets

Build errors similar this appeared in todays kautobuild for the above
targets:

In file included from arch/arm/include/asm/pgtable.h:461,
                 from arch/arm/mach-pxa/generic.c:26:
include/asm-generic/pgtable.h: In function 'ptep_test_and_clear_young':
include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type

None of the .c files including asm/pgtable.h with this error is using
this header, so simply remove the include.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-h720x/h7201-eval.c |    1 -
 arch/arm/mach-h720x/h7202-eval.c |    1 -
 arch/arm/mach-pxa/generic.c      |    1 -
 arch/arm/mach-sa1100/generic.c   |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-h720x/h7201-eval.c b/arch/arm/mach-h720x/h7201-eval.c
index 79f0b89..629454d 100644
--- a/arch/arm/mach-h720x/h7201-eval.c
+++ b/arch/arm/mach-h720x/h7201-eval.c
@@ -23,7 +23,6 @@
 #include <asm/types.h>
 #include <asm/mach-types.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 #include <asm/mach/arch.h>
 #include <mach/hardware.h>
 #include "common.h"
diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index cc28b1e..e9f46b6 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -23,7 +23,6 @@
 #include <asm/types.h>
 #include <asm/mach-types.h>
 #include <asm/page.h>
-#include <asm/pgtable.h>
 #include <asm/mach/arch.h>
 #include <mach/irqs.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index d6e15f7..f5d91ef 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -22,7 +22,6 @@
 
 #include <mach/hardware.h>
 #include <asm/system.h>
-#include <asm/pgtable.h>
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 59d14f0..e21f347 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -21,7 +21,6 @@
 #include <asm/div64.h>
 #include <mach/hardware.h>
 #include <asm/system.h>
-#include <asm/pgtable.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
-- 
1.6.2.5
