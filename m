From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 9 Dec 2013 16:42:23 -0800
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <3010367.6CxxZ6Dpea@radagast>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <5548535.pYirbknue4@radagast>
 <CAAYSxhpR664Od7AaWZrX0rE=iDUHo0h+4=uY=gvkFps4Hz4aew@mail.gmail.com>
 <3010367.6CxxZ6Dpea@radagast>
Message-ID: <CAAYSxhraDF6T9URw0CpEig2VpnuTBNdZYL9uuw6vdPn0=X4zGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 6, 2013 at 4:59 PM, James Hogan <james.hogan@imgtec.com> wrote:

> It appears to work with ~0x20 too, and the workaround isn't getting hit (only
> tested boot and logging in - nothing fancy). I think having the printks in
> this code with the console directed at the serial must have caused
> resursion/busy problems somehow.

James,

I tested tested the code you proposed (cleaned up to avoid magic
numbers) on my hardware and it works fine.

diff --git a/drivers/tty/serial/8250/8250_dw.c
b/drivers/tty/serial/8250/8250_dw.c
index 4658e3e..5f096c7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -96,7 +96,8 @@ static void dw8250_serial_out(struct uart_port *p,
int offset, int value)
        if (offset == UART_LCR) {
                int tries = 1000;
                while (tries--) {
-                       if (value == p->serial_in(p, UART_LCR))
+                       unsigned int lcr = p->serial_in(p, UART_LCR);
+                       if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
                                return;
                        dw8250_force_idle(p);
                        writeb(value, p->membase + (UART_LCR << p->regshift));
@@ -132,7 +133,8 @@ static void dw8250_serial_out32(struct uart_port
*p, int offset, int value)
        if (offset == UART_LCR) {
                int tries = 1000;
                while (tries--) {
-                       if (value == p->serial_in(p, UART_LCR))
+                       unsigned int lcr = p->serial_in(p, UART_LCR);
+                       if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
                                return;
                        dw8250_force_idle(p);
                        writel(value, p->membase + (UART_LCR << p->regshift));


Would you mind posting this for proper review so we can get the fix in?

Thanks,
Tim Kryger
