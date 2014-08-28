From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 28 Aug 2014 12:19:18 +0530
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140823104342.GD15601@e102568-lin.cambridge.arm.com>
References: <20140604115751.GH2520@sirena.org.uk>
 <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
 <20140604135431.GL2520@sirena.org.uk>
 <20140604155129.GD10775@e102568-lin.cambridge.arm.com>
 <20140604163400.GQ2520@sirena.org.uk>
 <20140604171030.GE10775@e102568-lin.cambridge.arm.com>
 <CAFpQJXVmj0v=L_5NSGs1TdNuZDuKv_zxEoSVpCVSSsjSqFgiMg@mail.gmail.com>
 <20140818223659.GC5032@e102568-lin.cambridge.arm.com>
 <CAFpQJXW7MGGYTa6ChboGCCFUVnkUjjnGMMVc9MKfYNnchsOwAw@mail.gmail.com>
 <CAMDttNenA5UPJMPVScsP6BcVZS3D5brX5V7sYzPV_M+WAQpbHQ@mail.gmail.com>
 <20140823104342.GD15601@e102568-lin.cambridge.arm.com>
Message-ID: <CAFpQJXUnUeQ350fpjSpH8wok=KfrTycb=+7tA_ceaBevvZ94PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 4:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Aug 21, 2014 at 06:15:40AM +0100, Zi Shen Lim wrote:
>> Hi Ganapatrao,
>>
>> On Tue, Aug 19, 2014 at 11:08 PM, Ganapatrao Kulkarni
>> <gpkulkarni@gmail.com> wrote:
>> > Hi Lorenzo,
>> >
>> > On Tue, Aug 19, 2014 at 4:06 AM, Lorenzo Pieralisi
>> > <lorenzo.pieralisi@arm.com> wrote:
>> >> On Mon, Aug 18, 2014 at 08:39:48AM +0100, Ganapatrao Kulkarni wrote:
>> >>> How we map non SMT (MT bit24=0) cores of dual/multi socket system with
>> >>> the topology which is using only aff0 and aff1?
>> >>> can we use aff2  ( or concatenating aff2 and aff3)  to represent socket-id?
>> >>
>> >> Can you provide us with a description of the topology and the MPIDR_EL1
>> >> list please ?
>> >>
>> >> I think that DT squashes the levels above cluster so that's how it could
>> >> be implemented but first I would like to see what s the CPUs layout
>> >> of the system.
>> >
>> > Our Soc has 48 core(Cavium's  thunderX) design. 48 cores are
>> > sub-grouped in to 3 clusters.
>> > In turn each cluster is having 16 cores.
>> > We do have support for connecting 2 SoCs and making single system of 96 cores.
>> >
>> > the MPIDR mapping for this topology is,
>> >
>> > Aff0 is mapped to 16 cores within a cluster. Valid range is 0 to 0xf
>> > Aff1 is mapped to cluster number, valid values are 0,1 and 2.
>> > Aff2 is mapped to Socket-id or SoC number. Valid values are 0 and 1.
>>
>> So, we went back and forth a few times and finally settled on what's
>> merged into 3.17, due to lack of visibility into hardware that'll be
>> shipped.
>>
>> At one point, we had something approximating behavior of DT-based
>> topology, along the lines of:
>>
>>         if (mpidr & MPIDR_MT_BITMASK) {
>>                 /* Multiprocessor system : Multi-threads per core */
>>                 cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>                 cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>>                 cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
>>                                          MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
>>         } else {
>>                 /* Multiprocessor system : Single-thread per core */
>>                 cpuid_topo->thread_id  = -1;
>>                 cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>                 cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
>>                                          MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
>>                                          MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
>>         }
>>
>> BTW, Mark Brown just posted "[PATCH] arm64: topology: Fix handling of
>> multi-level cluster MPIDR-based detection" which reintroduces the
>> above, albeit only for MT case.
>>
>> I suspect you're looking for something above for the non-MT case?
>> As a workaround, have you considered defining your topology in DT?
>>
>> Lorenzo,
>>
>> Are you open to the above "workaround" given that Thunder is facing
>> the current deficiency for non-MT case?
>> Or is it time to introduce socket_id or something equivalent?
>
> Well, we have to do something for certain, I think M. Brown's patch
> seems a reasonable solution to this problem, I will give it more thought
> and come back to you beginning of September (I am currently on holiday).
>
yes, please.
is it better to align/define cluster as group of  up-to 16 cores?(in
line to gicv3 target-list).
IMHO, it is better to introduce socket instead of calling cluster of cluster.
any plans to have DT bindings for NUMA, is any one working?

> Thank you,
> Lorenzo
>
thanks
Ganapat
