From: robert.daniels@vantagecontrols.com (robert.daniels at vantagecontrols.com)
Date: Tue, 1 Apr 2014 13:38:37 -0600
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140401092638.GA10224@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
Message-ID: <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote on 04/01/2014
03:26:38 AM:

>
> Last night, I performed a different test:
>
> PC --- Gigabit switch --- 10/100Mbit hub --- 10Mbit hub --- iMX6S
>            |
>   (the rest of my network)
>
> This shows that all the (late) collisions occur in the 10Mbit domain,
> and very few in the 100Mbit domain, which puts the blame fairly
> squarely on the iMX6 side.
>
> I can see nothing wrong with the setup of the iMX6, nor of the AR8035
> phy which my board has.  Both the phy and the FEC appear to correctly
> indicate that they are configured for half-duplex with flow control
> disabled, and I've been through the iomux settings for the RGMII
> interface.
>
> So, I'm left with three possibilities:
> - the AR8035 doesn't work with half-duplex
> - there is something wrong with the signalling for carrier sense between
>   the AR8035 and the FEC.
> - the iMX6 FEC doesn't work with half-duplex
>
> It's not easy to monitor the TX_CTL and RX_CTL signals and make sense of
> them, so I can't really say what's at fault at the moment, but from what
> I can see, my hardware fails to work correctly with half-duplex
> connections.

I'm not sure where this factors in, but I originally saw this problem using
the
Freescale 2.6.35 kernel.  The driver there exhibits this problem
differently,
although it could very well be a different problem.  What I observed was
that
when the FEC got into this bad state the driver would attempt to transmit a
socket buffer but for some reason the buffer would not actually get
transmitted.
The driver would continue transmitting packets until it got all the way
around in the ring buffer to the buffer descriptor right before the one
that
was never transmitted.  When this buffer descriptor was set to transmit
you'd
get a double transmit - the new packet and the previously untransmitted
buffer.
This results in out-of-order packets being sent directly from the i.MX53.

To illustrate this, I got my i.MX53 into this bad state and then ran ping
with the
following results:

PING 192.168.1.101 (192.168.1.101) 56(84) bytes of data.
64 bytes from 192.168.1.101: icmp_seq=1 ttl=64 time=6.69 ms
64 bytes from 192.168.1.101: icmp_seq=2 ttl=64 time=0.306 ms
64 bytes from 192.168.1.101: icmp_seq=4 ttl=64 time=0.314 ms
64 bytes from 192.168.1.101: icmp_seq=5 ttl=64 time=0.325 ms
64 bytes from 192.168.1.101: icmp_seq=6 ttl=64 time=0.351 ms
64 bytes from 192.168.1.101: icmp_seq=7 ttl=64 time=0.323 ms
64 bytes from 192.168.1.101: icmp_seq=9 ttl=64 time=0.337 ms
64 bytes from 192.168.1.101: icmp_seq=10 ttl=64 time=0.319 ms
64 bytes from 192.168.1.101: icmp_seq=11 ttl=64 time=0.353 ms
64 bytes from 192.168.1.101: icmp_seq=12 ttl=64 time=0.321 ms
64 bytes from 192.168.1.101: icmp_seq=13 ttl=64 time=0.308 ms
64 bytes from 192.168.1.101: icmp_seq=14 ttl=64 time=0.329 ms
64 bytes from 192.168.1.101: icmp_seq=15 ttl=64 time=0.335 ms
64 bytes from 192.168.1.101: icmp_seq=16 ttl=64 time=0.316 ms
64 bytes from 192.168.1.101: icmp_seq=17 ttl=64 time=0.326 ms
64 bytes from 192.168.1.101: icmp_seq=3 ttl=64 time=14006 ms
64 bytes from 192.168.1.101: icmp_seq=19 ttl=64 time=0.323 ms
64 bytes from 192.168.1.101: icmp_seq=20 ttl=64 time=0.314 ms
64 bytes from 192.168.1.101: icmp_seq=21 ttl=64 time=0.310 ms
64 bytes from 192.168.1.101: icmp_seq=22 ttl=64 time=0.317 ms
64 bytes from 192.168.1.101: icmp_seq=23 ttl=64 time=0.331 ms
64 bytes from 192.168.1.101: icmp_seq=8 ttl=64 time=15000 ms
64 bytes from 192.168.1.101: icmp_seq=25 ttl=64 time=0.322 ms
64 bytes from 192.168.1.101: icmp_seq=26 ttl=64 time=0.333 ms
64 bytes from 192.168.1.101: icmp_seq=27 ttl=64 time=0.337 ms
64 bytes from 192.168.1.101: icmp_seq=28 ttl=64 time=0.337 ms
64 bytes from 192.168.1.101: icmp_seq=29 ttl=64 time=0.335 ms
64 bytes from 192.168.1.101: icmp_seq=30 ttl=64 time=0.325 ms
64 bytes from 192.168.1.101: icmp_seq=31 ttl=64 time=0.307 ms
64 bytes from 192.168.1.101: icmp_seq=32 ttl=64 time=0.333 ms
64 bytes from 192.168.1.101: icmp_seq=18 ttl=64 time=14006 ms
64 bytes from 192.168.1.101: icmp_seq=34 ttl=64 time=0.330 ms
64 bytes from 192.168.1.101: icmp_seq=35 ttl=64 time=0.342 ms

Here you can see that icmp_seq=3 wasn't replied to until after
icmp_seq=17 was sent.

Once these buffer descriptors get into this state, they stay
that way until the FEC is reset.

I don't see this exact behavior when I run the test with the 3.14
kernel but I'm starting to wonder if it's because the 3.14 kernel
is receiving the transmit timeout which allows the driver to reset
itself and start working again whereas the 2.6.35 driver is not.

I hope this additional information is useful, I don't know enough
about these low-level networking details to contribute much but
it's possible that what I've seen in the 2.6.35 kernel is actually
the same issue that I'm seeing in the 3.14 kernel but handled
better.

Thanks,

Robert Daniels

This email, and any document attached hereto, may contain
confidential and/or privileged information.  If you are not the
intended recipient (or have received this email in error) please
notify the sender immediately and destroy this email.  Any
unauthorized, direct or indirect, copying, disclosure, distribution
or other use of the material or parts thereof is strictly
forbidden.
