From: eranian@googlemail.com (stephane eranian)
Date: Fri, 27 Jan 2012 16:45:53 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
References: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
 <CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
 <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
 <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
Message-ID: <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ok, with the one-line patch [1], this works much better now.
No more wrap around a 4 billion cycles.

Sampling is okay, though I noticed it tends to not get the
correct number of samples for a controlled run:

$ perf record -e cycles -c 1009213 noploop 10
noploop for 10 seconds

$ perf report -D | tail -20
cycles stats:
           TOTAL events:       9938
            MMAP events:         13
            COMM events:          2
            EXIT events:          2
        THROTTLE events:         12
      UNTHROTTLE events:         12
          SAMPLE events:       9897

Should not get throttled samples. Should get abour 10k samples
but only seeing 9897. The max_rate limit is way higher
than what I set the period (1000 samples/sec). But then,
is 3.2.0 throttling is broken. I posted a patch to fix that
yesterday. I will try with my patch applied as well.


Will do some more testing and update to the latest 3.3.0-rc1.
For now this is with 3.2.0 Linus tree.

$ sudo  ./syst_count -c 1 -p -e cpu_cycles
<press CTRL-C to quit before 20s time limit>
# 1s -----
CPU1   G0  1008360963           cpu_cycles (scaling 0.00%,
ena=1000427246, run=1000427246)
# 2s -----
CPU1   G0  2016503406           cpu_cycles (scaling 0.00%,
ena=2000610351, run=2000610351)
# 3s -----
CPU1   G0  3024622201           cpu_cycles (scaling 0.00%,
ena=3000701904, run=3000701904)
# 4s -----
CPU1   G0  4032753756           cpu_cycles (scaling 0.00%,
ena=4000823974, run=4000823974)
# 5s -----
CPU1   G0  5041040463           cpu_cycles (scaling 0.00%,
ena=5001098633, run=5001098633)
# 6s -----
CPU1   G0  6049184665           cpu_cycles (scaling 0.00%,
ena=6001220703, run=6001220703)
# 7s -----
CPU1   G0  7057336298           cpu_cycles (scaling 0.00%,
ena=7001403808, run=7001403808)
# 8s -----
CPU1   G0  8065459152           cpu_cycles (scaling 0.00%,
ena=8001556395, run=8001556395)
# 9s -----
CPU1   G0  9074297578           cpu_cycles (scaling 0.00%,
ena=9002380370, run=9002380370)
# 10s -----
CPU1   G0  10082619086          cpu_cycles (scaling 0.00%,
ena=10003540038, run=10003540038)

On Fri, Jan 27, 2012 at 3:09 PM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> 2012/1/27 Will Deacon <will.deacon@arm.com>:
>> Mans,
>>
>> On Fri, Jan 27, 2012 at 12:56:35PM +0000, M?ns Rullg?rd wrote:
>>> Will Deacon <will.deacon@arm.com> writes:
>>> > Did this lead anywhere in the end? It seems as though Ming Lei has a working
>>> > setup but Stephane is unable to replicate it, despite applying the necessary
>>> > patches and trying an updated bootloader.
>>>
>>> With the patches listed above plus the one in [1], I get PMU interrupts.
>>> However, unless I restrict the profiled process to one CPU
>>> (taskset 1 perf record ...), I get a panic in armpmu_event_update() with
>>> the 'event' argument being null when called from armv7pmu_handle_irq().
>>>
>>> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>>
>> Great, thanks for trying this out. Which version of the kernel were you
>> using?
>
> The patch is required for 3.3-rc1 in case that omap4 pmu works well.
>
> thanks,
> --
> Ming Lei
