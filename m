From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Sep 2009 20:02:27 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090920093139.GA1704@n2100.arm.linux.org.uk>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
Message-ID: <20090920190227.GB5413@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2009 at 10:31:39AM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 20, 2009 at 09:39:00AM +0100, Catalin Marinas wrote:
> > I don't think it's recommended to clean the D-cache (and invalidate the
> > I-cache) every time in copy_user_highpage, therefore cache maintenance
> > via mprotect -> change_protection -> flush_cache_range may be a better
> > option.
> 
> I really don't believe so - try it yourself - run some benchmarks on your
> ARMv6 or v7 system, comparing the results both with and without the patch.
> Especially pay attention to the process creation/shell script performance.
> I think you'll find that with your patch, it'll be worse than ARM systems
> running at similar clock rates with VIVT caches.

The figures reveal a 10% reduction in the performance of execve - that's
quite a nasty hit, basically meaning shell scripts will run about 10%
slower (shell scripts typically exec lots of programs.)

Using my proposal measures more favourably - there is no measurable impact
on execve itself (maybe a 0.5% reduction, which I consider to be in the
measurement noise), but a 5.5% reduction in the performance of fork()+exit()
- this is using __cpuc_coherent_kern_range() in
v6_copy_user_highpage_nonaliasing() to ensure the new page is fully
coherent.

Here's my measurements, using the programs from an old version of the
byte benchmarks (not running it as per the benchmark due to the limited
environment on the Realview platform).  Basically, each program was
invoked four times, requesting 30 second runs, and the average taken.

The first two are really for establishing an indication that things are
still as they should be (iow, the hardware isn't playing silly buggers).

Run:
old     b42c634 bf45699 d374bf1 df297bf catalin vma1    vma2    cowcc

Dhrystone 2 RSS=332K:
7640923 7641386 7642194 7639866 7641322 7641308 7640809 7641096 7640737
99.995% 100.00% 100.01% 99.981% 100.00% 100.00% 99.993% 99.997% 99.993%

Pipe based context switching RSS=296K:
246648  244868  244402  242516  248877  248970  237815  246172  247082
99.104% 98.389% 98.202% 97.444% 100.00% 100.04% 95.555% 98.913% 99.279%

fork()+exit() (aka spawn) RSS=292K:
10492   10457   10460   10455   10485   10478   10524   10491   9968
100.07% 99.733% 99.762% 99.714% 100.00% 99.933% 100.37% 100.06% 95.069%

execve() (aka execl) RSS=188K:
2236    2219    2268    2247    2239    2033    2260    2263    2222
99.866% 99.107% 101.30% 100.36% 100.00% 90.799% 100.94% 101.05% 99.241%


The runs are (the board was power cycled before each run):
old - my published tip of tree on Saturday
df297bf - my (slightly modified) prefetch abort fixes (the runs between
    these represent various stages through that work.)
catalin - your patch
vma1 - passing but not using the vma to the copy_user_highpage
    functions.  this appears to be an anomalous run.
vma2 - repeated run
cowcc - adding cache handling to v6_copy_user_highpage_nonaliasing()


One thing I have noticed: it takes the Realview SMP board _two_ attempts
to boot a kernel.  The first attempt tends to cause a spontaneous reboot
when the CLCD controller is enabled, or possibly a hang.  The second
attempt seems to always run fine.
