From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 26 Aug 2012 18:01:05 +0200
Subject: [PATCH 13/13] drivers/rtc/rtc-coh901331.c: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1345996865-32082-14-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
clk_enable, and clk_disable and clk_unprepare.  They make the code more
concise, and ensure that clk_unprepare is called when clk_enable fails.

A simplified version of the semantic patch that introduces calls to these
functions is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

- clk_prepare(e);
- clk_enable(e);
+ clk_prepare_enable(e);

@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I'm not sure about this.  Maybe it would be better to leave the disable and
unprepare separated, since there is no matching nearby clk_prepare.

 drivers/rtc/rtc-coh901331.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 76b2156..c8115b8 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -276,8 +276,7 @@ static void coh901331_shutdown(struct platform_device *pdev)
 
 	clk_enable(rtap->clk);
 	writel(0, rtap->virtbase + COH901331_IRQ_MASK);
-	clk_disable(rtap->clk);
-	clk_unprepare(rtap->clk);
+	clk_disable_unprepare(rtap->clk);
 }
 
 static struct platform_driver coh901331_driver = {
