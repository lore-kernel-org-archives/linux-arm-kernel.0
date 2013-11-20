From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 20 Nov 2013 09:30:07 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131120171227.GG8581@1wt.eu>
References: <8761s0cqhh.fsf@natisbad.org>
 <slrnl83jr5.49f.xiyou.wangcong@linux-6brj.site>
 <87y54u59zq.fsf@natisbad.org> <20131112083633.GB10318@1wt.eu>
 <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120171227.GG8581@1wt.eu>
Message-ID: <1384968607.10637.14.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 18:12 +0100, Willy Tarreau wrote:
> Hi guys,

> Eric, first I would like to confirm that I could reproduce Arnaud's issue
> using 3.10.19 (160 kB/s in the worst case).
> 
> Second, I confirm that your patch partially fixes it and my performance
> can be brought back to what I had with 3.10-rc7, but with a lot of
> concurrent streams. In fact, in 3.10-rc7, I managed to constantly saturate
> the wire when transfering 7 concurrent streams (118.6 kB/s). With the patch
> applied, performance is still only 27 MB/s at 7 concurrent streams, and I
> need at least 35 concurrent streams to fill the pipe. Strangely, after
> 2 GB of cumulated data transferred, the bandwidth divided by 11-fold and
> fell to 10 MB/s again.
> 
> If I revert both "0ae5f47eff tcp: TSQ can use a dynamic limit" and
> your latest patch, the performance is back to original.
> 
> Now I understand there's a major issue with the driver. But since the
> patch emphasizes the situations where drivers take a lot of time to
> wake the queue up, don't you think there could be an issue with low
> bandwidth links (eg: PPPoE over xDSL, 10 Mbps ethernet, etc...) ?
> I'm a bit worried about what we might discover in this area I must
> confess (despite generally being mostly focused on 10+ Gbps).

Well, all TCP performance results are highly dependent on the workload,
and both receivers and senders behavior.

We made many improvements like TSO auto sizing, DRS (dynamic Right
Sizing), and if the application used some specific settings (like
SO_SNDBUF / SO_RCVBUF or other tweaks), we can not guarantee that same
exact performance is reached from kernel version X to kernel version Y.

We try to make forward progress, there is little gain to revert all
these great works. Linux had this tendency to favor throughput by using
overly large skbs. Its time to do better.

As explained, some drivers are buggy, and need fixes.

If nobody wants to fix them, this really means no one is interested
getting them fixed.

I am willing to help if you provide details, because otherwise I need
a crystal ball ;)

One known problem of TCP is the fact that an incoming ACK making room in
socket write queue immediately wakeup a blocked thread (POLLOUT), even
if only one MSS was ack, and write queue has 2MB of outstanding bytes.

All these scheduling problems should be identified and fixed, and yes,
this will require a dozen more patches.

max (128KB , 1-2 ms) of buffering per flow should be enough to reach
line rate, even for a single flow, but this means the sk_sndbuf value
for the socket must take into account the pipe size _plus_ 1ms of
buffering.
