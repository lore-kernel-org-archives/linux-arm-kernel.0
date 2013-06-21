From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jun 2013 10:05:24 -0700
Subject: [PATCHv2 3/6] sched_clock: Make ARM's sched_clock generic for
 all architectures
In-Reply-To: <201306211745.57528.arnd@arndb.de>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
 <201306211745.57528.arnd@arndb.de>
Message-ID: <20130621170523.GA14575@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21, Arnd Bergmann wrote:
> 
> This causes build failures when doing a simple merge with the arm-soc
> tree:
> 
> ==> build/clps711x_defconfig/faillog <==
> /git/arm-soc/arch/arm/mach-clps711x/common.c:37:29: fatal error: asm/sched_clock.h: No such file or directory
>  #include <asm/sched_clock.h>
>                              ^
> ==> build/imx_v6_v7_defconfig/faillog <==
> /git/arm-soc/drivers/clocksource/vf_pit_timer.c:15:29: fatal error: asm/sched_clock.h: No such file or directory
>  #include <asm/sched_clock.h>
> 
> How about adding back a temporary arch/arm/include/asm/sched_clock.h
> that only contains "#include <linux/sched_clock.h>" so we can change
> those two files after the merge and still get a bisectible history?
> 

Sounds fine. John can you add this patch on top?

----8<-----
Subject: [PATCH] sched_clock: Add temporary asm/sched_clock.h

Some new users of the ARM sched_clock framework are going through
the arm-soc tree. Before 38ff87f (sched_clock: Make ARM's
sched_clock generic for all architectures, 2013-06-01) the header
file was in asm, but now it's in linux. One solution would be to
do an evil merge of the arm-soc tree and fix up the asm users,
but it's easier to add a temporary asm header that we can remove
along with the few stragglers after the merge window is over.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/sched_clock.h | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 arch/arm/include/asm/sched_clock.h

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
new file mode 100644
index 0000000..2389b71
--- /dev/null
+++ b/arch/arm/include/asm/sched_clock.h
@@ -0,0 +1,4 @@
+/* You shouldn't include this file. Use linux/sched_clock.h instead.
+ * Temporary file until all asm/sched_clock.h users are gone
+ */
+#include <linux/sched_clock.h>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
