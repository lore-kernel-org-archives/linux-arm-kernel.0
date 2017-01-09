From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon,  9 Jan 2017 22:47:32 +0530
Subject: [PATCH] ARM: prima2: constify reset_control_ops structures
Message-ID: <1483982252-5027-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare reset_control_ops structures as const as they are only stored
in the ops field of a reset_controller_dev structure. This field is of
type const struct reset_control_ops *, so reset_control_ops structures
having this property can be declared as const.
Done using Coccinelle:

@r1 disable optional_qualifier@
identifier i;
position p;
@@
static struct reset_control_ops i at p={...};

@ok1@
identifier r1.i;
position p;
struct reset_controller_dev x;
@@
x.ops=&i at p;

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct reset_control_ops i;

File size before: arch/arm/mach-prima2/rstc.o
   text	   data	    bss	    dec	    hex	filename
    992	    236	      4	   1232	    4d0	arch/arm/mach-prima2/rstc.o

File size after: arch/arm/mach-prima2/rstc.o
   text	   data	    bss	    dec	    hex	filename
   1008	    220	      4	   1232	    4d0	arch/arm/mach-prima2/rstc.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-prima2/rstc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 7c251eb..1cdb616 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -54,7 +54,7 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static struct reset_control_ops sirfsoc_rstc_ops = {
+static const struct reset_control_ops sirfsoc_rstc_ops = {
 	.reset = sirfsoc_reset_module,
 };
 
-- 
1.9.1
