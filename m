From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Mon, 19 Jan 2015 14:52:52 +0530
Subject: RFC on cpufreq implementation
In-Reply-To: <54B7F7CD.7030903@free.fr>
References: <54B7F7CD.7030903@free.fr>
Message-ID: <CAHLCerMq0HnhS3ki3U1te5A8+NiDwpFNL_5_bm-CR4LoYFLo=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 10:54 PM, Mason <mpeg.blue@free.fr> wrote:
> Hello,
>
> This is a follow-up to my previous thread.
> "How many frequencies would cpufreq optimally like to manage?"
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
>
> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
> based SoC (namely Tango4 from Sigma Designs). I'd like to get
> some feedback on the cpufreq driver I wrote for that platform.
>
> I decided to expose only a small subset of frequencies (namely
> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> chose mostly min and max, and the intermediate frequencies not
> so much; so I figured "2 intermediate freqs" is good enough.
> (I'm ready to hear otherwise.)

How many states are really enough depends on the main workloads
running on your system. In a closed system (limited number of
applications) you can easily characterise your workloads and see what
operating points (OPP = voltage, frequency pair) the system spends
most of its time in (CPU_FREQ_STAT_DETAILS) and optimize out the
remaining OPPs.

In an open-ended system where you don't control what applications will
run on the system (e.g. android phone), it is probably a good idea to
expose more OPPs while keeping in mind that exposing 50 frequencies is
probably overkill (and silly) since you're spending more time reaching
the "optimum" OPP. Pick some high-impact ones e.g. ones that allow you
to lower your voltage.

> I tried to use as much generic framework as possible, but I've
> read about the clk framework, and it looks to be an even greater
> generalization. Are new platforms encouraged to use that, rather
> than provide a cpufreq driver? Does it work when voltage scaling
> comes in play? (This SoC doesn't have it, but the next will.)
>
> I'm also wondering how cpufreq and cpuidle interact? Is one a
> subset of the other? Are they orthogonal?

These queries have been answered by Krzysztof.
