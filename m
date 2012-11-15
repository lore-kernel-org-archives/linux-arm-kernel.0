From: drew_moseley@mentor.com (Moseley, Drew)
Date: Thu, 15 Nov 2012 18:09:31 +0000
Subject: [PATCH 01/10] ARM: imx6q: print silicon version on boot
In-Reply-To: <1351005779-30347-2-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <72B629D8-8CD8-42E2-91A3-CF0532B15E5F@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 23, 2012, at 11:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> i.MX6Q has 3 revisions 1.0, 1.1 and 1.2.  Print revision on boot.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
> 

Hi Shawn,

An addition to this patch to add some error checking.  Thoughts?

Drew




Add error checking to imx6q_revision()

Signed-off-by: Drew Moseley <drew_moseley@mentor.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 265c311..072e32a 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -54,9 +54,16 @@ static int imx6q_revision(void)
 
 	if (!rev) {
 		np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
+		if (!np)
+			return IMX_CHIP_REVISION_UNKNOWN;
 		base = of_iomap(np, 0);
+		if (!base) {
+			of_node_put(np);
+			return IMX_CHIP_REVISION_UNKNOWN;
+		}
 		rev =  readl_relaxed(base + IMX6Q_ANALOG_DIGPROG);
 		iounmap(base);
+		of_node_put(np);
 	}
 
 	switch (rev & 0xff) {
-- 
1.8.0
