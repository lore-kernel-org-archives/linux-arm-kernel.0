From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 2 Apr 2014 03:19:58 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140401225149.GC7528@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
Message-ID: <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote on 04/01/2014 04:51:49 PM:
>On Tue, Apr 01, 2014 at 01:38:37PM -0600, robert.daniels at vantagecontrols.com
>wrote:
>> I'm not sure where this factors in, but I originally saw this problem
>> using the Freescale 2.6.35 kernel.  The driver there exhibits this
>> problem differently, although it could very well be a different
>> problem. What I observed was that when the FEC got into this bad state
>> the driver would attempt to transmit a socket buffer but for some
>> reason the buffer would not actually get transmitted.
>>
>> The driver would continue transmitting packets until it got all the
>> way around in the ring buffer to the buffer descriptor right before
>> the one that was never transmitted.  When this buffer descriptor was
>> set to transmit you'd get a double transmit - the new packet and the
>> previously untransmitted buffer.
>>
>> This results in out-of-order packets being sent directly from the i.MX53.
>
>At initial glance, this is coherent with my idea of the FEC skipping a ring
>entry on the initial pass around.  Then when a new entry is loaded,
>
>Let's say that the problem entry is number 12 that has been skipped.
>When we get back around to entry 11, the FEC will transmit entries 11 and 12,
>as you rightly point out, and it will then look at entry 13 for the next packet.
>
>However, the driver loads the next packet into entry 12, and hits the FEC to
>transmit it.  The FEC re-reads entry 13, finds no packet, so does nothing.
>
>Then the next packet is submitted to the driver, and it enters it into entry 13,
>again hitting the FEC.  The FEC now sees the entry at 13, meanwhile the entry
>at 12 is still pending.
>
>> I hope this additional information is useful, I don't know enough
>> about these low-level networking details to contribute much but it's
>> possible that what I've seen in the 2.6.35 kernel is actually the same
>> issue that I'm seeing in the 3.14 kernel but handled better.
>
>It confirms the theory, but doesn't really provide much clues for a solution at
>the moment.
>
>However, I've had something of a breakthrough with iMX6 and half-duplex.
>I think much of the problem comes down to this ERR006358 workaround implemented
>in the driver (this apparantly doesn't affect your device.) The delayed work
>implementation, and my delayed timer implementation of the same are
>fundamentally wrong to the erratum documentation - as is the version
>implemented in the Freescale BSP.
>
>Implementing what the erratum says as an acceptable workaround improves things
>tremendously - I see iperf on a 10Mbit hub go from 1-2Mbps up to 8Mbps, though
>still with loads of collisions.  That said, I'm not that trusting of the error
>bits indicated from the FEC.
I don't have 10Mbit hub, but use ethtool to change the phy speed/duplex mode in imx6q sabresd platform:
- 100M half: work fine
- 10M half: work fine, iperf test, the tx bandwidth is 6.2 ~ 11 Mbps.

Log:
root at freescale /data/ptp-debug$ ./ethtool -s eth0 autoneg off speed 10 duplex half
root at freescale /data/ptp-debug$ PHY: 1:01 - Link is Down
root at freescale /data/ptp-debug$ PHY: 1:01 - Link is Up - 10/Half

root at freescale /data/ptp-debug$ iperf -c 10.192.242.202 -t 100 -i 1
------------------------------------------------------------
Client connecting to 10.192.242.202, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  3] local 10.192.242.124 port 52725 connected with 10.192.242.202 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec   768 KBytes  6.29 Mbits/sec
[  3]  1.0- 2.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3]  2.0- 3.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3]  3.0- 4.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3]  4.0- 5.0 sec   768 KBytes  6.29 Mbits/sec
[  3]  5.0- 6.0 sec  1.38 MBytes  11.5 Mbits/sec
[  3]  6.0- 7.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3]  7.0- 8.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3]  8.0- 9.0 sec   896 KBytes  7.34 Mbits/sec
[  3]  9.0-10.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 10.0-11.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 11.0-12.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 12.0-13.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 13.0-14.0 sec  1.38 MBytes  11.5 Mbits/sec
[  3] 14.0-15.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 15.0-16.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 16.0-17.0 sec  1.25 MBytes  10.5 Mbits/sec
[  3] 17.0-18.0 sec   512 KBytes  4.19 Mbits/sec
[  3] 18.0-19.0 sec  1.62 MBytes  13.6 Mbits/sec
[  3] 19.0-20.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 20.0-21.0 sec  1.50 MBytes  12.6 Mbits/sec
[  3] 21.0-22.0 sec   640 KBytes  5.24 Mbits/sec
[  3] 22.0-23.0 sec  1.00 MBytes  8.39 Mbits/sec
[  3] 23.0-24.0 sec  1.50 MBytes  12.6 Mbits/sec
[  3] 24.0-25.0 sec   896 KBytes  7.34 Mbits/sec
[  3] 25.0-26.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 26.0-27.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 27.0-28.0 sec  1.12 MBytes  9.44 Mbits/sec
[  3] 28.0-29.0 sec  1.00 MBytes  8.39 Mbits/sec
....

>
>The reason I mention it here is that I wonder if less wacking of the
>FEC_X_DES_ACTIVE register may help your problem.
>
>In 3.14, in the fec_enet_start_xmit function, find the "writel(0, fep->hwp +
>FEC_X_DES_ACTIVE);" and change it to:
>
>	wmb();
>
>        /* Trigger transmission start */
>        if (readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
>                writel(0, fep->hwp + FEC_X_DES_ACTIVE);
>
>and see whether that helps your problem(s).
>
So far, I don't see wmb() bring any effort on FEC.  Some years ago, we want to add wmb() before set BD "Ready" bit, but we don't find any issue without wmb(), on the contrary, it introduce more
System overhead special for Gbps networking. And now, imx6sx sillicon (sigle core), add wmb() cause tx performance drop much since cpu loading is the bottleneck. In our bsp release, we don't find
Tx watchdog timeout issue, don't find ping order reversal issue after overnight stress test.

Thanks,
Andy
