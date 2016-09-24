From: fugang.duan@nxp.com (Andy Duan)
Date: Sat, 24 Sep 2016 05:13:45 +0000
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <20160923.224553.1824171056324385383.davem@davemloft.net>
References: <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
 <20160923181301.GD22965@lunn.ch>
 <bc19d934-f50b-50d6-0f4f-ecfcb8a2a1c9@nelint.com>
 <20160923.224553.1824171056324385383.davem@davemloft.net>
Message-ID: <AM4PR0401MB22609D8151C2B63CA7768A1AFFCB0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net> Sent: Saturday, September 24, 2016 10:46 AM
> To: eric at nelint.com
> Cc: andrew at lunn.ch; edumazet at google.com; Andy Duan
> <fugang.duan@nxp.com>; otavio at ossystems.com.br;
> netdev at vger.kernel.org; troy.kisky at boundarydevices.com;
> rmk+kernel at arm.linux.org.uk; cjb.sw.nospam at gmail.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: Alignment issues with freescale FEC driver
> 
> From: Eric Nelson <eric@nelint.com>
> Date: Fri, 23 Sep 2016 11:35:17 -0700
> 
> > From the i.MX6DQ reference manual, bit 7 of ENET_RACC says this:
> >
> > "RX FIFO Shift-16
> >
> > When this field is set, the actual frame data starts at bit 16 of the
> > first word read from the RX FIFO aligning the Ethernet payload on a
> > 32-bit boundary."
> >
> > Same for the i.MX6UL.
> >
> > I'm not sure what it will take to use this, but it seems to be exactly
> > what we're looking for.
> 
> +1

RACC[SHIFT16] just instructs the MAC to write two additional bytes in front of each frame received into the RX FIFO to align
the Ethernet payload on a 32-bit boundary.
Eric's patch "net: fec: support RRACC_SHIFT16 to align IP header" works fine.

For the alignment issues, that is introduced by commit 1b7bde6d6 and c259c132a in net-next tree. Before these commits, no alignment issue.

How to fix the issue:
Solution1:  to enable HW RRACC_SHIFT16 feature (test pass):
	Eric's patch  "net: fec: support RRACC_SHIFT16 to align IP header".
Solution2: include the correct prefetch() header (test pass):
	--- a/drivers/net/ethernet/freescale/fec_main.c
	+++ b/drivers/net/ethernet/freescale/fec_main.c
	@@ -59,7 +59,7 @@
	 #include <linux/pinctrl/consumer.h>
 	#include <linux/pm_runtime.h>
 	#include <linux/busfreq-imx.h>
	-#include <linux/prefetch.h>
	+#include <asm/processor.h>
Solution3: use __netdev_alloc_skb_ip_align() instead of netdev_alloc_skb(). 
	     Or: still use the previous method before commit 1b7bde6d6:
		skb = netdev_alloc_skb(ndev, pkt_len - 4 + NET_IP_ALIGN);
		skb_reserve(skb, NET_IP_ALIGN);

Comparing these solutions:
	From sw effort and performance, I think these are the similar.  Enable RRACC_SHIFT16 doesn't take extra advantage.

Correct my if I am wrong. Thanks.

Regards,
Andy
