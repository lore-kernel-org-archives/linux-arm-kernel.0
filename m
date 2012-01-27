From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2012 15:54:54 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
References: <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
Message-ID: <20120127155454.GH2347@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 03:45:53PM +0000, stephane eranian wrote:
> Hi,

Hi Stephane,

> Ok, with the one-line patch [1], this works much better now.
> No more wrap around a 4 billion cycles.

Hurrah! Thanks Mans and Ming Lei for helping with this. Unfortunately, I
remember Santosh had objections to this patch so that needs to be resolved.

> Sampling is okay, though I noticed it tends to not get the
> correct number of samples for a controlled run:
> 
> $ perf record -e cycles -c 1009213 noploop 10
> noploop for 10 seconds
> 
> $ perf report -D | tail -20
> cycles stats:
>            TOTAL events:       9938
>             MMAP events:         13
>             COMM events:          2
>             EXIT events:          2
>         THROTTLE events:         12
>       UNTHROTTLE events:         12
>           SAMPLE events:       9897
> 
> Should not get throttled samples. Should get abour 10k samples
> but only seeing 9897. The max_rate limit is way higher
> than what I set the period (1000 samples/sec). But then,
> is 3.2.0 throttling is broken. I posted a patch to fix that
> yesterday. I will try with my patch applied as well.

Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
you may miss samples if they occur during critical kernel sections (and if
you look at a profile, spin_unlock_irqrestore will be quite high).

A7 and A15 have the ability to filter counters based on privilege level, so
you can get more accurate userspace counts there.

Will
