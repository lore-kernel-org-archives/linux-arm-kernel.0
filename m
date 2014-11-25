From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 22:09:41 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <2065254.jRdQcinOdg@wuerfel>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <CAFpQJXUjYsTiHSyHdgtN9JPWGN8CByR4VwtSMJhwkAUWA4iV9w@mail.gmail.com>
 <2065254.jRdQcinOdg@wuerfel>
Message-ID: <2301278.uLKBUrWKt0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 20:00:42 Arnd Bergmann wrote:
> On Tuesday 25 November 2014 08:15:47 Ganapatrao Kulkarni wrote:
> > > No, don't hardcode ARM specifics into a common binding either. I've looked
> > > at the ibm,associativity properties again, and I think we should just use
> > > those, they can cover all cases and are completely independent of the
> > > architecture. We should probably discuss about the property name though,
> > > as using the "ibm," prefix might not be the best idea.
> >
> > We have started with new proposal, since not got enough details how
> > ibm/ppc is managing the numa using dt.
> > there is no documentation and there is no power/PAPR spec for numa in
> > public domain and there are no single dt file in arch/powerpc which
> > describes the numa. if we get any one of these details, we can align
> > to powerpc implementation.
> 
> Basically the idea is to have an "ibm,associativity" property in each
> bus or device that is node specific, and this includes all CPUs and
> memory nodes. ...

I should have mentioned that the example I gave was still rather basic.
In a larger real-world system, you have more levels of associativity,
though not all of them are relevant for NUMA memory allocation.
Also, when you have levels that are not just a crossbar but instead
have multiple point-to-point connections or a ring bus, it gets more
complex, but you can still represent it with these properties.

For task placement, the associativity would also represent the
topology within one node (SMT threads, cores, clusters, chips,
mcms, sockets) as separate levels, and in large installations you
would have multiple levels of memory topology (memory controllers,
sockets, board/blade, chassis, rack, ...), which can get taken into
account for memory allocation to find the closest node. The metric
that you use here is how many levels within the topology are matching
between two devices (typically memory and i/o device, or memory and cpu).

	Arnd
