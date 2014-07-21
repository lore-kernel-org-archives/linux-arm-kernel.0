From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Jul 2014 23:35:09 +0200
Subject: [PATCH 2/2] ARM: tegra: Convert PMC to a driver
In-Reply-To: <53CD8161.2030204@wwwdotorg.org>
References: <1404742610-4951-1-git-send-email-thierry.reding@gmail.com>
 <1404742610-4951-3-git-send-email-thierry.reding@gmail.com>
 <53CD8161.2030204@wwwdotorg.org>
Message-ID: <20140721213508.GC12076@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:08:49PM -0600, Stephen Warren wrote:
> On 07/07/2014 08:16 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit converts the PMC support code to a platform driver. Because
> > the boot process needs to call into this driver very early, set up a
> > minimalistic environment via an early initcall.
> 
> Can we do this without using standalone initcalls? There's no way to
> ensure ordering with initcalls, which seems like it'll be problematic
> once we start converting more stuff.

This driver uses an early_initcall to setup the basic environment
required for SMP. That basic environment will stay intact until the
proper driver takes over the resources sometime at device_initcall
time.

Obviously this type of ordering should only be used for this type of
low-level code that has no other dependencies.

> Instead, can we have some "driver" that binds to the top-level DT node,
> does all the low-/chip-level init, then continues processing the DT? I
> suspect that Pawel's "platform: Make platform_bus device a platform
> device" will help out here. He just posted it today:
> 
> http://www.spinics.net/lists/arm-kernel/msg349328.html

I'm not entirely convinced that this is really necessary. Ideally the
early code should be fairly limited. Given that the ARM64 maintainers
prefer to have SMP handled using a firmware interface this whole
discussion may become moot anyway.

Handling this in firmware is going to create a whole new set of
problems, though, I guess. For instance on Tegra we need to program the
PMC to bring up CPUs. The operations that toggle the power partition
state aren't atomic, so there's always the possibility that firmware
will try to power-up/down a CPU while some other driver is trying to
power-up/down some other partition. How are firmware and kernel supposed
to serialize register accesses?

> > While at it, also move the driver out to drivers/power so that it can be
> > shared with 64-bit SoCs.
> 
> >  arch/arm/mach-tegra/pmc.c       | 402 -----------------
> >  arch/arm/mach-tegra/powergate.c | 503 ---------------------
> 
> >  drivers/power/tegra-pmc.c       | 948 ++++++++++++++++++++++++++++++++++++++++
> 
> It's a bit hard to review this patch because two files at the source
> were merged into one at the destination, and so "git diff -M" couldn't
> detect/represent any changes that happened during the move and highlight
> just those. I assume this just cut/pastes the whole of pmc.c and
> powergate.c into the new tegra-pmc.c without actually changing anything
> much?

Yes, it's simply a cut-and-paste job. Well, there's a slight difference
in what functions are being built. The old code didn't conditionally
build the CONFIG_PM_SLEEP and CONFIG_SMP functions in the driver (though
the prototypes were conditionalized). The new driver restores
consistency. That was to fix randconfig build errors that Arnd reported.

> I wonder if putting the file into drivers/power/ directly makes sense?
> We have "class"-specific sub-directories drivers/power/supply (after
> this series) and drives/power/{avs,reset}/ before. Should we have a
> drivers/power/domain or drivers/power/soc/? instead?

Yeah, moving the code into a subdirectory should be fine. It seemed a
little pointless since there was only one, but if drivers/power
maintainers ever agree to this restructuring I'll happily create another
subdirectory for power domain or SoC power drivers.

> That said, drivers/soc/tegra still feels fine to me for this code...

I agree. At this point in time it's unlikely that we'll be able to come
up with a generic framework to accomodate this driver. Until that time I
don't think it makes sense to move this anywhere else.

But if people insist there shouldn't be a problem to move this out again
since the difficult part of untangling the dependencies is done now, so
it should simply be a matter of doing a git mv and adjusting the Kconfig
and/or Makefile.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/89794850/attachment.sig>
