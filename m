From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 20 Nov 2014 18:34:01 +0100
Subject: [PATCH 6/7] host: ehci-w90x900: fix error return code
In-Reply-To: <1416504842-18548-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1416504842-18548-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1416504842-18548-7-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Return a negative error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The patches in this series are independent of each other.

 drivers/usb/host/ehci-w90x900.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-w90x900.c b/drivers/usb/host/ehci-w90x900.c
index 93d9cd6..e42a29e 100644
--- a/drivers/usb/host/ehci-w90x900.c
+++ b/drivers/usb/host/ehci-w90x900.c
@@ -75,8 +75,10 @@ static int usb_w90x900_probe(const struct hc_driver *driver,
 	__raw_writel(val, ehci->regs+PHY1_CTR);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		retval = irq;
 		goto err2;
+	}
 
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval != 0)
