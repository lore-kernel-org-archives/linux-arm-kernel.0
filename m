From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 18:32:06 +0100
Subject: [RFC PATCH v3 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <20150114234905.GB18194@e102568-lin.cambridge.arm.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <CAFpQJXXiUmK+BdQAFxV_JCuLyDSm89M7pe+enc2ZMTbuyC-T+g@mail.gmail.com>
 <20150114234905.GB18194@e102568-lin.cambridge.arm.com>
Message-ID: <10472930.gA3cIoMNLT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 January 2015 23:49:05 Lorenzo Pieralisi wrote:
> On Wed, Jan 14, 2015 at 06:48:32PM +0000, Ganapatrao Kulkarni wrote:
> > On Wed, Jan 14, 2015 at 11:06 PM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Wed, Jan 07, 2015 at 08:18:50AM +0000, Arnd Bergmann wrote:
> > >> No, that would leave out the core number, which is required to identify
> > >> the individual thread. I meant adding an extra level such as
> > >>
> > >> <board> <socket> <cluster> <core>
> > >>
> > >> A lot of machines will leave out the <board> number because they are
> > >> built with SoCs that don't have a long-distance coherency protocol.
> > >
> > > Can't we use phandles to cpu-map nodes instead of a list of numbers (and
> > > yet another topology binding description) ?
> > cpu-map describes only a cpu topology.
> > infact, i have tried initially(in v1 patch set) to use topology for
> > the numa mapping.
> > However, for numa, we need to define association of cpu, memory and IOs.
> > arm,associativity is a generic node property and can be used in any dt nodes.
> 
> I understand that, I was advising to define "arm,associativity" as a
> phandle in cpu nodes AND all devices.
> 
> Why can't you make it point at a phandle in the cpu-map instead of adding
> a t-uple doing the same thing. Am I missing something here ?

Most importantly, it's following an existing spec for ibm,associativity,
which defines topology in terms of associativity, not a hierarchical tree.

> cpu-map allows you to describe the system hierarchy and can expand beyond
> clusters (several layers of clusterings, above core it is just a way to
> define the system hierarchy, leaves node will always be cores or threads).

> On a side note, one of the reasons cpu-map was devised for was exactly
> that, to allow mappings of resources (ie IRQs but it is valid for caches
> and other devices too) to groups of CPUs.
> 
> Is there anything that you can't do by using cpu-map phandles to
> describe devices associativity ?

- It doesn't work for cpu-less nodes.
- It fails if you have multiple paths between two devices, rather than
  a strict tree.
- It doesn't (yet) have a way to define which levels are relevant to NUMA
  topology.
- the phandle references are done in the wrong way if you want to
  represent a lot of devices.

> We have to add bindings that allow to compute the distance as you
> do by using the reference points (I am reading the code to figure
> out how it is used), but that's feasible as a binding update.

It's very unfortunate that we have two conflicting bindings that are
established. I still think that the associativity binding is more
flexible, but we could try to extend the arm topology binding if
necessary, but I'm not sure the end result of that would be better.

	Arnd
