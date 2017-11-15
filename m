From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 15 Nov 2017 15:58:58 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <yw1xbmk4241h.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
Message-ID: <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 17:55, M?ns Rullg?rd wrote:

> Marc Gonzalez wrote:
> 
>> I will run iperf3 tests with RX_DESC_COUNT lowered to 2.
>> Would that produce conclusive results?
>> Do you have other suggestions?
> 
> Leave RX_DESC_COUNT alone but add a delay in the nb8800_poll() loop.
> That should ensure that queue is drained slowly enough for the buffers
> to run out.

Using the following patch:

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 31c3f0f10fbb..646300bb53b6 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -317,6 +317,7 @@ static int nb8800_poll(struct napi_struct *napi, int budget)
 
                len = RX_BYTES_TRANSFERRED(rxd->report);
 
+               udelay(200);
                if (IS_RX_ERROR(rxd->report))
                        nb8800_rx_error(dev, rxd->report);
                else
@@ -1416,9 +1417,9 @@ static int nb8800_probe(struct platform_device *pdev)
        netdev_info(dev, "MAC address %pM\n", dev->dev_addr);
 
        /* Auto-negotiate by default */
-       priv->pause_aneg = true;
-       priv->pause_rx = true;
-       priv->pause_tx = true;
+       priv->pause_aneg = false;
+       priv->pause_rx = false;
+       priv->pause_tx = false;
 
        priv->ops = match->data;
        priv->ops->power_down(dev);
diff --git a/drivers/net/ethernet/aurora/nb8800.h b/drivers/net/ethernet/aurora/nb8800.h
index 23fefca54804..9b59ea776e4a 100644
--- a/drivers/net/ethernet/aurora/nb8800.h
+++ b/drivers/net/ethernet/aurora/nb8800.h
@@ -7,7 +7,7 @@
 #include <linux/clk.h>
 #include <linux/bitops.h>
 
-#define RX_DESC_COUNT                  256
+#define RX_DESC_COUNT                  16
 #define TX_DESC_COUNT                  256
 
 #define NB8800_DESC_LOW                        4


I saw both tango4 and tango5 wedged... :-(

tango5:

[  5] local 172.27.64.23 port 5201 connected to 172.27.64.1 port 57415
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  6.33 MBytes  53.1 Mbits/sec  0.030 ms  73897/78442 (94%)  
[  5]   1.00-2.00   sec  6.59 MBytes  55.3 Mbits/sec  0.040 ms  76944/81675 (94%)  
[  5]   2.00-3.00   sec  6.59 MBytes  55.3 Mbits/sec  0.036 ms  76944/81675 (94%)  
[  5]   3.00-4.00   sec  6.59 MBytes  55.3 Mbits/sec  0.038 ms  76976/81708 (94%)  
[  5]   4.00-5.00   sec  6.59 MBytes  55.3 Mbits/sec  0.038 ms  76976/81708 (94%)  
[  5]   5.00-6.00   sec  6.59 MBytes  55.3 Mbits/sec  0.039 ms  76944/81675 (94%)  
[  5]   6.00-7.00   sec  6.59 MBytes  55.3 Mbits/sec  0.042 ms  76941/81674 (94%)  
[  5]   7.00-8.00   sec  6.59 MBytes  55.3 Mbits/sec  0.048 ms  76976/81707 (94%)  
[  5]   8.00-9.00   sec  6.59 MBytes  55.3 Mbits/sec  0.041 ms  76928/81660 (94%)  
[  5]   9.00-10.00  sec  6.59 MBytes  55.3 Mbits/sec  0.039 ms  76960/81692 (94%)  
[  5]  10.00-10.04  sec   279 KBytes  55.1 Mbits/sec  0.094 ms  3088/3284 (94%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  0.00 Bytes  0.00 bits/sec  0.094 ms  769574/816900 (94%)  
^Ciperf3: interrupt - the server has terminated
# ping -c 10 172.27.64.1
PING 172.27.64.1 (172.27.64.1): 56 data bytes

--- 172.27.64.1 ping statistics ---
10 packets transmitted, 0 packets received, 100% packet loss


tango4:

[  5] local 172.27.64.23 port 5201 connected to 172.27.64.1 port 52983
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  6.24 MBytes  52.3 Mbits/sec  0.035 ms  74019/78498 (94%)  
[  5]   1.00-2.00   sec  6.51 MBytes  54.6 Mbits/sec  0.046 ms  77024/81702 (94%)  
[  5]   2.00-3.00   sec  6.51 MBytes  54.7 Mbits/sec  0.050 ms  77024/81703 (94%)  
[  5]   3.00-4.00   sec  6.51 MBytes  54.7 Mbits/sec  0.050 ms  77024/81703 (94%)  
[  5]   4.00-5.00   sec  6.52 MBytes  54.7 Mbits/sec  0.052 ms  77024/81705 (94%)  
[  5]   5.00-6.00   sec  6.52 MBytes  54.7 Mbits/sec  0.037 ms  76960/81640 (94%)  
[  5]   6.00-7.00   sec  6.52 MBytes  54.7 Mbits/sec  0.043 ms  77008/81689 (94%)  
[  5]   7.00-8.00   sec  6.52 MBytes  54.7 Mbits/sec  0.050 ms  77024/81704 (94%)  
[  5]   8.00-9.00   sec  6.52 MBytes  54.7 Mbits/sec  0.045 ms  77024/81705 (94%)  
[  5]   9.00-10.00  sec  6.52 MBytes  54.7 Mbits/sec  0.043 ms  77008/81688 (94%)  
[  5]  10.00-10.04  sec   275 KBytes  54.5 Mbits/sec  0.103 ms  3040/3233 (94%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  0.00 Bytes  0.00 bits/sec  0.103 ms  770179/816970 (94%)  
^Ciperf3: interrupt - the server has terminated
# ping -c 10 172.27.64.1
PING 172.27.64.1 (172.27.64.1): 56 data bytes

--- 172.27.64.1 ping statistics ---
10 packets transmitted, 0 packets received, 100% packet loss


More tests needed...
