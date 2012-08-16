From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 16 Aug 2012 12:21:25 -0500
Subject: imx6q restart is broken
In-Reply-To: <20120816023109.GH2258@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk> <502BBB43.5010403@gmail.com>
 <20120815214412.GC32560@n2100.arm.linux.org.uk>
 <20120816023109.GH2258@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bn1NxMU2Y7O4xQs25yDdBkkcdw+0sdzB3PYvB7vX7+z=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 9:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 15, 2012 at 10:44:12PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Aug 15, 2012 at 10:07:47AM -0500, Rob Herring wrote:
>> > I think I am seeing a similar problem on highbank with a v7 only build.
>> >
>> > >From what I've debugged, restart hangs for me on the L2x0 spinlock
>> > during a writel. Changing the writel to writel_relaxed in the restart
>> > hook fixes the problem. This skips barriers in the writel and for the
>> > spinlock. However, I'm still puzzled as cpu_relax on the secondary cores
>> > should not be doing a dmb in my case on a v7 only build.
>>
>> Well, I had the idea of only doing a dmb() once every N loops, but I don't
>> think we can sensibly introduce such a change into the mainline kernel.
>> (How would cpu_relax() know it's being used in a loop?)
>>
>> Remember that the dmb() is in cpu_relax() as a work-around for the lack
>> of temporal flushing of pending stores, and is needed to make various bits
>> of the kernel work.
>>
> The cpu_relax() will do dmb() only #if __LINUX_ARM_ARCH__ == 6 ||
> defined(CONFIG_ARM_ERRATA_754327).  Otherwise, it's just a barrier()
> call.  I guess Rob's puzzle is since the cpu_relax on the stopped
> cores does not do dmb, why a wmb/mb call on the running cpu would hang
> it.
>
> One thing I note is that mb() will do a outer_sync() call.  Since the
> issue is around L2x0 operation, not sure if they are related ...
>
>> So at the moment, there is no solution for this - and as I've pointed out
>> it can be trivially exploited in userspace on the affected CPUs.  So
>> really a kernel work-around isn't going to sort it.
>
> So, Sascha, it seems we get another good reason to split
> imx_v6_v7_defconfig into imx_v6_defconfig and imx_v7_defconfig?
> I have seen Matt Sealey and Hui Wang suggested doing this already.

Only because Hui suggested it. I figured it would be better from the
standpoint of allowing
proper compiler-generated or more
efficient/architecture-revision-specific code to be
generated. It was mostly because I also have a side nit about
individual erratum being enabled,
in that by default in imx_v6_v7_defconfig they aren't; that's not nice
and it's true of other ARM
platforms too (Tegra notwithstanding). It's unlikely you'd want to run
your chip without these fixes
enabled, but in any kernel built from imx_v6_v7_defconfig it's likely
MX51, MX53 aren't going to
run particularly reliably.

There are a couple options to make it more likely to run with a
working configuration, namely
turning every single one on regardless, or alternatively every mach
defined (SOC_IMX51,
SOC_OMAP or so) or so depends on the errata necessary for correct
operation (just as
ARCH_TEGRA_2x_SOC does right now) so you can still whittle down the number of
compiled-in errata to the CPUs and cache controllers needed to boot
that particular kernel
on the particular boards you chose.

The vast majority are only done on cores that need it, but this
particular one, and a couple
others I noticed, will be enabled in the future on "v7-pure"
multi-platform configs if you just enable
Tegra support with the above solution (since it's not v6, but it is
affected by erratum 754327).

Is there any way to fix cpu_relax(), smp_mb() or whatever to
specifically fix that particular core
or particular A9 revision at runtime rather than having it be
compile-time if we're doing it every few loops,
per-cpu like Catalin suggested? I assume it's not dangerous to do so
(and would mean we don't
run into it on the systems it's not booted on, rather than running
into it by virtue of compiling it in).

I'm not suggesting it fixes the dmb issue Russell described
(especially the userspace part),
but it would mean the kernel won't be issuing them itself under any
circumstance when it
doesn't need to.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
