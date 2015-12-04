From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Dec 2015 22:30:35 +0100
Subject: [PATCH net-next v2 4/4] net: mvneta: Spread out the TX queues
 management on all CPUs
In-Reply-To: <1449256350.25029.36.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1449254700-32685-1-git-send-email-gregory.clement@free-electrons.com>
 <1449254700-32685-5-git-send-email-gregory.clement@free-electrons.com>
 <1449256350.25029.36.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <10523514.jXrVKo414l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 11:12:30 Eric Dumazet wrote:
> On Fri, 2015-12-04 at 19:45 +0100, Gregory CLEMENT wrote:
> > With this patch each CPU is associated with its own set of TX queues. In
> > the same time the SKB received in mvneta_tx is bound to the queue
> > associated to the CPU sending the data. Thanks to this the next IRQ will
> > be received on the same CPU allowing sending more data.
> > 
> > It will also allow to have a more predictable behavior regarding
> > throughput and latency when having multiple threads sending out data on
> > different CPUs.
> > 
> > As an example on Armada XP GP, with an iperf bound to a CPU and a ping
> > bound to another CPU, without this patch the ping round trip was about
> > 2.5ms (and could reach 3s!), whereas with this patch it was around
> > 0.7ms (and sometime it went to 1.2ms).
> 
> This really looks like you need something smarter than pfifo_fast qdisc,
> and maybe BQL (I did not check if this driver already implements this)

I suggested this change as well as the BQL implementation that Marcin did.
I believe he hasn't posted that yet while he's doing some more testing,
but it should come soon.

	Arnd
