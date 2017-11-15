From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 15 Nov 2017 17:15:15 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <yw1xr2szzie5.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
 <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com>
 <yw1xr2szzie5.fsf@mansr.com>
Message-ID: <bed48cd4-dfc3-2572-ef76-4f5b449be6e2@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2017 16:11, M?ns Rullg?rd wrote:

> Well, that's not good.  I'll see if I can replicate it later this week.

In my latest test, I started from v4.14 and only applied the
following patch:

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index e94159507847..5c109cc4bde8 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -317,6 +317,7 @@ static int nb8800_poll(struct napi_struct *napi, int budget)
 
                len = RX_BYTES_TRANSFERRED(rxd->report);
 
+               udelay(200);
                if (IS_RX_ERROR(rxd->report))
                        nb8800_rx_error(dev, rxd->report);
                else
@@ -1246,10 +1247,12 @@ static int nb8800_hw_init(struct net_device *dev)
        nb8800_writeb(priv, NB8800_PQ1, val >> 8);
        nb8800_writeb(priv, NB8800_PQ2, val & 0xff);
 
+#if 0
        /* Auto-negotiate by default */
        priv->pause_aneg = true;
        priv->pause_rx = true;
        priv->pause_tx = true;
+#endif
 
        nb8800_mc_init(dev, 0);
 
diff --git a/drivers/net/ethernet/aurora/nb8800.h b/drivers/net/ethernet/aurora/nb8800.h
index aacc3cce2cc0..a2d4b841306a 100644
--- a/drivers/net/ethernet/aurora/nb8800.h
+++ b/drivers/net/ethernet/aurora/nb8800.h
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/bitops.h>
 
-#define RX_DESC_COUNT                  256
+#define RX_DESC_COUNT                  16
 #define TX_DESC_COUNT                  256
 
 #define NB8800_DESC_LOW                        4



Once I booted the SMP8759 board, I ran

ip addr add 172.27.64.23/18 brd 172.27.127.255 dev eth0
ip link set eth0 up
sleep 5
iperf3 -s


And from the PC, I ran

iperf3 -c 172.27.64.23 -u -b 0 -l 1400 -t 120


[  5] local 172.27.64.23 port 5201 connected to 172.27.64.1 port 53771
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  5.89 MBytes  49.4 Mbits/sec  0.044 ms  77062/81472 (95%)  
[  5]   1.00-2.00   sec  6.25 MBytes  52.5 Mbits/sec  0.052 ms  80112/84796 (94%)  
[  5]   2.00-3.00   sec  6.26 MBytes  52.5 Mbits/sec  0.054 ms  80112/84797 (94%)  
[  5]   3.00-4.00   sec  6.26 MBytes  52.5 Mbits/sec  0.053 ms  80128/84814 (94%)  
[  5]   4.00-5.00   sec  6.26 MBytes  52.5 Mbits/sec  0.049 ms  80112/84798 (94%)  
[  5]   5.00-6.00   sec  6.26 MBytes  52.5 Mbits/sec  0.052 ms  80096/84783 (94%)  
[  5]   6.00-7.00   sec  6.26 MBytes  52.5 Mbits/sec  0.047 ms  80096/84784 (94%)  
[  5]   7.00-8.00   sec  6.26 MBytes  52.5 Mbits/sec  0.060 ms  80128/84815 (94%)  
iperf3: OUT OF ORDER - incoming packet = 731264 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731265 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731266 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731267 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731268 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731269 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731270 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731271 and received packet = 0 AND SP = 731279
iperf3: OUT OF ORDER - incoming packet = 731272 and received packet = 0 AND SP = 731279
[  5]   8.00-9.00   sec  4.17 MBytes  35.0 Mbits/sec  0.149 ms  53104/56220 (94%)  
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  0/0 (0%)  
[  5]  10.00-11.00  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  0/0 (0%)  
[  5]  11.00-12.00  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  0/0 (0%)  
[  5]  12.00-13.00  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  0/0 (0%)  
[  5]  13.00-14.00  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  0/0 (0%)  
^C
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-17.04  sec  0.00 Bytes  0.00 bits/sec  0.149 ms  690950/731279 (94%)  
[SUM]  0.0-17.0 sec  9 datagrams received out-of-order
iperf3: interrupt - the server has terminated
# ping -c 10 172.27.64.1
PING 172.27.64.1 (172.27.64.1): 56 data bytes

--- 172.27.64.1 ping statistics ---
10 packets transmitted, 0 packets received, 100% packet loss


Given the out-of-order datagrams, I'm wondering if it's possible
for the DMA engine to overwrite a not-yet-read descriptor?

The EOC flag should stop the DMA engine though...

Maybe some kind of race...

I don't think I've been able to trigger the wedge when 256 descriptors
are used.
