From: roel.kluin@gmail.com (Roel Kluin)
Date: Wed, 11 Nov 2009 17:05:46 +0100
Subject: [PATCH] pxa: make index mfp unsigned in mfp_read() and write()
Message-ID: <4AFAE0DA.6040300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When signed, it is possible in theory to pass a negative mfp,
and read/write outside the array bounds.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/plat-pxa/include/plat/mfp.h |    4 ++--
 arch/arm/plat-pxa/mfp.c              |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

I did not observe the passing of a negative mfp anywhere so this
can be considered as a cleanup. Alternatively I could introduce
a `mfp < 0' check in mfp_{read,write} instead if desired.

diff --git a/arch/arm/plat-pxa/include/plat/mfp.h b/arch/arm/plat-pxa/include/plat/mfp.h
index 22086e6..0743f4a 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -458,8 +458,8 @@ void __init mfp_init_addr(struct mfp_addr_map *map);
  * mfp_config_lpm()	- configuring all low power MFPR registers for suspend
  * mfp_config_run()	- configuring all run time  MFPR registers after resume
  */
-unsigned long mfp_read(int mfp);
-void mfp_write(int mfp, unsigned long mfpr_val);
+unsigned long mfp_read(unsigned mfp);
+void mfp_write(unsigned mfp, unsigned long mfpr_val);
 void mfp_config(unsigned long *mfp_cfgs, int num);
 void mfp_config_run(void);
 void mfp_config_lpm(void);
diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
index 9405d03..c80d0db 100644
--- a/arch/arm/plat-pxa/mfp.c
+++ b/arch/arm/plat-pxa/mfp.c
@@ -203,7 +203,7 @@ void mfp_config(unsigned long *mfp_cfgs, int num)
 	spin_unlock_irqrestore(&mfp_spin_lock, flags);
 }
 
-unsigned long mfp_read(int mfp)
+unsigned long mfp_read(unsigned mfp)
 {
 	unsigned long val, flags;
 
@@ -216,7 +216,7 @@ unsigned long mfp_read(int mfp)
 	return val;
 }
 
-void mfp_write(int mfp, unsigned long val)
+void mfp_write(unsigned mfp, unsigned long val)
 {
 	unsigned long flags;
 
