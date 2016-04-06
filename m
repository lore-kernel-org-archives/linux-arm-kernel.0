From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 6 Apr 2016 08:51:42 +0000
Subject: [PATCH net-next V3 00/16] net: fec: cleanup and fixes
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB1855C389F2265E30252D62B5FF9F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Wednesday, April 06, 2016 10:26 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; Fugang Duan
> <fugang.duan@nxp.com>; lznuaa at gmail.com
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; l.stach at pengutronix.de;
> andrew at lunn.ch; tremyfr at gmail.com; gerg at uclinux.org; linux-arm-
> kernel at lists.infradead.org; johannes at sipsolutions.net;
> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
> arnd at arndb.de; Troy Kisky <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V3 00/16] net: fec: cleanup and fixes
> 
> V3 has
> 
> 1 dropped patch "net: fec: print more debug info in fec_timeout"
> 2 new patches
> 0002-net-fec-remove-unused-interrupt-FEC_ENET_TS_TIMER.patch
> 0003-net-fec-return-IRQ_HANDLED-if-fec_ptp_check_pps_even.patch
> 
> 1 combined patch
> 0004-net-fec-pass-rxq-txq-to-fec_enet_rx-tx_queue-instead.patch
> 
> The changes are noted on individual patches
> 
> My measured performance of this series is
> 
> before patch set
> 365 Mbits/sec Tx/407 RX
> 
> after patch set
> 374 Tx/427 Rx
> 

I doubt the performance data,  I validate it on i.MX6q sabresd board on the latest commit(4da46cebbd3b) in net tree.
The test log as below:

root at imx6qdlsolo:~# uname -a
Linux imx6qdlsolo 4.6.0-rc1-00318-g4da46ce #180 SMP Wed Apr 6 16:24:09 CST 2016 armv7l GNU/Linux
root at imx6qdlsolo:~# cat /sys/devices/soc0/soc_id
i.MX6Q
root at imx6qdlsolo:~# echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
root at imx6qdlsolo:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
996000
root at imx6qdlsolo:~# iperf  -s &
[1] 891
root at imx6qdlsolo:~# ------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------

root at imx6qdlsolo:~# [  4] local 10.192.242.107 port 5001 connected with 10.192.242.248 port 38409
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-20.0 sec  1.40 GBytes   602 Mbits/sec

root at imx6qdlsolo:~# iperf -c 10.192.242.248 -t 20
------------------------------------------------------------
Client connecting to 10.192.242.248, TCP port 5001
TCP window size: 43.8 KByte (default)
------------------------------------------------------------
[  3] local 10.192.242.107 port 52124 connected with 10.192.242.248 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-20.0 sec   776 MBytes   325 Mbits/sec


TCP RX performance is 602Mbps, TX is only 325Mbps,   TX path has some performance issue in net tree.
I will dig out it.


> 
> Troy Kisky (16):
>   net: fec: only check queue 0 if RXF_0/TXF_0 interrupt is set
>   net: fec: remove unused interrupt FEC_ENET_TS_TIMER
>   net: fec: return IRQ_HANDLED if fec_ptp_check_pps_event handled it
>   net: fec: pass rxq/txq to fec_enet_rx/tx_queue instead of queue_id
>   net: fec: reduce interrupts
>   net: fec: split off napi routine with 3 queues
>   net: fec: don't clear all rx queue bits when just one is being checked
>   net: fec: set cbd_sc without relying on previous value
>   net: fec: eliminate calls to fec_enet_get_prevdesc
>   net: fec: move restart test for efficiency
>   net: fec: clear cbd_sc after transmission to help with debugging
>   net: fec: dump all tx queues in fec_dump
>   net: fec: detect tx int lost
>   net: fec: create subroutine reset_tx_queue
>   net: fec: call dma_unmap_single on mapped tx buffers at restart
>   net: fec: don't set cbd_bufaddr unless no mapping error
> 
>  drivers/net/ethernet/freescale/fec.h      |  10 +-
>  drivers/net/ethernet/freescale/fec_main.c | 410 ++++++++++++++++------------
> --
>  2 files changed, 218 insertions(+), 202 deletions(-)
> 
> --
> 2.5.0
