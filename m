From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 14 Jan 2015 23:49:05 +0000
Subject: [RFC PATCH v3 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <CAFpQJXXiUmK+BdQAFxV_JCuLyDSm89M7pe+enc2ZMTbuyC-T+g@mail.gmail.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <3372289.4AUgcSNZN5@wuerfel>
 <CAFpQJXUB8=XhmAn9-SPKaRHoTaTDynfD8xd-mVJOYrAwo50Rzg@mail.gmail.com>
 <2298510.9qAQRQ2lzi@wuerfel> <20150114173639.GA11844@red-moon>
 <CAFpQJXXiUmK+BdQAFxV_JCuLyDSm89M7pe+enc2ZMTbuyC-T+g@mail.gmail.com>
Message-ID: <20150114234905.GB18194@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 06:48:32PM +0000, Ganapatrao Kulkarni wrote:
> Hi Lorenzo,
> 
> On Wed, Jan 14, 2015 at 11:06 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Wed, Jan 07, 2015 at 08:18:50AM +0000, Arnd Bergmann wrote:
> >> On Wednesday 07 January 2015 12:37:51 Ganapatrao Kulkarni wrote:
> >> > Hi Arnd,
> >> >
> >> > On Wed, Jan 7, 2015 at 1:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > > On Tuesday 06 January 2015 15:04:26 Ganapatrao Kulkarni wrote:
> >> > >> On Sat, Jan 3, 2015 at 2:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > >> > On Wednesday 31 December 2014 13:03:27 Ganapatrao Kulkarni wrote:
> >> > >> >> +             cpu at 00f {
> >> > >> >> +                     device_type = "cpu";
> >> > >> >> +                     compatible = "cavium,thunder", "arm,armv8";
> >> > >> >> +                     reg = <0x0 0x00f>;
> >> > >> >> +                     enable-method = "psci";
> >> > >> >> +                     arm,associativity = <0 0 0x00f>;
> >> > >> >> +             };
> >> > >> >> +             cpu at 100 {
> >> > >> >> +                     device_type = "cpu";
> >> > >> >> +                     compatible = "cavium,thunder", "arm,armv8";
> >> > >> >> +                     reg = <0x0 0x100>;
> >> > >> >> +                     enable-method = "psci";
> >> > >> >> +                     arm,associativity = <0 0 0x100>;
> >> > >> >> +             };
> >> > >> >
> >> > >> > What is the 0x100 offset in the last-level topology field? Does this have
> >> > >> > no significance to topology at all? I would expect that to be something
> >> > >> > like cluster number that is relevant to caching and should be represented
> >> > >> > as a separate level.
> >> > >>
> >> > >> i did not understand, can you please explain little more about "
> >> > >> should be represented as a separate level."
> >> > >> at present, i have put the hwid of a cpu.
> >> > >
> >> > > From what I undertand, the hwid of the CPU contains the "cluster" number in
> >> > > this bit position, so you typically have a shared L2 or L3 cache between
> >> > > all cores within a cluster, but separate caches in other clusters.
> >> > >
> >> > > If this is the case, there will be a measurable difference in performance
> >> > > between two processes sharing memory when running on the same cluster,
> >> > > or when running on different clusters on the same socket. If the
> >> > > performance difference is relevant, it should be described as a separate
> >> > > level in the associativity property.
> >> > you mean, the associativity as array of  <board> <socket> <cluster>
> >>
> >> No, that would leave out the core number, which is required to identify
> >> the individual thread. I meant adding an extra level such as
> >>
> >> <board> <socket> <cluster> <core>
> >>
> >> A lot of machines will leave out the <board> number because they are
> >> built with SoCs that don't have a long-distance coherency protocol.
> >
> > Can't we use phandles to cpu-map nodes instead of a list of numbers (and
> > yet another topology binding description) ?
> cpu-map describes only a cpu topology.
> infact, i have tried initially(in v1 patch set) to use topology for
> the numa mapping.
> However, for numa, we need to define association of cpu, memory and IOs.
> arm,associativity is a generic node property and can be used in any dt nodes.

I understand that, I was advising to define "arm,associativity" as a
phandle in cpu nodes AND all devices.

Why can't you make it point at a phandle in the cpu-map instead of adding
a t-uple doing the same thing. Am I missing something here ?
cpu-map allows you to describe the system hierarchy and can expand beyond
clusters (several layers of clusterings, above core it is just a way to
define the system hierarchy, leaves node will always be cores or threads).

On a side note, one of the reasons cpu-map was devised for was exactly
that, to allow mappings of resources (ie IRQs but it is valid for caches
and other devices too) to groups of CPUs.

Is there anything that you can't do by using cpu-map phandles to
describe devices associativity ?

We have to add bindings that allow to compute the distance as you
do by using the reference points (I am reading the code to figure
out how it is used), but that's feasible as a binding update.

Lorenzo
