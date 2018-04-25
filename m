From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Apr 2018 15:10:14 +0100
Subject: [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
In-Reply-To: <CAFXrp_djBYwrp664A8tLrqZDw=3L6w4Uadk-Rin_ZTwfE2QwGw@mail.gmail.com>
References: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
 <CAFEAcA8Q97YNKomCgkujgoY0MoES3edHoFEk_jjXGMCdzBpd9w@mail.gmail.com>
 <20180425122000.cts26gtvjuje4j7f@kamzik.brq.redhat.com>
 <CAFXrp_djBYwrp664A8tLrqZDw=3L6w4Uadk-Rin_ZTwfE2QwGw@mail.gmail.com>
Message-ID: <20180425141010.GO16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 01:47:42PM +0100, Ciro Santilli wrote:
> On Wed, Apr 25, 2018 at 1:20 PM, Andrew Jones <drjones@redhat.com> wrote:
> > On Mon, Apr 23, 2018 at 02:49:30PM +0100, Peter Maydell wrote:
> >> On 23 April 2018 at 14:41, Dave Martin <Dave.Martin@arm.com> wrote:
> >> > This is an update to a previous RFC v2 [1], to fix a problem observed by
> >> > the qemu community that causes serial input to hang when booting a
> >> > simulated system with data already queued in the UART FIFO [2].
> >> >
> >> > After discussion, I decided that the approach in [1] was over-
> >> > engineered: it tries to preserve a guarantee that people shouldn't be
> >> > relying on anyway, namely that data sent to the UART prior to kernel
> >> > boot will be received by the kernel; or more generally that data
> >> > received by the UART while the pl011 driver is not opened will be
> >> > received (either intact or at all) by the driver.
> >> >
> >> > If anyone can please test the following and let me know the results,
> >> > that would be much appreciated!
> >> >
> >> >  a) Check that you can still reproduce the bug on mainline without this
> >> >     patch.
> >> >
> >> >  b) Check whether this patch fixes the problem.
> >>
> >> Thanks. I'm cc'ing Ciro and Drew, who are the two people I
> >> recall reporting this issue to me.
> >> Link to the patch for their benefit:
> >>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573120.html
> >>
> >
> > Hi Dave,
> >
> > v3 does not resolve the issue for me. v2 does, and, fwiw, v3 applied on
> > top of v2 (i.e. applying both), still works.
> >
> 
> I also confirm that v2 + v3 on top of Linux kernel v4.16, QEMU v2.11.0
> solves the problem on arm and aarch64, otherwise if I hit Ctrl + C
> during boot my terminal become irresponsive after boot. Test setup:
> https://github.com/cirosantilli/linux-kernel-module-cheat/tree/14965a40d27c8d9d1ff5b023ace827b288a024ef

Hmmm, interesting.

Looking at the code, it looks like RXIS is explicitly cleared twice,
once in pl011_hwinit() and once in pl011_startup().  The CONFIG_POLL
code uses hwinit alone, and I'm not sure exactly what properties it
relies on.

To be most robust, perhaps we should drain the RX FIFO in both places.

Can you try applying this on top of the branch and see what happens?

Cheers
---Dave


diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 73e6f44..841afbd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1652,6 +1652,19 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
+/*
+ * RXIS is asserted only when the RX FIFO transitions from below to
+ * above the trigger threshold.  If the RX FIFO is already full to the
+ * threshold this can't happen and RXIS will now be stuck off.
+ * Unless polling the UART, use this function to drain the RX FIFO
+ * explicitly after clearing RXIS.
+ */
+static void pl011_drain_rx_fifo(struct uart_amba_port *uap)
+{
+	while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
+		pl011_read(uap, REG_DR);
+}
+
 static int pl011_hwinit(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1674,15 +1687,7 @@ static int pl011_hwinit(struct uart_port *port)
 	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
 		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
 		    uap, REG_ICR);
-
-	/*
-	 * RXIS is asserted only when the RX FIFO transitions from below
-	 * to above the trigger threshold.  If the RX FIFO is already
-	 * full to the threshold this can't happen and RXIS will now be
-	 * stuck off.  Drain the FIFO explicitly to fix this:
-	 */
-	while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
-		pl011_read(uap, REG_DR);
+	pl011_drain_rx_fifo(uap);
 
 	/*
 	 * Save interrupts enable mask, and enable RX interrupts in case if
@@ -1740,6 +1745,8 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
+	pl011_drain_rx_fifo(uap);
+
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
