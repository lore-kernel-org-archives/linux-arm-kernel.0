From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 16 Apr 2015 09:22:23 +0000
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <552F7936.9070205@eu.citrix.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
 <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
 <1429115934.7346.107.camel@edumazet-glaptop2.roam.corp.google.com>
 <552E9E8D.1080000@eu.citrix.com>
 <1429118948.7346.114.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EA2BC.5000707@eu.citrix.com>
 <1429120373.7346.125.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EA844.5010308@eu.citrix.com>
 <1429121979.7346.138.camel@edumazet-glaptop2.roam.corp.google.com>
 <552F7936.9070205@eu.citrix.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB1F43C@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George Dunlap
> Sent: 16 April 2015 09:56
> On 04/15/2015 07:19 PM, Eric Dumazet wrote:
> > On Wed, 2015-04-15 at 19:04 +0100, George Dunlap wrote:
> >
> >> Maybe you should stop wasting all of our time and just tell us what
> >> you're thinking.
> >
> > I think you make me wasting my time.
> >
> > I already gave all the hints in prior discussions.
> 
> Right, and I suggested these two options:
> 
> "Obviously one solution would be to allow the drivers themselves to set
> the tcp_limit_output_bytes, but that seems like a maintenance
> nightmare.
> 
> "Another simple solution would be to allow drivers to indicate whether
> they have a high transmit latency, and have the kernel use a higher
> value by default when that's the case." [1]
> 
> Neither of which you commented on.  Instead you pointed me to a comment
> that only partially described what the limitations were. (I.e., it
> described the "two packets or 1ms", but not how they related, nor how
> they related to the "max of 2 64k packets outstanding" of the default
> tcp_limit_output_bytes setting.)

ISTM that you are changing the wrong knob.
You need to change something that affects the global amount of pending tx data,
not the amount that can be buffered by a single connection.

If you change tcp_limit_output_bytes and then have 1000 connections trying
to send data you'll suffer 'bufferbloat'.

If you call skb_orphan() in the tx setup path then the total number of
buffers is limited, but a single connection can (and will) will the tx
ring leading to incorrect RTT calculations and additional latency for
other connections.
This will give high single connection throughput but isn't ideal.

One possibility might be to call skb_orphan() when enough time has
elapsed since the packet was queued for transmit that it is very likely
to have actually been transmitted - even though 'transmit done' has
not yet been signalled.
Not at all sure how this would fit in though...

	David
