From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 30 Nov 2014 18:13:41 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAFpQJXU4fsCn5rW20qqL1_MYm0Np_beF5gni7uMZSLFLRvVrcQ@mail.gmail.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <2065254.jRdQcinOdg@wuerfel>
 <CAFpQJXU4fsCn5rW20qqL1_MYm0Np_beF5gni7uMZSLFLRvVrcQ@mail.gmail.com>
Message-ID: <6240913.jpvmh8hH5F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 30 November 2014 08:38:02 Ganapatrao Kulkarni wrote:

> On Tue, Nov 25, 2014 at 11:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 25 November 2014 08:15:47 Ganapatrao Kulkarni wrote:
> >> > No, don't hardcode ARM specifics into a common binding either. I've looked
> >> > at the ibm,associativity properties again, and I think we should just use
> >> > those, they can cover all cases and are completely independent of the
> >> > architecture. We should probably discuss about the property name though,
> >> > as using the "ibm," prefix might not be the best idea.
> >>
> >> We have started with new proposal, since not got enough details how
> >> ibm/ppc is managing the numa using dt.
> >> there is no documentation and there is no power/PAPR spec for numa in
> >> public domain and there are no single dt file in arch/powerpc which
> >> describes the numa. if we get any one of these details, we can align
> >> to powerpc implementation.
> >
> > Basically the idea is to have an "ibm,associativity" property in each
> > bus or device that is node specific, and this includes all CPUs and
> > memory nodes. The property contains an array of 32-bit integers that
> > count the resources. Take an example of a NUMA cluster of two machines
> > with four sockets and four cores each (32 cores total), a memory
> > channel on each socket and one PCI host per board that is connected
> > at equal speed to each socket on the board.
> thanks for the detailed information.
> IMHO, linux-numa code does not care about how the hardware design is,
> like how many boards and how many sockets it has. It only needs to
> know how many numa nodes system has, how resources are mapped to nodes
> and node-distance to define inter node memory access latency. i think
> it will be simple, if we merge board and socket to single entry say
> node.

But it's not good to rely on implementation details of a particular
operating system.

> also we are assuming here that numa h/w design will have multiple
> boards and sockets, what if it has something different/more.

As I said, this was a simplified example, you can have an arbitrary
number of levels, and normally there are more than three, to capture
the cache hierarchy and other things as well.

> > The "ibm,associativity-reference-points" property here indicates that index 2
> > of each array is the most important NUMA boundary for the particular system,
> > because the performance impact of allocating memory on the remote board
> > is more significant than the impact of using memory on a remote socket of the
> > same board. Linux will consequently use the first field in the array as
> > the NUMA node ID. If the link between the boards however is relatively fast,
> > so you care mostly about allocating memory on the same socket, but going to
> > another board isn't much worse than going to another socket on the same
> > board, this would be
> >
> >         ibm,associativity-reference-points = <1 0>;
> i am not able to understand fully, it will be grate help, if you
> explain, how we capture the node distance matrix using
> "ibm,associativity-reference-points "
> for example, how DT looks like for the system with 4 nodes, with below
> inter-node distance matrix.
> node 0 1 distance 20
> node 0 2 distance 20
> node 0 3 distance 20
> node 1 2 distance 20
> node 1 3 distance 20
> node 2 3 distance 20

In your example, you have only one entry in
ibm,associativity-reference-points as it's even simpler: just
one level of hierarchy, everything is the same distance from
everything else, so within the associativity hierarchy, the
ibm,associativity-reference-points just points to the one
level that indicates a NUMA node.

You would only need multiple entries here if the hierarchy is
complex enough to require multiple levels of topology.

	Arnd
