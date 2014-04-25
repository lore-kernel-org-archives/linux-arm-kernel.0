From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 25 Apr 2014 18:04:19 +0200
Subject: [PATCH v4 5/5] sched: ARM: create a dedicated scheduler topology
 table
In-Reply-To: <CAKfTPtAq8PXS-n7A0W6ESe08m-6O3u84BcY3==+-0+63+uca9g@mail.gmail.com>
References: <1397209481-28542-1-git-send-email-vincent.guittot@linaro.org>
 <1397209481-28542-6-git-send-email-vincent.guittot@linaro.org>
 <5357A802.1030804@arm.com>
 <CAKfTPtDnw-OZZekdE3oNGS11m6dfpS4veMNZ_Bezs-Lm7zn6QQ@mail.gmail.com>
 <5357DBA5.1010106@arm.com>
 <CAKfTPtAOZqnP=sWeJuqFAqrGT8vLQZKj+tpqiwOTG37paXoGjg@mail.gmail.com>
 <53590835.9090803@arm.com>
 <CAKfTPtAq8PXS-n7A0W6ESe08m-6O3u84BcY3==+-0+63+uca9g@mail.gmail.com>
Message-ID: <20140425160419.GL11096@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The example above is consistent because CPU2 mask and CPU0 mask are
> fully exclusive
> 
> so
> CPU0: cpu_corepower_mask=0-1
> CPU2: cpu_corepower_mask=2
> are consistent
> 
> CPU0: cpu_corepower_mask=0-2
> CPU2: cpu_corepower_mask=0-2
> are also consistent
> 
> but
> 
> CPU0: cpu_corepower_mask=0-1
> CPU2: cpu_corepower_mask=0-2
> are not consistent
> 
> and your example uses the last configuration
> 
> To be more precise, the rule above applies on default SDT definition
> but the flag SD_OVERLAP enables such kind of overlap between group.
> Have you tried it ?

I've never tried degenerate stuff with SD_OVERLAP, it might horribly
explode -- its not actually meant to work.

The SD_OVERLAP comes from not fully connected NUMA topologies; suppose
something like:

        0------1
        |      |
        |      |
	2------3

or:

 ( 10 20 20  0 )
 ( 20 10  0 20 )
 ( 20  0 10 20 )
 (  0 20 20 10 )

Your domain level that models the single-hop/20 distance has overlapping
masks:

N0: 0-2
N1: 0,1,3
N2: 0,2,3
N3: 1-3

I've never tried to construct a NUMA topology that would be overlapping
and have redundant bits in.
