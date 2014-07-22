From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 11:27:49 +0100
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <CAOesGMgvd1HbjywN7BDPtr8ZU7vucWH48B=AW3TZjng73YA8WA@mail.gmail.com>
References: <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
 <53C88A4C.3070304@wwwdotorg.org>
 <CAOesGMh+zLV781wzdR5=_Bpzh+XMwJfWL-5XMDP6DwG_Hg80kw@mail.gmail.com>
 <53CD2C58.6060601@wwwdotorg.org> <20140721155451.GF32578@arm.com>
 <53CD4201.5070705@wwwdotorg.org>
 <CAOesGMgvd1HbjywN7BDPtr8ZU7vucWH48B=AW3TZjng73YA8WA@mail.gmail.com>
Message-ID: <20140722102749.GB2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 05:46:02PM +0100, Olof Johansson wrote:
> On Mon, Jul 21, 2014 at 9:38 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 07/21/2014 09:54 AM, Catalin Marinas wrote:
> >> We have a similar issue with arm64 vexpress (well, just on the model)
> >> where vexpress_sysreg_init() is a core_initcall (should be fine as
> >> arch_initcall) as it needs to be done before of_platform_populate().
> >> Pawel on cc should know more of the history here.
> >>
> >> I recall there were also some discussions about a SoC driver model which
> >> hangs off the top compatible string in the DT (e.g. "arm,vexpress") and
> >> allow (minimal) code to be run slightly earlier, though still not
> >> earlier than arch_initcall.
> >
> > I guess that would work out OK; if we force the driver that binds to a
> > top-level compatible value of "nvidia,tegraNNN" to probe first, and it
> > then calls out to all the low-level init code in a sane order, that
> > would solve the problem. I'm not sure that's any better than having a
> > machine descriptor with an "init" function though; wrapping all this in
> > a driver just seems like overhead, but it would work out OK.
> 
> This is exactly the same as having a machine descriptor, but the
> arch/arm64 maintainers don't have to look at it so they don't think it
> is one.
> 
> So now we need to find a place for machine descriptors somewhere under
> drivers/* too. Sigh. Agreed, this is nothing but overhead and
> overabstraction.

You are missing the point. It's not the machine descriptor (or mach-*
directories) I want to hide but rather the need for early SoC specific
initialisation. Always providing a machine descriptor with hooks for
early SoC initialisation does not provide any incentive for people to
think properly about what's early hardware configuration (usually done
by firmware), what's actually needed for CPU booting (SoC-independent
with a secondary booting protocol selectable from a small set) and how
the rest of the SoC fits with the Linux device model. It's also aimed at
pushing back on hardware people who think they can mess up, for example,
a GIC implementation because the rest is just software and you can
always add #ifdefs.

On 32-bit ARM this was not always possible (non-standard essential
peripherals like IRQ controller, timers) but with arm64 we have the
things needed to be able to boot an SoC to arch_initcall level without
any early hooks. I agree that on occasion we may need some early SoC
code just because of some (bad) hardware design or simply to work around
firmware/hardware bugs (and Pawel's patch is a nice approach). But this
should definitely not be the norm and I disagree with moving entire
arch/arm/mach-* code to drivers/soc just because one can't decide where
early SoC initialisation belongs to. Also the legacy firmware argument
doesn't hold for ARMv8/arm64 since the CPU now starts at EL3 in AArch64
mode and you need code there before Linux is invoked (at EL2 or EL1).

In the Tegra fuse case, it's not actually some hardware configuration
that needs to be set up early but rather a driver dependency
initialisation which is not (cannot be) handled by the DT. This is not
that different from the vexpress sysregs mfd where we worked around
using an initcall. It's not ideal, I would prefer something simpler like
sibling DT node sorting during unflattening (or maybe addressing issues
with deferred probing if there are any) rather than working around it
using machine_desc.

-- 
Catalin
