From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 15 Apr 2015 11:17:47 -0700
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <alpine.DEB.2.02.1504151846110.7690@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
 <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
 <1429115934.7346.107.camel@edumazet-glaptop2.roam.corp.google.com>
 <552E9E8D.1080000@eu.citrix.com>
 <1429119688.7346.123.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504151846110.7690@kaball.uk.xensource.com>
Message-ID: <1429121867.7346.136.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-15 at 18:58 +0100, Stefano Stabellini wrote:
> On Wed, 15 Apr 2015, Eric Dumazet wrote:
> > On Wed, 2015-04-15 at 18:23 +0100, George Dunlap wrote:
> > 
> > > Which means that max(2*skb->truesize, sk->sk_pacing_rate >>10) is
> > > *already* larger for Xen; that calculation mentioned in the comment is
> > > *already* doing the right thing.
> > 
> > Sigh.
> > 
> > 1ms of traffic at 40Gbit is 5 MBytes
> > 
> > The reason for the cap to /proc/sys/net/ipv4/tcp_limit_output_bytes is
> > to provide the limitation of ~2 TSO packets, which _also_ is documented.
> > 
> > Without this limitation, 5 MBytes could translate to : Fill the queue,
> > do not limit.
> > 
> > If a particular driver needs to extend the limit, fine, document it and
> > take actions.
> 
> What actions do you have in mind exactly?  It would be great if you
> could suggest how to move forward from here, beside documentation.
> 
> I don't think we can really expect every user that spawns a new VM in
> the cloud to manually echo blah >
> /proc/sys/net/ipv4/tcp_limit_output_bytes to an init script.  I cannot
> imagine that would work well.

I already pointed a discussion on the same topic for wireless adapters.

Some adapters have a ~3 ms TX completion delay, so the 1ms assumption in
TCP stack is limiting the max throughput.

All I hear here are unreasonable requests, marketing driven.

If a global sysctl is not good enough, make it a per device value.

We already have netdev->gso_max_size and netdev->gso_max_segs
which are cached into sk->sk_gso_max_size & sk->sk_gso_max_segs

What about you guys provide a new 
netdev->I_need_to_have_big_buffers_to_cope_with_my_latencies.

Do not expect me to fight bufferbloat alone. Be part of the challenge,
instead of trying to get back to proven bad solutions.
