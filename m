From: salyzyn@android.com (Mark Salyzyn)
Date: Tue, 31 Oct 2017 08:28:52 -0700
Subject: [PATCH v3 04/12] arm: vdso: enforce monotonic and realtime as
 inline
In-Reply-To: <20171030155940.GR20805@n2100.armlinux.org.uk>
References: <20171027222531.57223-1-salyzyn@android.com>
 <20171030155940.GR20805@n2100.armlinux.org.uk>
Message-ID: <ca992b27-64f3-b160-215d-ce674fb25e7d@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2017 08:59 AM, Russell King - ARM Linux wrote:
> On Fri, Oct 27, 2017 at 03:25:28PM -0700, Mark Salyzyn wrote:
>> Ensure monotonic and realtime are inline, small price to pay for
>> high volume common request.
> Is this just based on a hunch, or is it based on proper measurement?
> If proper measurement, where's the data?  What CPU was it measured
> with?  How does this change affect other CPUs?
>
I was tested faster in the past. Story today is less conclusive and the 
change is not worth it.

[TL;DR]

Code size in all cases is about 1/2 a 4K page, and change in size is not 
that much in or out.

Originally coded to match assembler for arm64. I tested it when I was 
first formulating the series and found a 2-4% improvement on arm 
(Nexus6, backport to 3.10) and arm64 (Nexus 6P, backport to 3.18). But 
that was (a technological) eon ago.

However, retested as-is, in and out, today side by side, clock_gettime 
for CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_REALTIME, locked cores, 
affinity to littles (0-3), 50M iterations, device cooled down for 15 
minutes between (vdso64+vdso32) runs, 16 runs each averaged on a 
Hikey960, 4.9 kernel, GCC 4.9 -O2 and I get a slightly different story 
(with complete private patch stack that has vdso32):

vdso64

realtime: -4.8% (worse)

monotonic: +1.9% (better)

boottime: +3.2%

vdso32

realtime: +4.7% (better)

monotonic: +3.2%

boottime: +3.7%

The maximum deviation on the sample runs was in the order of +/-1%. I 
can not explain (the highly repeatable anomaly) as to why vdso64 
realtime is slower, yet vdso32 is equally faster. realtime is unique in 
the set as common routine serves for both __vdso_clock_gettime and 
__vdso_gettimeofday, and where I expected the gains (the hunch).

I have tried other combinations of forced inlines to try to cope with 
the clock_gettime(CLOCK_REALTIME) speed, and determined it was almost 
like a slippery tuning exercise. As such, I now come to the conclusion 
that given the (small?) gains, it is better to trust the C compiler 
(especially if this is used by a wider set of architectures) and drop 
this patch (and its side effect for boottime) from the series.

It should be noted on the same test bench that the new C coded vdso64 is 
+2.9% and +11% faster for realtime and monotonic respectively over the 
hand coded assembler it is replacing. Additional props for the C 
compiler doing the "right thing".

-- Mark
