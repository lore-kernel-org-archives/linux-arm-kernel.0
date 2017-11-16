From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 16 Nov 2017 11:08:11 -0500 (EST)
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <9a4cfa9d-3940-b7f2-5a4d-59e89af85bb7@sigmadesigns.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
 <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
 <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
 <20171115131351.GE31757@n2100.armlinux.org.uk>
 <1fa81694-7bd2-564b-e5b9-ae53b9ea6620@sigmadesigns.com>
 <20171116153625.GJ31757@n2100.armlinux.org.uk>
 <9a4cfa9d-3940-b7f2-5a4d-59e89af85bb7@sigmadesigns.com>
Message-ID: <nycvar.YSQ.7.76.1711161106240.20817@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Nov 2017, Marc Gonzalez wrote:

> On 16/11/2017 16:36, Russell King - ARM Linux wrote:
> > On Thu, Nov 16, 2017 at 04:26:51PM +0100, Marc Gonzalez wrote:
> >> On 15/11/2017 14:13, Russell King - ARM Linux wrote:
> >>
> >>> udelay() needs to offer a consistent interface so that drivers know
> >>> what to expect no matter what the implementation is.  Making one
> >>> implementation conform to your ideas while leaving the other
> >>> implementations with other expectations is a recipe for bugs.
> >>>
> >>> If you really want to do this, fix the loops_per_jiffy implementation
> >>> as well so that the consistency is maintained.
> >>
> >> Hello Russell,
> >>
> >> It seems to me that, when using DFS, there's a serious issue with loop-based
> >> delays. (IIRC, it was you who pointed this out a few years ago.)
> >>
> >> If I'm reading arch/arm/kernel/smp.c correctly, loops_per_jiffy is scaled
> >> when the frequency changes.
> >>
> >> But arch/arm/lib/delay-loop.S starts by loading the current value of
> >> loops_per_jiffy, computes the number of times to loop, and then loops.
> >> If the frequency increases when the core is in __loop_delay, the
> >> delay will be much shorter than requested.
> >>
> >> Is this a correct assessment of the situation?
> > 
> > Absolutely correct, and it's something that people are aware of, and
> > have already catered for while writing their drivers.
> 
> In their cpufreq driver?
> In "real" device drivers that happen to use delays?
> 
> On my system, the CPU frequency may ramp up from 120 MHz to 1.2 GHz.
> If the frequency increases at the beginning of __loop_delay, udelay(100)
> would spin only 10 microseconds. This is likely to cause issues in
> any driver using udelay.
> 
> How does one cater for that?

You make sure your delays are based on a stable hardware timer.
Most platforms nowdays should have a suitable timer source.


Nicolas
