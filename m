From: ping.bai@nxp.com (Bai Ping)
Date: Tue, 2 Feb 2016 18:01:38 +0800
Subject: [PATCH V3 5/5] ARM: imx: Add msl code support for imx6qp
In-Reply-To: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
References: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1454407298-15545-5-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6QP is a different SOC, but internally we treate it as i.MX6Q
Rev_2.0 to maximum the code reusability. The chip silicon number we
read from the ANADIG_DIGPROG is 0x630100. This patch add code to
identify it as i.MX6QP Rev_1.0 when print out the silicon version.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---

change for V3:
-- add comment for the revision trick code

 arch/arm/mach-imx/anatop.c     | 9 ++++++++-
 arch/arm/mach-imx/mach-imx6q.c | 8 ++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 231bb25..0f624d1 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -129,7 +129,14 @@ void __init imx_init_revision_from_anatop(void)
 
 	switch (digprog & 0xff) {
 	case 0:
-		revision = IMX_CHIP_REVISION_1_0;
+		/*
+		 * For i.MX6QP, most of the code for i.MX6Q can be resued,
+		 * so internally, we identify it as i.MX6Q Rev 2.0
+		 */
+		if (digprog >> 8 & 0x01)
+			revision = IMX_CHIP_REVISION_2_0;
+		else
+			revision = IMX_CHIP_REVISION_1_0;
 		break;
 	case 1:
 		revision = IMX_CHIP_REVISION_1_1;
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 3878494b..cb27d56 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -266,8 +266,11 @@ static void __init imx6q_init_machine(void)
 {
 	struct device *parent;
 
-	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
-			      imx_get_soc_revision());
+	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
+		imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
+	else
+		imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
+				imx_get_soc_revision());
 
 	parent = imx_soc_device_init();
 	if (parent == NULL)
@@ -399,6 +402,7 @@ static void __init imx6q_init_irq(void)
 static const char * const imx6q_dt_compat[] __initconst = {
 	"fsl,imx6dl",
 	"fsl,imx6q",
+	"fsl,imx6qp",
 	NULL,
 };
 
-- 
1.9.1
