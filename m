From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 11 Sep 2015 08:18:43 -0700
Subject: NFS/TCP/IPv6 acting strangely in 4.2
In-Reply-To: <20150911150613.GR21084@n2100.arm.linux.org.uk>
References: <20150911113839.GO21084@n2100.arm.linux.org.uk>
 <1441976691.4619.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <20150911143347.GQ21084@n2100.arm.linux.org.uk>
 <20150911150613.GR21084@n2100.arm.linux.org.uk>
Message-ID: <1441984723.4619.61.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-11 at 16:06 +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 11, 2015 at 03:33:47PM +0100, Russell King - ARM Linux wrote:
> > It looks like 0c78789e3a030615c6650fde89546cadf40ec2cc might be relevant
> > too, but I don't see that solving the multiple _concurrent_ connection
> > attempts with the same port number - presumably it's somehow trying to
> > make the same socket repeatedly connect despite a previous connection
> > being in progress, which would have nothing to do with cleaning up a
> > previous attempt.
> 
> As I suspected, applying the above commit in addition does not solve the
> problem, I still see the same behaviour: SYN SYNACK SYN RSTACK, SYN
> SYNACK SYN RSTACK, and eventual SYN storms.
> 
> I do have this captured as well:
> 
> 2558   0.834316 armada388 -> n2100 TCP [TCP Port numbers reused] rpasswd?nfs [SYN] Seq=1053655487 Win=28800 Len=0 MSS=1440 SACK_PERM=1 TSval=60001 TSecr=0 WS=128
> 2559   0.834572 n2100 -> armada388 TCP nfs?rpasswd [SYN, ACK] Seq=3076611574 Ack=1053655488 Win=28560 Len=0 MSS=1440 SACK_PERM=1 TSval=869622246 TSecr=60001 WS=64
> 2560   0.834666 armada388 -> n2100 TCP [TCP Port numbers reused] rpasswd?nfs [SYN] Seq=1054228544 Win=28800 Len=0 MSS=1440 SACK_PERM=1 TSval=60005 TSecr=0 WS=128
> 2561   0.834895 n2100 -> armada388 TCP nfs?rpasswd [ACK] Seq=3076611575 Ack=1053655488 Win=28560 Len=0 TSval=869622246 TSecr=60001
> 
> The packet at 2561 looks wrong to me - this doesn't follow what I know
> would be the standard TCP setup of syn, synack, ack, because that final
> ack is in the wrong direction.
> 

This 2561 packet is an ACK packet, because n2100 has a SYN_RECV socket
created by packet 2558.

It receives a SYN packet (2560) that it interprets as a packet slightly
out of sequence (1054228544 being above 1053655487) for this SYN_RECV

The wrong packet is 2560, not 2561
