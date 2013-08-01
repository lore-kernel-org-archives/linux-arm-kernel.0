From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu,  1 Aug 2013 13:36:41 +0100
Subject: [RFC] ARM: spear: remove spear13xx_secondary_startup from INIT
 section.
Message-ID: <1375360601-24591-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes spear13xx_secondary_startup fromm _INIT section, there are
two  reasons for this removal.
 1. discarding such a small code does not save much, given the RAM sizes.
 2. Having this code discarded, creates corruption issue when we boot
smp-kernel with nr_cpus=1 or with single cpu node in DT.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
Hi,

I did encounter corruption issues on STi CA9 SOCs when a SMP kernel is booted with
nr_cpus=1. This boiled down to freeing the __INIT section of the secondary
startup code. It looks like two other SOCs(Spear and ux500) might have same
issue.

Do you think this patch is valid for Spear?

Thanks,
srini

 arch/arm/mach-spear/headsmp.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
index ed85473..aad3253 100644
--- a/arch/arm/mach-spear/headsmp.S
+++ b/arch/arm/mach-spear/headsmp.S
@@ -13,8 +13,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-	__INIT
-
 /*
  * spear13xx specific entry point for secondary CPUs. This provides
  * a "holding pen" into which all secondary cores are held until we're
-- 
1.7.6.5
