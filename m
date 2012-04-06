From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 06 Apr 2012 14:10:38 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <4F7EE6AE.4020909@mvista.com>
References: <1333715458-13834-1-git-send-email-ijc@hellion.org.uk>
 <4F7EE6AE.4020909@mvista.com>
Message-ID: <1333717838.12209.83.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-06 at 16:50 +0400, Sergei Shtylyov wrote:
> On 06.04.2012 16:30, Ian Campbell wrote:
> > Fixes build the following error when CONFIG_KEXEC is enabled:
> 
>     Maybe "the following build error" instead?

Done.

> >    CC      arch/arm/mach-kirkwood/board-dt.o
> > arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> > arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> > arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in
> 
> > kexec.h also needs string.h.
> 
>     Why it doesn't include it?

Not sure, but actually I should be using linux/kexec.h not asm/kexec.h
anyway which solves the problem too:

8<------------------------------

>From 76ef56286c1ceeceaa4c6c5ba867d9504e175382 Mon Sep 17 00:00:00 2001
From: Ian Campbell <ijc@hellion.org.uk>
Date: Fri, 6 Apr 2012 13:27:23 +0100
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include

Fixes build the following build error when CONFIG_KEXEC is enabled:
  CC      arch/arm/mach-kirkwood/board-dt.o
arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
[v2, using linux/kexec.h not asm/kexec.h]
---
 arch/arm/mach-kirkwood/board-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 1c672d9..f7fe1b9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
-- 
1.7.8.3


-- 
Ian Campbell
