From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 01 Apr 2011 16:28:34 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <201104011554.07924.arnd@arndb.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>	<8ya39m2mv65.fsf@huya.qualcomm.com>
	<20110401074519.GC7594@elte.hu> <201104011554.07924.arnd@arndb.de>
Message-ID: <4D95E112.4020400@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/11 15:54, Arnd Bergmann wrote:

> I would actually suggest a different much more radical start: Fork the way
> that platforms are managed today, and start an alternative way of setting
> up boards and devices together with the proven ARM core kernel infrastructure,
> based on these observations (please correct me if some of them they don't make
> sense):
>
> 1. The core arch code is not a problem (Russell does a great job here)
> 2. The platform specific code contains a lot of crap that doesn't belong there
>     (not enough reviewers to push back on crap)
> 3. The amount of crap in platform specfic files is growing exponentially,
>     despite the best efforts of a handful of people to clean it up.
> 4. Having one source file per board does not scale any more.
> 5. Discoverable hardware would solve this, but is not going to happen
>     in practice.
> 6. Board firmware would not solve this and is usually not present.
> 7. Boot loaders can not be trusted to pass valid information
> 8. Device tree blobs can solve a lot of the problems, and nobody has
>     come up with a better solution.
> 9. All interesting work is going into a handful of platforms, all of which
>     are ARMv7 based.
Define interesting.

> 10. We do not want to discontinue support for old boards that work fine.
> 11. Massive changes to existing platforms would cause massive breakage.
> 12. Supporting many different boards with a single kernel binary is a
>      useful goal.
Generally not for embedded systems (for me, a mobile PDA/phone is just a
small computer with a crappy keyboard, but not an embedded system).

> 13. Infrastructure code should be cross-platform, not duplicated across
>      platforms.
> 14. 32 bit ARM is hitting the wall in the next years (Cortex-A15 is
>      actually adding PAE support, which has failed to solve this on
>      other architectures).
> 15. We need to solve the platform problem before 64 bit support comes
>      and adds another dimension to the complexity.
>
> Based on these assumptions, my preferred strategy would be to a new
> mach-nocrap directory with a documented set of rules (to be adapted when
> necessary):
>
> * Strictly no crap
>   * No board files
Where do you put code that needs to run very early (e.g. pinging the
watchdog)?

>   * No hardcoded memory maps
>   * No lists of interrupts and GPIOs
> * All infrastructure added must be portable to all ARMv7 based SoCs.
>    (ARMv6 can be added later)
> * 64 bit safe code only.
> * SMP safe code only.
> * All board specific information must come from a device tree and
>    be run-time detected.
What do you mean by "run-time detected"?
For powerpc, we currently have the device tree as DTS in the kernel
and compile and bundle it together with the kernel.
As you wrote above: "Discoverable hardware [...] is not going to happen"

> * Must use the same device drivers as existing platforms
> * Should share platform drivers (interrupt controller, gpio, timer, ...)
>    with existing platforms where appropriate.
> * Code quality takes priority over stability in mach-nocrap, but must not
>    break other platforms.

I agree with the general idea, but nailing down the details in a world
as diverse as the ARM world will not be easy...

   Detlef
