From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 20 Aug 2014 09:38:43 +0530
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140818223659.GC5032@e102568-lin.cambridge.arm.com>
References: <20140603173103.GA18004@red-moon>
 <20140603210424.GJ31751@sirena.org.uk>
 <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
 <20140604115751.GH2520@sirena.org.uk>
 <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
 <20140604135431.GL2520@sirena.org.uk>
 <20140604155129.GD10775@e102568-lin.cambridge.arm.com>
 <20140604163400.GQ2520@sirena.org.uk>
 <20140604171030.GE10775@e102568-lin.cambridge.arm.com>
 <CAFpQJXVmj0v=L_5NSGs1TdNuZDuKv_zxEoSVpCVSSsjSqFgiMg@mail.gmail.com>
 <20140818223659.GC5032@e102568-lin.cambridge.arm.com>
Message-ID: <CAFpQJXW7MGGYTa6ChboGCCFUVnkUjjnGMMVc9MKfYNnchsOwAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Tue, Aug 19, 2014 at 4:06 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Aug 18, 2014 at 08:39:48AM +0100, Ganapatrao Kulkarni wrote:
>> How we map non SMT (MT bit24=0) cores of dual/multi socket system with
>> the topology which is using only aff0 and aff1?
>> can we use aff2  ( or concatenating aff2 and aff3)  to represent socket-id?
>
> Can you provide us with a description of the topology and the MPIDR_EL1
> list please ?
>
> I think that DT squashes the levels above cluster so that's how it could
> be implemented but first I would like to see what s the CPUs layout
> of the system.

Our Soc has 48 core(Cavium's  thunderX) design. 48 cores are
sub-grouped in to 3 clusters.
In turn each cluster is having 16 cores.
We do have support for connecting 2 SoCs and making single system of 96 cores.

the MPIDR mapping for this topology is,

Aff0 is mapped to 16 cores within a cluster. Valid range is 0 to 0xf
Aff1 is mapped to cluster number, valid values are 0,1 and 2.
Aff2 is mapped to Socket-id or SoC number. Valid values are 0 and 1.

note : our definition of cluster and number of cores in a cluster is
in-line with the GICv3 spec.

>
> Thanks,
> Lorenzo
>
>>
>> thanks
>> Ganapat
>>
>>
>> On Wed, Jun 4, 2014 at 10:40 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Wed, Jun 04, 2014 at 05:34:00PM +0100, Mark Brown wrote:
>> >> On Wed, Jun 04, 2014 at 04:51:29PM +0100, Lorenzo Pieralisi wrote:
>> >>
>> >> > My question is: is it better to pack affinity levels and "guess" what aff3
>> >> > (and aff2 on non-SMT) means or add an additional level of hierarchy in the
>> >> > arm64 topology code (eg book_id - implemented only for s390 to the best
>> >> > of my knowledge) ?
>> >>
>> >> Shoving them in there would address the issue as well, yes (though we'd
>> >> still have to combine aff2 and aff3 for the non-SMT case).  I don't know
>> >> if having books enabled has some overhead we don't want though.
>> >>
>> >> > I personally prefer the latter approach but I think it boils down to
>> >> > understanding what do we want to provide the scheduler with if we have
>> >> > a hierarchy that extends beyond "cluster" level.
>> >>
>> >> > I will be glad to help you implement it when time comes (and this will also
>> >> > fix the clusters of clusters DT issue we are facing - ie how to treat them).
>> >>
>> >> > Now, I do not think it is a major problem at the moment, merging the
>> >> > patch I sent will give us more time to discuss how to define the
>> >> > topology for clusters of clusters, because that's what we are talking
>> >> > about.
>> >>
>> >> In so far as you're saying that we don't really need to worry about
>> >> exactly how we handle multi-level clusters properly at the minute I
>> >> agree with you - until we have some idea what they physically look like
>> >> and can consider how well that maps onto the scheduler and whatnot it
>> >> doesn't really matter and we can just ignore it.  Given that I'm not
>> >> concerned about just reporting everything as flat like we do with DT at
>> >> the minute and don't see a real need to theorise about it, it'll just be
>> >> a performance problem and not a correctness problem when it is
>> >> encountered.  That feels like a better position to leave things in as it
>> >> will be less stress for whoever is bringing up such a fancy new system,
>> >> they can stand a reasonable chance of getting things at least running
>> >> with minimal effort.
>> >
>> > Ok, I think we have an agreement, let's merge the patch I sent and
>> > discuss the way forward to cater for systems with clusters of clusters
>> > when we reasonably expect them to hit production, the scheduler expected
>> > topology might well change by that time and now we are well positioned
>> > to cope with future extensions (and actually packing affinity levels
>> > might well be the final solution if the scheduler expects a "flat"
>> > topology at the higher topology level).
>> >
>> >> > Does it make sense ?
>> >>
>> >> Like I say I do think that merging your current code is better than
>> >> nothing.
>> >
>> > Great, thanks for bearing with me.
>> >
>> > Thanks !
>> > Lorenzo
>> >
>> >
>> > _______________________________________________
>> > linaro-kernel mailing list
>> > linaro-kernel at lists.linaro.org
>> > http://lists.linaro.org/mailman/listinfo/linaro-kernel
>>
>
