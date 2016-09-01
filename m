From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Sep 2016 19:51:33 +0200
Subject: [PATCH 4/9] serial/bcm63xx_uart: constify uart_ops structures
In-Reply-To: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1472752298-981-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for uart_ops structures that are only stored in the ops field of a
uart_port structure.  This field is declared const, so uart_ops structures
that have this property can be declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct uart_ops i at p = { ... };

@ok@
identifier r.i;
struct uart_port e;
position p;
@@
e.ops = &i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct uart_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct uart_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/bcm63xx_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5108fab..583c9a0 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -631,7 +631,7 @@ static int bcm_uart_verify_port(struct uart_port *port,
 }
 
 /* serial core callbacks */
-static struct uart_ops bcm_uart_ops = {
+static const struct uart_ops bcm_uart_ops = {
 	.tx_empty	= bcm_uart_tx_empty,
 	.get_mctrl	= bcm_uart_get_mctrl,
 	.set_mctrl	= bcm_uart_set_mctrl,
