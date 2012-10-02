From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Oct 2012 19:34:20 -0700
Subject: [GIT PULL 0/12] ARM: soc: updates for 3.7, first batch
In-Reply-To: <CA+55aFwoDOdKv9wcqEPkE76+w2TCz+419qp94T3_70jK9dR3-A@mail.gmail.com>
References: <1349135827-24790-1-git-send-email-olof@lixom.net>
 <CA+55aFwoDOdKv9wcqEPkE76+w2TCz+419qp94T3_70jK9dR3-A@mail.gmail.com>
Message-ID: <20121002023420.GA838@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 01, 2012 at 07:22:34PM -0700, Linus Torvalds wrote:
> On Mon, Oct 1, 2012 at 4:56 PM, Olof Johansson <olof@lixom.net> wrote:
> >
> > Here is the first batch of pull requests for arm-soc for this merge
> > window. Some of them are tiny, and we will probably start to combine
> > them into slightly larger misc branches in the future. I didn't do it
> > this time around since the dependencies between branches ended up quite
> > complex this time around.
> 
> Ok, I've merged them all. As usual, my end result is slightly
> different from yours, although the differences are pretty small.

Thanks!

>  - I added exynos4210-trats.dtb to the "dtb-$(CONFIG_ARCH_EXYNOS)"
> case in arch/arm/boot/dts/Makefile
>
>    That seemed to be the right thing, otherwise that dtb file isn't
> actually accessed from anything. Hmm?

Hmm. I know I did that edit. I've had cases where git rerere has forgotten
about edits to "new" files that were not part of the original conflict, and
I might have replayed that merge and lost it there. Thanks for catching it.

>  - Commit dbc04161048d ("ARM: OMAP: Split plat/hardware.h, use local
> soc.h for omap2+") added the line
> 
>     #include "soc.h"
> 
>    to arch/arm/mach-omap2/omap_l3_noc.c, and I left it in as it moved
> into drivers/bus/.
> 
>    My resolution is quite possibly wrong, but I didn't know what the
> right thing to do was. Please double-check.

I had a patch for this but I forgot to move the tag to include it, my local
branch with the resolutions has it since I used the branch head, not the tag,
to merge it.

The SHA is a55eb3ec0e38e2db17207b204c050fbcdf750abb. Or the patch is included
below if that's easier.

>  - non-semantic order/whitespace difference for
> CONFIG_CLKSRC_ARM_GENERIC in drivers/clocksource/Makefile.
>
>    I didn't want to mix the generic case up with the random cases.

Yes, makes sense, thanks. I wonder if the file should be sorted to reduce
conflicts on new additions soon anyway, maybe.

> Anyway, you should double-check the merges, the "soc.h" one in
> particular is suspect.

Yes, my bad for not remembering to move the tag forward. The patch is below.

Thanks!

-Olof


>From a55eb3ec0e38e2db17207b204c050fbcdf750abb Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Thu, 20 Sep 2012 16:14:25 -0700
Subject: [PATCH] drivers: bus: omap_l3: fixup merge conflict resolution

This fixes a local merge conflict resolution done wrong locally in
arm-soc for-next. soc.h was added on a cleanup branch, but the driver
was moved and the header no longer needed.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-omap2/omap_l3_noc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index f447e02..4f8f3cf 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -28,7 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#include "soc.h"
 #include "omap_l3_noc.h"
 
 /*
-- 
1.7.10.1.488.g05fbf7a
