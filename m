From: olivier.barthel@gmail.com (Olivier Barthel)
Date: Fri, 17 Sep 2010 16:02:09 +0200
Subject: i.mx25 :trouble with serial flow hardware
In-Reply-To: <20100917095343.GB3119@pengutronix.de>
References: <AANLkTikb56gj78izBMhG2kL-mFOis9L0zk_kCYN5Gk6H@mail.gmail.com>
	<20100917095343.GB3119@pengutronix.de>
Message-ID: <AANLkTimeOPCtDfcgFtxy=POjtSiG9A7nbcMQ5_=aN+Y4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,
patch over kernel provided by Karo electronics.
Regards,
Olivier
---
diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index dd05872..35669ce 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -338,11 +338,12 @@ static inline void imx_transmit_buffer(struct
imx_port *sport)
 	while (!(readl(sport->port.membase + UTS) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
+        if (uart_circ_empty(xmit))
+            break;
 		writel(xmit->buf[xmit->tail], sport->port.membase + URTX0);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
+		
 	}

 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
---

2010/9/17 Wolfram Sang <w.sang@pengutronix.de>:
> Hi,
>
> On Wed, Sep 15, 2010 at 05:38:58PM +0200, Olivier Barthel wrote:
>
>> I think the problem is in the function imx_transmit_buffer of file
>> imx.c when this function is called by imx_start_tx called by
>> uart_handle_cts_change. It consumes a character in the ring buffer
>> (tail=tail+1) before testing whether the buffer is empty (tail=head?)
>> or not. In the next loop, the function detects 4095 items in the
>> circular buffer.
>> By moving the test before reading of ring buffer, the problem is
>> apparently corrected.
>
> Sounds reasonable. Can you send a patch? It is easier to review code.
>
> Thanks,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkyTOqcACgkQD27XaX1/VRtwAACbBx7HSaMB78SMyiquwSghJU3f
> omoAoLvWfdJsFKK2dcfjvnRoX8rExebH
> =fxNi
> -----END PGP SIGNATURE-----
>
>
