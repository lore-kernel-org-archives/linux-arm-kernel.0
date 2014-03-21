From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Mar 2014 17:32:53 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <CANBf9eNZB+BVBDkgWNxxGs-ndQ-mYCc6+bfVdS-8T-QLpSZ3GA@mail.gmail.com>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de> <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
 <20140321011843.GG7528@n2100.arm.linux.org.uk>
 <CAOMZO5A+e+mHw1EG9t983ZG_KVL_O1r5UVwUU3JBsU5yPxOBsA@mail.gmail.com>
 <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
 <CANBf9eNZB+BVBDkgWNxxGs-ndQ-mYCc6+bfVdS-8T-QLpSZ3GA@mail.gmail.com>
Message-ID: <20140321173252.GL7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 05:33:02PM +0100, Bernd Faust wrote:
> I also tried the patch, but unfortunately it doesn't work for me either.
> I get the same error as Robert Daniels. My target is a i.MX6 (Cortex A9,
> single core) running Linux Kernel version 3.10.9-rt5+

Hmm, rt kernels.  Does this happen without the rt patches applied?

> Test done:
>   Start iperf server on target
>     $ iperf -s -u &
> 
>    Let iperf client run for 10 minutes on the host
>     $ iperf -c <ip_target> -u -b 100m -t 600 -l 256
> 
>   Also start a ping from host to target, to easily detect when the error
> occurs
>     $ ping <ip_target>

Right, I've just done this here, the results aren't that good:

On the iMX6S:
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  160 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.181 port 5001 connected with 192.168.1.11 port 45248
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0-600.2 sec   109 MBytes  1.52 Mbits/sec  13.726 ms 29469735/29914906 (99%)

On my x86 laptop:

--- 192.168.1.181 ping statistics ---
617 packets transmitted, 616 received, 0% packet loss, time 616014ms
rtt min/avg/max/mdev = 0.167/0.294/8.934/0.512 ms

------------------------------------------------------------
Client connecting to 192.168.1.181, UDP port 5001
Sending 256 byte datagrams
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.11 port 45248 connected with 192.168.1.181 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-600.0 sec  7.13 GBytes   102 Mbits/sec
[  3] Sent 29914976 datagrams
[  3] Server Report:
[  3]  0.0-600.2 sec   109 MBytes  1.52 Mbits/sec  13.726 ms 29469735/29914906 (99%)

The loss is disappointing and needs further investigation, but as you
can see, none of the symptoms you have reported are present - no lockup
and no 9000ms ping times (the longest was 9ms).

This is a plain 3.14-rc7 kernel configured for preempt, without the
-rt patches.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
