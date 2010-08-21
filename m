From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 21 Aug 2010 16:24:03 +0800
Subject: [PATCH 1/3] mxc/tzic: add base address when accessing TZIC registers
In-Reply-To: <1282379045-32363-1-git-send-email-jason77.wang@gmail.com>
References: <1282379045-32363-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <1282379045-32363-2-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we call tzic_enable_wake function, the kernel will crash because
of access to an unmapped address. This is because two register
access operations forgot to add base address.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/plat-mxc/tzic.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index b3da9aa..3703ab2 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -164,8 +164,9 @@ int tzic_enable_wake(int is_idle)
 		return -EAGAIN;
 
 	for (i = 0; i < 4; i++) {
-		v = is_idle ? __raw_readl(TZIC_ENSET0(i)) : wakeup_intr[i];
-		__raw_writel(v, TZIC_WAKEUP0(i));
+		v = is_idle ? __raw_readl(tzic_base + TZIC_ENSET0(i)) :
+			wakeup_intr[i];
+		__raw_writel(v, tzic_base + TZIC_WAKEUP0(i));
 	}
 
 	return 0;
-- 
1.5.6.5
